import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/core/common/functions/validator.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/routes/router_names.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/cubit/auth_cubit.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/forget_password.dart';

class LoginForm extends StatelessWidget {
  LoginForm({super.key});
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) =>
                const Center(child: CircularProgressIndicator()),
          );
        } else if (state is LoginSuccessState) {
          Navigator.of(context).pop();
          context.go(RouterNames.home);
        } else if (state is LoginFailureState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage.message)),
          );
        }
      },
      child: Column(
        children: [
          AuthTextFormField(
            titleOfField: AppStrings.email,
            hintText: AppStrings.emailHint,
            validator: Validator.validateEmail,
            controller: emailController,
          ),
          AuthTextFormField(
            titleOfField: AppStrings.password,
            hintText: AppStrings.hintPassword,
            validator: Validator.validatePassword,
            controller: passwordController,
          ),
          const CustomTextButton(
            text: AppStrings.forgetPassword,
          ),
          CustomButton(
            text: AppStrings.signIn,
            onPressed: () {
              final authCubit = context.read<AuthCubit>();
              authCubit.login(
                email: emailController.text,
                password: passwordController.text,
              );
            },
          ),
        ],
      ),
    );
  }
}
