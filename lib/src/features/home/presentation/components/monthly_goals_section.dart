import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../widgets/circular_progress_bar.dart';
import '../widgets/daily_goals_title.dart';

class MonthlyGoalsSection extends StatelessWidget {
  const MonthlyGoalsSection({super.key});

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
                Icons.calendar_month,
                color: AppColors.primaryColor,
                size: 24.r,
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  AppStrings.monthlyGoals,
                  style: TextStyle(
                    fontSize: 18.sp,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87,
                    fontFamily: 'Cairo',
                    height: 1.4,
                    letterSpacing: 0.3,
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 16.h),
        Container(
          padding: EdgeInsets.all(16.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.grey.shade200,
              width: 1,
            ),
          ),
          child: const CircularProgressBarWidget(),
        ),
      ],
    );
  }
}
