import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/core/common/functions/validator.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/common/widgets/custom_icon_back.dart';
import 'package:mandopy/core/functions/show_toast.dart';
import 'package:mandopy/core/routes/router_names.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/cubit/auth_cubit.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/forget_password_message.dart';

class ForgetPasswordView extends StatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  State<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends State<ForgetPasswordView> {
  final _emailTextEditingController = TextEditingController();

  @override
  void dispose() {
    _emailTextEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is ForgetPasswordLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) =>
                  const Center(child: CircularProgressIndicator()),
            );
          } else if (state is ForgetPasswordSuccessState) {
            GoRouter.of(context).pop();
            GoRouter.of(context).go(RouterNames.resetPassword);
          } else if (state is ForgetPasswordFailureState) {
            showToast(
                message: state.errorMessage.message, state: ToastStates.ERROR);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomIconBackWidget(),
            const CustomAppBar(title: AppStrings.forgetPassword, padding: 16),
            const ForgetPasswordMessage(
              message: AppStrings.forgetPasswordMessage,
            ),
            AuthTextFormField(
              titleOfField: AppStrings.email,
              hintText: AppStrings.emailHint,
              validator: Validator.validateEmail,
              controller: _emailTextEditingController,
            ),
            CustomButton(
              text: AppStrings.send,
              onPressed: () {
                context
                    .read<AuthCubit>()
                    .forgetPassword(email: _emailTextEditingController.text);
              },
            ),
          ],
        ),
      ),
    );
  }
}
