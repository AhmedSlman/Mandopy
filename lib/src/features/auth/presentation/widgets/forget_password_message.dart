import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';

class ForgetPasswordMessage extends StatelessWidget {
  const ForgetPasswordMessage({
    super.key,
    required this.message,
  });
  final String message;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Text(
        message,
        style: AppStyles.s14,
        textAlign: TextAlign.center,
      ),
    );
  }
}
