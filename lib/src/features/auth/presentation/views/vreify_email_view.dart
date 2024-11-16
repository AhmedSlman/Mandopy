import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/common/widgets/custom_icon_back.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/cubit/auth_cubit.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/custom_otp_fields.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/forget_password.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/forget_password_message.dart';

import '../../../../../core/functions/show_toast.dart';
import '../../../../../core/routes/router_names.dart';

class VerifyEmailView extends StatelessWidget {
  VerifyEmailView({super.key, required this.email});
  final String email;
  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is VerifyEmailLoadingState) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (context) => const Center(
                child: CircularProgressIndicator(),
              ),
            );
          } else if (state is VerifyEmailSuccessState) {
            Navigator.of(context).pop();
            showToast(
                message: "email verfied successfully",
                state: ToastStates.SUCCESS);
            context.go(RouterNames.navigatiomBarButton);
          } else if (state is VerifyEmailFailureState) {
            Navigator.of(context).pop();
            showToast(
                message: state.errorMessage.message, state: ToastStates.ERROR);
          }
        },
        child: Column(
          children: [
            const CustomIconBackWidget(),
            CustomAppBar(title: AppStrings.verifyEmail, padding: 16.h),
            const ForgetPasswordMessage(message: AppStrings.otpMessage),
            CustomOTPFields(
              controllers: controllers,
            ),
            CustomButton(
                text: 'التحقق',
                onPressed: () {
                  final authCubit = context.read<AuthCubit>();
                  String code =
                      controllers.map((controller) => controller.text).join();

                  authCubit.verifyEmail(
                    email: email,
                    code: code,
                  );
                }),
            const CustomTextButton(
              text: AppStrings.resendCode,
              alignment: Alignment.center,
            ),
          ],
        ),
      ),
    );
  }
}
