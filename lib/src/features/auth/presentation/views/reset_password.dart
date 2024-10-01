import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/common/widgets/custom_icon_back.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';

class ResetPasswordView extends StatelessWidget {
  const ResetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomIconBackWidget(),
          CustomAppBar(title: AppStrings.resetPassword, padding: 16.h),
          const AuthTextFormField(
            titleOfField: AppStrings.newPassword,
            hintText: AppStrings.hintPassword,
          ),
          const AuthTextFormField(
            titleOfField: AppStrings.confirmNewPassword,
            hintText: AppStrings.hintConfirmPassword,
          ),
          CustomButton(
            text: AppStrings.confirm,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
