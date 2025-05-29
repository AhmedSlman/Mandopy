import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../dailyPlane/cubit/vistiCubit/visit_cubit.dart';
import '../../cubit/doctor_profile/doctor_profile_cubit.dart';
import '../../../location/cubit/location_cubit.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../doctorprofile/presentation/widgets/info_row.dart';

class DoctorInfoContainer extends StatefulWidget {
  final String doctorId;
  final String doctorName;
  final String specialization;
  final String address;
  final String phone;
  final String imageUrl;
  final bool isFavorite;
  final VoidCallback onFavoritePressed;
  final String visitId;

  const DoctorInfoContainer({
    Key? key,
    required this.doctorId,
    required this.doctorName,
    required this.specialization,
    required this.address,
    required this.phone,
    required this.imageUrl,
    required this.isFavorite,
    required this.onFavoritePressed,
    required this.visitId,
  }) : super(key: key);

  @override
  State<DoctorInfoContainer> createState() => _DoctorInfoContainerState();
}

class _DoctorInfoContainerState extends State<DoctorInfoContainer>
    with SingleTickerProviderStateMixin {
  bool isCheckingLocation = false;
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  final TextEditingController _notesController = TextEditingController();
  bool _isVisitStarted = false;

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
    _notesController.dispose();
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

  Future<void> _dismissLoadingDialog(BuildContext context) async {
    if (Navigator.canPop(context)) {
      Navigator.of(context).pop();
    }
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

  Future<void> _handleStartVisit(BuildContext context) async {
    try {
      final locationCubit = context.read<LocationCubit>();
      final visitCubit = context.read<VisitCubit>();

      // Check if visit is already started
      if (visitCubit.isVisitStarted) {
        await _showMessage(context, 'الزيارة قد بدأت بالفعل!');
        return;
      }

      // Show loading dialog
      setState(() {
        isCheckingLocation = true;
      });
      await _showLoadingDialog(context);

      // Check location
      await locationCubit.checkDoctorLocation(widget.doctorId);
      final locationState = locationCubit.state;

      // Handle location check result
      if (locationState is LocationCheckSuccess) {
        await _dismissLoadingDialog(context);
        setState(() {
          isCheckingLocation = false;
        });

        if (locationState.isInCorrectLocation) {
          // Start visit
          visitCubit.startVisit(widget.visitId);
          await _showMessage(context, 'تم بدء الزيارة بنجاح!');
        } else {
          await _showMessage(
            context,
            "أنت بعيد عن الموقع بمقدار ${locationState.distance.toStringAsFixed(2)} متر. يجب أن تكون في نطاق 20 متر من الموقع.",
          );
        }
      } else if (locationState is LocationFailure) {
        await _dismissLoadingDialog(context);
        setState(() {
          isCheckingLocation = false;
        });
        await _showMessage(context, locationState.message);
      }
    } catch (e) {
      await _dismissLoadingDialog(context);
      setState(() {
        isCheckingLocation = false;
      });
      await _showMessage(context, 'حدث خطأ أثناء التحقق من الموقع');
    }
  }

  Future<void> _handleEndVisit(BuildContext context) async {
    try {
      final visitCubit = context.read<VisitCubit>();

      // Check if visit is started
      if (!visitCubit.isVisitStarted) {
        await _showMessage(context, "لا يمكنك إنهاء الزيارة قبل بدءها.");
        return;
      }

      // Show sale confirmation dialog
      bool? saleMade = await showDialog<bool>(
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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.grey[200],
                          foregroundColor: Colors.black87,
                          padding: EdgeInsets.symmetric(
                            horizontal: 24.w,
                            vertical: 12.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.r),
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
                        onPressed: () => Navigator.of(context).pop(true),
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
        // Show loading dialog
        setState(() {
          isCheckingLocation = true;
        });
        await _showLoadingDialog(context);

        // End visit
        visitCubit.endVisit(
          widget.visitId,
          saleMade ? "1" : "0",
        );

        await _dismissLoadingDialog(context);
        setState(() {
          isCheckingLocation = false;
        });

        await _showMessage(
          context,
          saleMade
              ? "تم إنهاء الزيارة مع تأكيد البيع."
              : "تم إنهاء الزيارة بدون بيع.",
        );
      }
    } catch (e) {
      await _dismissLoadingDialog(context);
      setState(() {
        isCheckingLocation = false;
      });
      await _showMessage(context, 'حدث خطأ أثناء إنهاء الزيارة');
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) async {
        if (state is LocationLoading) {
          if (!isCheckingLocation) {
            setState(() {
              isCheckingLocation = true;
            });
            await _showLoadingDialog(context);
          }
        } else if (state is LocationCheckSuccess) {
          await _dismissLoadingDialog(context);
          setState(() {
            isCheckingLocation = false;
          });

          if (state.isInCorrectLocation) {
            await _showMessage(
              context,
              "أنت في الموقع الصحيح. المسافة: ${state.distance.toStringAsFixed(2)} متر.",
            );
          } else {
            await _showMessage(
              context,
              "أنت بعيد عن الموقع بمقدار ${state.distance.toStringAsFixed(2)} متر. يجب أن تكون في نطاق 20 متر من الموقع.",
            );
          }
        } else if (state is LocationFailure) {
          await _dismissLoadingDialog(context);
          setState(() {
            isCheckingLocation = false;
          });
          String message = state.message;
          if (message.contains("إذن الموقع")) {
            message = "برجاء تفعيل إذن الموقع لاستخدام هذه الخاصية.";
          }
          await _showMessage(context, message);
        }
      },
      child: Container(
        width: 373.w,
        margin: EdgeInsets.only(left: 8.h),
        padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 26.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18.r),
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
        child: BlocBuilder<DoctorProfileCubit, DoctorProfileState>(
          builder: (context, state) {
            if (state is DoctorProfileLoading) {
              return Center(
                child: CircularProgressIndicator(
                  strokeWidth: 3,
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                ),
              );
            }
            if (state is DoctorProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(15)),
                        child: Image.network(
                          widget.imageUrl,
                          height: 200,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              Container(
                            height: 200,
                            color: Colors.grey[300],
                            child: const Icon(
                              Icons.person,
                              size: 100,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: IconButton(
                          onPressed: widget.onFavoritePressed,
                          icon: Icon(
                            widget.isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color:
                                widget.isFavorite ? Colors.red : Colors.white,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.doctorName,
                          style: AppStyles.s24.copyWith(
                            color: AppColors.textColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        _buildInfoSection(
                          icon: Icons.person_outline,
                          title: 'الاسم',
                          content: state.doctorProfileModel.name ?? 'N/A',
                        ),
                        SizedBox(height: 16.h),
                        _buildInfoSection(
                          icon: Icons.location_on_outlined,
                          title: 'العنوان',
                          content: state.doctorProfileModel.address ?? 'N/A',
                        ),
                        SizedBox(height: 16.h),
                        _buildInfoSection(
                          icon: Icons.phone_outlined,
                          title: 'رقم الهاتف',
                          content: state.doctorProfileModel.phone ?? 'N/A',
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
                              onPressed: () => _handleStartVisit(context),
                            ),
                            SizedBox(width: 16.w),
                            _buildActionButton(
                              text: 'انهاء الزيارة',
                              backgroundColor: AppColors.accentColor,
                              onPressed: () => _handleEndVisit(context),
                            ),
                          ],
                        ),
                      ],
                    ),
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
