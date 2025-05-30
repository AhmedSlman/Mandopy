import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/daily_goals_title.dart';
import '../widgets/progress_bar_widget.dart';

import '../../cubit/percentage/cubit/percentage_cubit.dart';

class DailyGoalsSection extends StatelessWidget {
  const DailyGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Icon(
                Icons.flag_circle,
                color: AppColors.primaryColor,
                size: 24.r,
              ),
              SizedBox(width: 8.w),
              const Expanded(
                child: GoalsTitle(
                  title: AppStrings.dailyGoals,
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        BlocBuilder<PercentageCubit, PercentageState>(
          builder: (context, state) {
            if (state is PercentageLoading) {
              return Skeletonizer(
                containersColor: Colors.grey.shade300,
                enabled: true,
                child: const ProgressBarWidget(progress: 0.0),
              );
            } else if (state is PercentageLoaded) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'التقدم اليومي',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 8.h),
                  ProgressBarWidget(progress: state.value / 100),
                  SizedBox(height: 8.h),
                  Text(
                    '${state.value.toStringAsFixed(0)}% مكتمل',
                    style: TextStyle(
                      fontSize: 12.sp,
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              );
            } else if (state is PercentageError) {
              return Container(
                padding: EdgeInsets.all(12.r),
                decoration: BoxDecoration(
                  color: Colors.red.shade50,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Row(
                  children: [
                    Icon(Icons.error_outline, color: Colors.red, size: 20.r),
                    SizedBox(width: 8.w),
                    Expanded(
                      child: Text(
                        state.error.message,
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 12.sp,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const ProgressBarWidget(progress: 0.0);
            }
          },
        ),
      ],
    );
  }
}
