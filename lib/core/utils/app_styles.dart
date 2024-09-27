import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';

class AppStyles {
  static TextStyle s24 = TextStyle(
    fontSize: 24.sp,
    fontWeight: FontWeight.w600,
    color: AppColors.primaryColor,
  );

  static TextStyle s20 = TextStyle(
    fontSize: 20.0.sp,
    fontWeight: FontWeight.w400,
    color: AppColors.white,
  );

  static const TextStyle subtitle1 = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.w500,
    color: Colors.black54,
  );

  static TextStyle s16 = TextStyle(
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.greyForText,
  );
  static TextStyle s14 = TextStyle(
    fontSize: 14.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.greyForText,
  );
  static TextStyle s12 = TextStyle(
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w500,
    color: AppColors.grey,
  );
}
