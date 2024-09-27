import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class HaveAnAccountWidget extends StatelessWidget {
  const HaveAnAccountWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10.h),
      child: GestureDetector(
        onTap: () {
          print("WWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWWW");
        },
        child: RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: AppStrings.haveAnAccoun,
                style: AppStyles.s14,
              ),
              TextSpan(
                text: AppStrings.signIn,
                style: AppStyles.s16.copyWith(
                  color: AppColors.accentColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
