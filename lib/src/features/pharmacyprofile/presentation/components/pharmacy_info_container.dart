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

class _PharmacyInfoContainerState extends State<PharmacyInfoContainer> {
  bool isCheckingLocation = false;

  Future<void> _showLoadingDialog(BuildContext context) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return const AlertDialog(
          content: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              SizedBox(width: 16),
              Text("جارٍ التحقق من الموقع..."),
            ],
          ),
        );
      },
    );
  }

  void _dismissLoadingDialog(BuildContext context) {
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationCubit, LocationState>(
      listener: (context, state) async {
        if (state is LocationLoading) {
          await _showLoadingDialog(context);
        } else {
          _dismissLoadingDialog(context);

          if (state is LocationSuccess) {
            await _showMessage(context, state.message);
          } else if (state is LocationFailure) {
            await _showMessage(context, state.message);
          } else if (state is LocationCheckSuccess) {
            await _showMessage(context, state.message);
          }
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
              color: Colors.black12,
              blurRadius: 2.h,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: BlocBuilder<PharmacyProfileCubit, PharmacyProfileState>(
          builder: (context, state) {
            if (state is PharmacyProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is PharmacyProfileLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: state.pharmacyProfileModel.name ?? 'N/A',
                  ),
                  const SizedBox(height: 15),
                  InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: state.pharmacyProfileModel.address ?? 'N/A',
                  ),
                  const SizedBox(height: 15),
                  InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: state.pharmacyProfileModel.phone ?? 'N/A',
                  ),
                  const SizedBox(height: 15),
                  const InfoRow(
                    infoIcon: AppAssets.inVisit,
                    infoText: 'طوال الاسبوع',
                  ),
                  const SizedBox(height: 21),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      CustomButton(
                        width: 100.w,
                        height: 30.h,
                        text: 'بدء الزيارة',
                        textStyle: AppStyles.s12.copyWith(
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          final locationCubit = context.read<LocationCubit>();
                          final visitCubit = context.read<VisitCubit>();

                          await locationCubit
                              .checkPharmacyLocation(widget.pharmacyId);
                          final locationState = locationCubit.state;

                          if (locationState is LocationCheckSuccess) {
                            if (locationState.isInCorrectLocation) {
                              if (!visitCubit.isVisitStarted) {
                                visitCubit.startVisit(widget.visitId);
                                await _showMessage(
                                    context, 'تم بدء الزيارة بنجاح!');
                              } else {
                                await _showMessage(
                                    context, 'الزيارة قد بدأت بالفعل!');
                              }
                            } else {
                              await _showMessage(
                                context,
                                "أنت بعيد عن الموقع بمقدار ${locationState.distance.toStringAsFixed(2)} متر.",
                              );
                            }
                          } else if (locationState is LocationFailure) {
                            await _showMessage(context, locationState.message);
                          }
                        },
                      ),
                      const SizedBox(width: 16),
                      CustomButton(
                        backgroundColor: AppColors.accentColor,
                        width: 100.w,
                        height: 30.h,
                        text: 'انهاء الزيارة',
                        textStyle: AppStyles.s12.copyWith(
                          color: Colors.white,
                        ),
                        onPressed: () async {
                          if (!context.read<VisitCubit>().isVisitStarted) {
                            await _showMessage(
                                context, "لا يمكنك إنهاء الزيارة قبل بدءها.");
                            return;
                          }

                          bool? saleMade = await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                title: const Text("بيع المنتج"),
                                content: const Text("هل قمت ببيع المنتج؟"),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(false),
                                    child: const Text("لا"),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.of(context).pop(true),
                                    child: const Text("نعم"),
                                  ),
                                ],
                              );
                            },
                          );
                          if (saleMade != null) {
                            context
                                .read<VisitCubit>()
                                .endVisit(widget.visitId, saleMade ? "1" : "0");
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
                  )
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

  Future<void> _showMessage(BuildContext context, String message) async {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text("موافق"),
            ),
          ],
        );
      },
    );
  }
}
