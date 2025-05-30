import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/utils/app_styles.dart';
import 'package:skeletonizer/skeletonizer.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../cubit/percentage/cubit/percentage_cubit.dart';
import '../../../../core/theme/app_styles.dart';

class CircularProgressBarWidget extends StatelessWidget {
  const CircularProgressBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      child: BlocBuilder<PercentageCubit, PercentageState>(
        builder: (context, state) {
          if (state is PercentageLoading) {
            return Skeletonizer(
              containersColor: Colors.grey.shade300,
              enabled: true,
              child: Container(
                height: 180.h,
                decoration: BoxDecoration(
                  color: Colors.grey.shade300,
                  borderRadius: BorderRadius.circular(16.r),
                ),
              ),
            );
          }
          if (state is MonthlyTargetLoaded) {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'الاهداف الشهريه',
                              style: AppStyles.s14.copyWith(
                                fontWeight: FontWeight.w500,
                                color: Colors.grey[600],
                              ),
                            ),
                            SizedBox(height: 4.h),
                            Text(
                              "${state.montlyTargetModel.monthlyTarget} زياره",
                              style: AppStyles.s16.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 20.w),
                      SizedBox(
                        width: 80.w,
                        height: 80.h,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            CircularProgressIndicator(
                              strokeWidth: 8,
                              strokeAlign: 8,
                              value: double.parse(state
                                          .montlyTargetModel.percentage
                                          ?.replaceAll('%', '') ??
                                      "0") /
                                  100,
                              backgroundColor: AppColors.greyForBackground,
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                  AppColors.accentColor),
                            ),
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  state.montlyTargetModel.percentage ?? "0%",
                                  style: AppStyles.s20.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: AppColors.primaryColor,
                                  ),
                                ),
                                Text(
                                  'مكتمل',
                                  style: AppStyles.s12.copyWith(
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
                            'حافظ علي العمل الجيد \،تابع تقدمك للهدف الشهري.',
                            style: AppStyles.s12.copyWith(
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          } else {
            return Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Icon(Icons.error_outline,
                      color: AppColors.errorColor, size: 24.r),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Text(
                      'Failed to load monthly target.',
                      style: AppStyles.s14.copyWith(
                        color: AppColors.errorColor,
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
