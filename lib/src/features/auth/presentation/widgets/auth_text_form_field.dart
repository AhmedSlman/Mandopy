import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_text_form_field.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class AuthTextFormField extends StatelessWidget {
  const AuthTextFormField({
    super.key,
    this.validator,
    this.hintText,
    required this.titleOfField,
    this.controller,
  });
  final FormFieldValidator<String>? validator;
  final String? hintText;
  final String titleOfField;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 6.h,
            ),
            child: Text(
              titleOfField,
              style: AppStyles.s16,
            ),
          ),
          CustomTextFormField(
            controller: controller,
            hintText: hintText,
            validator: validator,
          )
        ],
      ),
    );
  }
}
