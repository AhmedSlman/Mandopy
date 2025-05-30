import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class ProgressBarWidget extends StatelessWidget {
  const ProgressBarWidget({
    super.key,
    required this.progress,
  });
  final double progress;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 0.w, vertical: 10.h),
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
          Text(
            'التقدم اليومي',
            style: AppStyles.s16.copyWith(
              color: AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            'قمت بتحقيق ${(progress * 100).toStringAsFixed(0)}% من هدفك اليومي',
            style: AppStyles.s14.copyWith(
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 8.h),
          LinearProgressIndicator(
            minHeight: 12.h,
            value: progress,
            backgroundColor: AppColors.greyForBackground,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accentColor),
            borderRadius: BorderRadius.circular(6.r),
          ),
          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}
