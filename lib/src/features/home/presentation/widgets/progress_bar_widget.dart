import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required this.progress,
  });
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73.h,
      width: 390.w,
      decoration: BoxDecoration(
        color: AppColors.greyForBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.0),
            child: Text(AppStrings.dailyMissonsDone),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 8.h),
            child: Stack(
              children: [
                LinearProgressIndicator(
                  minHeight: 30.h,
                  value: progress,
                  backgroundColor: AppColors.yellow,
                  color: AppColors.primaryColor,
                ),
                Positioned(
                  right: 90.w,
                  top: 5,
                  child: Text(
                    '60% مكتمل',
                    style: AppStyles.s12.copyWith(
                      color: AppColors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
