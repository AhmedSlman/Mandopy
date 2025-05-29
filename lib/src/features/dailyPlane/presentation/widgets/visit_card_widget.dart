import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import 'number_of_visit_row.dart';
import 'visit_item_row_widget.dart';

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
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            height: 300.h,
            width: 389.w,
            decoration: BoxDecoration(
              gradient: isCompleated
                  ? LinearGradient(
                      colors: [
                        AppColors.dailyPlaneItem.withOpacity(0.98),
                        Colors.white.withOpacity(0.98),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    )
                  : LinearGradient(
                      colors: [
                        AppColors.yellow.withOpacity(0.98),
                        Colors.white.withOpacity(0.98),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
              borderRadius: BorderRadius.circular(20.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.07),
                  blurRadius: 16,
                  spreadRadius: 2,
                  offset: const Offset(0, 6),
                ),
              ],
              border: Border.all(
                color: isCompleated
                    ? AppColors.primaryColor.withOpacity(0.15)
                    : AppColors.yellow.withOpacity(0.15),
                width: 1.2,
              ),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 14.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: NumberOfVisitRow(visitNumber: visitNumber),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: 12.w, vertical: 4.h),
                        decoration: BoxDecoration(
                          color: isCompleated
                              ? Colors.green[100]
                              : Colors.orange[100],
                          borderRadius: BorderRadius.circular(12.r),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              isCompleated
                                  ? Icons.check_circle
                                  : Icons.timelapse,
                              color:
                                  isCompleated ? Colors.green : Colors.orange,
                              size: 16.r,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              isCompleated ? 'مكتملة' : 'قيد الانتظار',
                              style: TextStyle(
                                color: isCompleated
                                    ? Colors.green[800]
                                    : Colors.orange[800],
                                fontWeight: FontWeight.w600,
                                fontSize: 12.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  _VisitInfoRow(
                    icon: Icons.local_pharmacy_rounded,
                    label: nameOfGoal,
                    color: AppColors.primaryColor,
                  ),
                  _VisitInfoRow(
                    icon: Icons.location_pin,
                    label: address,
                    color: Colors.redAccent,
                  ),
                  _VisitInfoRow(
                    icon: Icons.medical_services_rounded,
                    label: item,
                    color: Colors.blueAccent,
                  ),
                  _VisitInfoRow(
                    icon: Icons.timer_rounded,
                    label: time,
                    color: Colors.deepPurple,
                  ),
                  SizedBox(height: 10.h),
                  isCompleated
                      ? _VisitInfoRow(
                          icon: Icons.done_rounded,
                          label: "انتهت الساعة 3:20 AM",
                          color: Colors.green,
                        )
                      : Center(
                          child: CustomButton(
                            height: 44.h,
                            width: 160.w,
                            backgroundColor: AppColors.primaryColor,
                            text: 'تفاصيل الزياره',
                            textStyle: AppStyles.s12.copyWith(
                              color: AppColors.white,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
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

class _VisitInfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  const _VisitInfoRow(
      {required this.icon, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 3.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(8.r),
            ),
            padding: EdgeInsets.all(6.r),
            child: Icon(icon, color: color, size: 18.r),
          ),
          SizedBox(width: 10.w),
          Expanded(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 13.5.sp,
                color: Colors.black87,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
