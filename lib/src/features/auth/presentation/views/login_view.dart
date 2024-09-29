import 'package:flutter/material.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/utils/app_assets.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/presentation/componants/login_form.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/app_logo.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/have_an%20_account_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: AppStrings.welcom),
          AppLogoWidget(),
          LoginForm(),
          HaveAnAccountWidget(
            text1: AppStrings.donotHaveAnAccount,
            text2: AppStrings.creatAccount,
          ),
        ],
      ),
    );
  }
}
