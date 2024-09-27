import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    super.key,
    required this.title,
    this.iconleft,
    this.iconright,
    this.onPressedLeft,
    this.onPressedRight,
  });
  final String title;
  final IconData? iconleft;
  final IconData? iconright;
  final VoidCallback? onPressedLeft;
  final VoidCallback? onPressedRight;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 70.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            onPressed: onPressedLeft,
            icon: Icon(
              iconleft,
              color: AppColors.primaryColor,
            ),
          ),
          Text(
            title,
            style: AppStyles.s24,
          ),
          IconButton(
            onPressed: onPressedRight,
            icon: Icon(
              iconright,
              color: AppColors.primaryColor,
            ),
          ),
        ],
      ),
    );
  }
}
