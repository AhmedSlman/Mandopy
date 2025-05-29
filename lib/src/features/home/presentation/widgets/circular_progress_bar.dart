import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../cubit/percentage/cubit/percentage_cubit.dart';

class CircularProgressBarWidget extends StatelessWidget {
  const CircularProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      child: BlocBuilder<PercentageCubit, PercentageState>(
        builder: (context, state) {
          if (state is PercentageLoading) {
            return Skeletonizer(
              containersColor: Colors.grey.shade300,
              enabled: true,
              child: Container(
                color: Colors.grey.shade300,
              ),
            );
          }
          if (state is MonthlyTargetLoaded) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Monthly Target',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w500,
                              color: Colors.grey[600],
                            ),
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "${state.montlyTargetModel.monthlyTarget} visits",
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 100.w,
                      height: 100.h,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          CircularProgressIndicator(
                            strokeWidth: 12,
                            value: double.parse(state
                                        .montlyTargetModel.percentage
                                        ?.replaceAll('%', '') ??
                                    "0") /
                                100,
                            backgroundColor: Colors.grey.shade200,
                            color: AppColors.primaryColor,
                          ),
                          Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                state.montlyTargetModel.percentage ?? "0%",
                                style: TextStyle(
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.primaryColor,
                                ),
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.h),
                Container(
                  padding: EdgeInsets.all(12.r),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline,
                        color: AppColors.primaryColor,
                        size: 20.r,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: Text(
                          'Keep up the good work! You\'re making great progress towards your monthly goal.',
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: AppColors.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return Container(
              padding: EdgeInsets.all(12.r),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline, color: Colors.grey, size: 20.r),
                  SizedBox(width: 8.w),
                  Expanded(
                    child: Text(
                      'No data available',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
