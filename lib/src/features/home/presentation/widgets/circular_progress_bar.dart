import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class CircularProgressBarWidget extends StatelessWidget {
  const CircularProgressBarWidget({
    super.key,
    required this.progressValue,
  });
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73.h,
      width: 390.w,
      decoration: BoxDecoration(
        color: AppColors.greyForBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              AppStrings.monthlyMissonsDone,
            ),
            const Spacer(),
            Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  strokeWidth: 10,
                  value: progressValue,
                  backgroundColor: AppColors.yellow,
                  color: AppColors.primaryColor,
                ),
                Text(
                  '60%',
                  style: AppStyles.s12.copyWith(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
