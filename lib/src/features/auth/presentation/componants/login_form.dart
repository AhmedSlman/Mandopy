import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/functions/validator.dart';
import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/routes/router_names.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../cubit/auth_cubit.dart';
import '../widgets/auth_text_form_field.dart';
import '../widgets/forget_password.dart';

import '../../../../../core/functions/show_toast.dart';

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
          showToast(
              message: "You logged in successfully",
              state: ToastStates.SUCCESS);
          context.go(RouterNames.navigatiomBarButton);
        } else if (state is LoginFailureState) {
          Navigator.of(context).pop();
          showToast(
              message: state.errorMessage.message, state: ToastStates.ERROR);
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
            isPassword: true,
          ),
          CustomTextButton(
            text: AppStrings.forgetPassword,
            onPressed: () => GoRouter.of(context).push(
              RouterNames.forgetPassword,
            ),
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
