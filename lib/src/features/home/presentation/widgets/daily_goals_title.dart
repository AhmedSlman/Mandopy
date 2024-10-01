import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class GoalsTitle extends StatelessWidget {
  const GoalsTitle({
    super.key,
    required this.title,
    this.hent,
  });
  final String title;
  final String? hent;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Row(
        children: [
          Text(
            title,
            style: AppStyles.s18,
          ),
          const Spacer(),
          Text(
            hent ?? "",
            style: AppStyles.s16.copyWith(
              color: AppColors.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
