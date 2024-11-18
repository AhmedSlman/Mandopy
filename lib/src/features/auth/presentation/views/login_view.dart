import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/routes/router_names.dart';
import '../../../../../core/utils/app_strings.dart';
import '../componants/login_form.dart';
import '../widgets/app_logo.dart';
import '../widgets/have_an%20_account_widget.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            const CustomAppBar(title: AppStrings.welcom),
            const AppLogoWidget(),
            LoginForm(),
            HaveAnAccountWidget(
              onTap: () => context.push(
                RouterNames.signup,
              ),
              text1: AppStrings.donotHaveAnAccount,
              text2: AppStrings.creatAccount,
            ),
          ],
        ),
      ),
    );
  }
}
