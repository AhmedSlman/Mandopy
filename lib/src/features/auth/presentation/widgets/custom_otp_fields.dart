import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';

class CustomOTPFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final FormFieldValidator<String>? validator;

  const CustomOTPFields({
    super.key,
    required this.controllers,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 16.0.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(6, (index) {
          return SizedBox(
            width: 50.w,
            child: TextFormField(
              controller: controllers[index],
              obscureText: false,
              maxLength: 1,
              textAlign: TextAlign.center,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15.0.w,
                  horizontal: 16.0.w,
                ),
                fillColor: AppColors.lightGrey,
                filled: true,
                border: InputBorder.none,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.lightGrey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: AppColors.primaryColor),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                counterText: '',
              ),
              keyboardType: TextInputType.number,
              validator: validator ?? (value) => null,
              onChanged: (value) {
                if (value.isNotEmpty && index < controllers.length - 1) {
                  FocusScope.of(context).nextFocus();
                }
              },
            ),
          );
        }),
      ),
    );
  }
}
