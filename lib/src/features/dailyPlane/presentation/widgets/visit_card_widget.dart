import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_styles.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/widgets/number_of_visit_row.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/widgets/visit_item_row_widget.dart';

import '../../../../../core/routes/router_names.dart';
import '../../cubit/vistiCubit/visit_cubit.dart';
import '../../cubit/vistiCubit/visit_state.dart';

class VisitCardWidget extends StatelessWidget {
  final String visitId;
  final String visitNumber;
  final String nameOfGoal;
  final String address;
  final String time;
  final String item;
  final bool isPharmacy;
  final bool isCompleated;
  final String pharmacyid;
  final String doctorId;

  const VisitCardWidget({
    super.key,
    required this.visitId,
    required this.visitNumber,
    required this.nameOfGoal,
    required this.address,
    required this.time,
    required this.item,
    this.isPharmacy = true,
    required this.isCompleated,
    required this.pharmacyid,
    required this.doctorId,
  });

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisitCubit, VisitState>(
      listener: (context, state) {
        if (state is VisitStarted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.message)),
          );
        } else if (state is VisitEnded) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                  "${state.endVisitResponse.message} You earned ${state.endVisitResponse.pointsEarned} points!"),
            ),
          );
        } else if (state is VisitError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An error occurred: ${state.error}")),
          );
        }
      },
      child: Padding(
        padding: EdgeInsets.only(left: 6.w, right: 6.w, bottom: 16.h),
        child: GestureDetector(
          onTap: () => isPharmacy
              ? GoRouter.of(context).push(
                  RouterNames.pharmacyProfile,
                  extra: {
                    'visitId': visitId,
                    'pharmacyId': pharmacyid,
                  },
                )
              : GoRouter.of(context).push(
                  RouterNames.doctorProfile,
                  extra: {
                    'visitId': visitId,
                    'doctorId': doctorId,
                  },
                ),
          child: Container(
            height: 262.82.h,
            width: 389.w,
            decoration: BoxDecoration(
              color: isCompleated ? AppColors.dailyPlaneItem : AppColors.yellow,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  NumberOfVisitRow(visitNumber: visitNumber),
                  VisitItemRowWidget(
                    title: nameOfGoal,
                    icon: Icons.local_pharmacy_rounded,
                  ),
                  VisitItemRowWidget(
                    title: address,
                    icon: Icons.location_pin,
                  ),
                  VisitItemRowWidget(
                    title: item,
                    icon: Icons.medical_services_rounded,
                  ),
                  VisitItemRowWidget(
                    title: time,
                    icon: Icons.timer_rounded,
                  ),
                  isCompleated
                      ? const VisitItemRowWidget(
                          title: "انتهت الساعة 3:20 AM",
                          icon: Icons.done_rounded,
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomButton(
                              height: 40.h,
                              width: 120.w,
                              text: 'تفاصيل الزياره',
                              textStyle: AppStyles.s12.copyWith(
                                color: AppColors.white,
                                fontSize: 14,
                              ),
                              onPressed: () {
                                isPharmacy
                                    ? GoRouter.of(context).push(
                                        RouterNames.pharmacyProfile,
                                        extra: {
                                          'visitId': visitId,
                                          'pharmacyId': pharmacyid,
                                        },
                                      )
                                    : GoRouter.of(context).push(
                                        RouterNames.doctorProfile,
                                        extra: {
                                          'visitId': visitId,
                                          'doctorId': doctorId,
                                        },
                                      );
                              },
                            ),
                            SizedBox(width: 8.w),
                            // CustomButton(
                            //   height: 30.h,
                            //   width: 100.w,
                            //   backgroundColor: AppColors.accentColor,
                            //   text: 'انهاء الزياره',
                            //   textStyle: AppStyles.s12.copyWith(
                            //     color: AppColors.white,
                            //   ),
                            //   onPressed: () async {
                            //     bool? saleMade = await showDialog(
                            //       context: context,
                            //       builder: (BuildContext context) {
                            //         return AlertDialog(
                            //           title: const Text("بيع المنتج"),
                            //           content: const Text("هل قمت ببيع المنتج"),
                            //           actions: [
                            //             TextButton(
                            //               onPressed: () =>
                            //                   Navigator.of(context).pop(false),
                            //               child: const Text("No"),
                            //             ),
                            //             TextButton(
                            //               onPressed: () =>
                            //                   Navigator.of(context).pop(true),
                            //               child: const Text("Yes"),
                            //             ),
                            //           ],
                            //         );
                            //       },
                            //     );
                            //     if (saleMade != null) {
                            //       context
                            //           .read<VisitCubit>()
                            //           .endVisit(visitId, saleMade ? "1" : "0");
                            //     }
                            //   },
                            // ),
                          ],
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
