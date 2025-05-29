import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

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
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 8.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: AppStyles.s18,
            ),
            if (hent != null)
              Text(
                hent!,
                style: AppStyles.s16.copyWith(
                  color: AppColors.accentColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
