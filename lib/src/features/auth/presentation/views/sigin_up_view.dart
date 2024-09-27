// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/presentation/componants/sign_up_form_section.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/have_an%20_account_widget.dart';

class SiginUpView extends StatelessWidget {
  const SiginUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(title: AppStrings.creatNewAccount),
          SignUpFormSection(),
          HaveAnAccountWidget()
        ],
      ),
    );
  }
}
