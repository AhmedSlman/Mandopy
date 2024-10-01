import 'package:flutter/material.dart';
import 'package:mandopy/core/common/functions/validator.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/forget_password.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/have_an%20_account_widget.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthTextFormField(
          titleOfField: AppStrings.email,
          hintText: AppStrings.emailHint,
          validator: Validator.validateEmail,
          
        ),
        const AuthTextFormField(
          titleOfField: AppStrings.password,
          hintText: AppStrings.hintPassword,
          validator: Validator.validatePassword,
        ),
        const CustomTextButton(
          text: AppStrings.forgetPassword,
        ),
        CustomButton(
          text: AppStrings.signIn,
          onPressed: () {},
        ),
      ],
    );
  }
}
