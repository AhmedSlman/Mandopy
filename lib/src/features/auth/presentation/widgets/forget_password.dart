import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton(
      {super.key, this.onPressed, required this.text, this.alignment});
  final VoidCallback? onPressed;
  final String text;
  final AlignmentGeometry? alignment;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.0.w),
      child: GestureDetector(
        onTap: onPressed,
        child: Align(
          alignment: alignment ?? Alignment.centerLeft,
          child: Text(
            text,
          ),
        ),
      ),
    );
  }
}
