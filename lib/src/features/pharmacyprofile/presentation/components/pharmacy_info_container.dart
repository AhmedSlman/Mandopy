// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/utils/app_styles.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/vistiCubit/visit_cubit.dart';
import 'package:mandopy/src/features/location/cubit/location_cubit.dart';
import 'package:mandopy/src/features/pharmacyprofile/cubit/pharmacy_profile_cubit.dart';
import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../doctorprofile/presentation/widgets/info_row.dart';

class PharmacyInfoContainer extends StatefulWidget {
  const PharmacyInfoContainer(
      {super.key, required this.pharmacyId, required this.visitId});
  final String pharmacyId;
  final String visitId;

  @override
  _PharmacyInfoContainerState createState() => _PharmacyInfoContainerState();
}

class _PharmacyInfoContainerState extends State<PharmacyInfoContainer>
    with SingleTickerProviderStateMixin {
  bool isCheckingLocation = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: 40.w,
                  height: 40.w,
                  child: CircularProgressIndicator(
                    strokeWidth: 3,
                    valueColor:
                        AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                  ),
                ),
                SizedBox(height: 16.h),
                Text(
                  "جارٍ التحقق من الموقع...",
                  style: AppStyles.s14.copyWith(
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _dismissLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  Future<void> _showMessage(BuildContext context, String message) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          elevation: 0,
          child: Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.info_outline,
                  size: 40.w,
                  color: AppColors.primaryColor,
                ),
                SizedBox(height: 16.h),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: AppStyles.s14.copyWith(
                    color: Colors.black87,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 24.h),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(),
                  style: TextButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 12.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  child: Text(
                    "موافق",
                    style: AppStyles.s14.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) async {
        if (state is LocationLoading && !isCheckingLocation) {
          setState(() {
            isCheckingLocation = true;
          });
          await _showLoadingDialog(context);
        } else if (state is LocationCheckSuccess) {
          _dismissLoadingDialog(context);
          setState(() {
            isCheckingLocation = false;
          });
          if (state.isInCorrectLocation) {
            final visitCubit = context.read<VisitCubit>();
            if (!visitCubit.isVisitStarted) {
              visitCubit.startVisit(widget.visitId);
              await _showMessage(context, 'تم بدء الزيارة بنجاح!');
            } else {
              await _showMessage(context, 'الزيارة قد بدأت بالفعل!');
            }
          } else {
            await _showMessage(
              context,
              "أنت بعيد عن الموقع بمقدار ${state.distance.toStringAsFixed(2)} متر.",
            );
          }
        } else if (state is LocationFailure) {
          _dismissLoadingDialog(context);
          setState(() {
            isCheckingLocation = false;
          });
          await _showMessage(context, state.message);
        }
      },
      child: Container(
        width: 373.w,
        height: 340.h,
        margin: EdgeInsets.only(left: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 26.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(
            color: const Color.fromRGBO(247, 247, 247, 1),
            width: 1.h,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BlocBuilder<PharmacyProfileCubit, PharmacyProfileState>(
          builder: (context, state) {
            if (state is PharmacyProfileLoading) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              );
            }
            if (state is PharmacyProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoSection(
                    icon: Icons.store_outlined,
                    title: 'اسم الصيدلية',
                    content: state.pharmacyProfileModel.name ?? 'N/A',
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoSection(
                    icon: Icons.location_on_outlined,
                    title: 'العنوان',
                    content: state.pharmacyProfileModel.address ?? 'N/A',
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoSection(
                    icon: Icons.phone_outlined,
                    title: 'رقم الهاتف',
                    content: state.pharmacyProfileModel.phone ?? 'N/A',
                  ),
                  SizedBox(height: 16.h),
                  _buildInfoSection(
                    icon: Icons.calendar_today_outlined,
                    title: 'مواعيد العمل',
                    content: 'طوال الاسبوع',
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      _buildActionButton(
                        text: 'بدء الزيارة',
                        backgroundColor: AppColors.primaryColor,
                        onPressed: () async {
                          _animationController.forward().then((_) {
                            _animationController.reverse();
                          });
                          final locationCubit = context.read<LocationCubit>();
                          await locationCubit
                              .checkPharmacyLocation(widget.pharmacyId);
                        },
                      ),
                      SizedBox(width: 16.w),
                      _buildActionButton(
                        text: 'انهاء الزيارة',
                        backgroundColor: AppColors.accentColor,
                        onPressed: () async {
                          _animationController.forward().then((_) {
                            _animationController.reverse();
                          });
                          if (!context.read<VisitCubit>().isVisitStarted) {
                            await _showMessage(
                                context, "لا يمكنك إنهاء الزيارة قبل بدءها.");
                            return;
                          }

                          bool? saleMade = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return Dialog(
                                backgroundColor: Colors.transparent,
                                elevation: 0,
                                child: Container(
                                  padding: EdgeInsets.all(24.w),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(16.r),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.1),
                                        blurRadius: 10,
                                        offset: const Offset(0, 4),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        "بيع المنتج",
                                        style: AppStyles.s16.copyWith(
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.primaryColor,
                                        ),
                                      ),
                                      SizedBox(height: 16.h),
                                      Text(
                                        "هل قمت ببيع المنتج؟",
                                        style: AppStyles.s14.copyWith(
                                          color: Colors.black87,
                                        ),
                                      ),
                                      SizedBox(height: 24.h),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context)
                                                    .pop(false),
                                            style: TextButton.styleFrom(
                                              backgroundColor: Colors.grey[200],
                                              foregroundColor: Colors.black87,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 24.w,
                                                vertical: 12.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                            ),
                                            child: Text(
                                              "لا",
                                              style: AppStyles.s14.copyWith(
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                          SizedBox(width: 16.w),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.of(context).pop(true),
                                            style: TextButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.primaryColor,
                                              foregroundColor: Colors.white,
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 24.w,
                                                vertical: 12.h,
                                              ),
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(8.r),
                                              ),
                                            ),
                                            child: Text(
                                              "نعم",
                                              style: AppStyles.s14.copyWith(
                                                color: Colors.white,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                          if (saleMade != null) {
                            context.read<VisitCubit>().endVisit(
                                  widget.visitId,
                                  saleMade ? "1" : "0",
                                );
                            await _showMessage(
                              context,
                              saleMade
                                  ? "تم إنهاء الزيارة مع تأكيد البيع."
                                  : "تم إنهاء الزيارة بدون بيع.",
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppColors.primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Icon(
            icon,
            size: 20.w,
            color: AppColors.primaryColor,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: AppStyles.s12.copyWith(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                content,
                style: AppStyles.s14.copyWith(
                  color: Colors.black87,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton({
    required String text,
    required Color backgroundColor,
    required VoidCallback onPressed,
  }) {
    return ScaleTransition(
      scale: _scaleAnimation,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(8.r),
          child: Ink(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: BorderRadius.circular(8.r),
              boxShadow: [
                BoxShadow(
                  color: backgroundColor.withOpacity(0.3),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 8.h,
              ),
              child: Text(
                text,
                style: AppStyles.s14.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
