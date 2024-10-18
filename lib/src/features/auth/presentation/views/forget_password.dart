import 'package:flutter/material.dart';
import 'package:mandopy/core/common/functions/validator.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/common/widgets/custom_icon_back.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/forget_password_message.dart';

class ForgetPasswordView extends StatelessWidget {
  const ForgetPasswordView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const CustomIconBackWidget(),
          const CustomAppBar(title: AppStrings.forgetPassword, padding: 16),
          const ForgetPasswordMessage(
            message: AppStrings.forgetPasswordMessage,
          ),
          const AuthTextFormField(
            titleOfField: AppStrings.email,
            hintText: AppStrings.emailHint,
            validator: Validator.validateEmail,
          ),
          CustomButton(
            text: AppStrings.send,
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
