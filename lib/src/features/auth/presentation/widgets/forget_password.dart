import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/utils/app_strings.dart';

class ForgetPasswordWidget extends StatelessWidget {
  const ForgetPasswordWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
      child: const Align(
        alignment: Alignment.centerLeft,
        child: Text(
          AppStrings.forgetPassword,
        ),
      ),
    );
  }
}
