import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/common/widgets/custom_icon_back.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../cubit/auth_cubit.dart';
import '../widgets/auth_text_form_field.dart';

import '../../../../../core/functions/show_toast.dart';
import '../../../../../core/routes/router_names.dart';

class ResetPasswordView extends StatefulWidget {
  const ResetPasswordView({super.key});

  @override
  State<ResetPasswordView> createState() => _ResetPasswordViewState();
}

class _ResetPasswordViewState extends State<ResetPasswordView> {
  final _emailcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmPasswordcontroller = TextEditingController();
  final _codeController = TextEditingController();

  @override
  void dispose() {
    _emailcontroller.dispose();
    _passwordcontroller.dispose();
    _confirmPasswordcontroller.dispose();
    _codeController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ResetPasswordLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (state is ResetPasswordSuccessState) {
            GoRouter.of(context).pop();
            showToast(
                message: state.resetPasswordModel.message,
                state: ToastStates.SUCCESS);
            GoRouter.of(context).go(RouterNames.login);
          } else if (state is ResetPasswordFailureState) {
            GoRouter.of(context).pop();
            showToast(
                message: state.errorMessage.message, state: ToastStates.ERROR);
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              const CustomIconBackWidget(),
              CustomAppBar(title: AppStrings.resetPassword, padding: 16.h),
              AuthTextFormField(
                titleOfField: AppStrings.email,
                hintText: AppStrings.emailHint,
                controller: _emailcontroller,
              ),
              AuthTextFormField(
                titleOfField: AppStrings.newPassword,
                hintText: AppStrings.hintPassword,
                controller: _passwordcontroller,
                isPassword: true,
              ),
              AuthTextFormField(
                titleOfField: AppStrings.confirmNewPassword,
                hintText: AppStrings.hintConfirmPassword,
                controller: _confirmPasswordcontroller,
                isPassword: true,
              ),
              AuthTextFormField(
                titleOfField: AppStrings.confirmationCodeemail,
                hintText: AppStrings.confirmOtp,
                controller: _codeController,
              ),
              CustomButton(
                text: AppStrings.confirm,
                onPressed: () {
                  context.read<AuthCubit>().resetPassword(
                        email: _emailcontroller.text,
                        password: _passwordcontroller.text,
                        passwordConfirmation: _confirmPasswordcontroller.text,
                        code: _codeController.text,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
