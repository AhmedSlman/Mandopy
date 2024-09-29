import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/common/widgets/custom_icon_back.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/custom_otp_fields.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/forget_password.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/forget_password_message.dart';

class OtpCodeView extends StatelessWidget {
  OtpCodeView({super.key});
  final List<TextEditingController> controllers =
      List.generate(4, (index) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomIconBackWidget(),
          CustomAppBar(title: AppStrings.confirmOtp, padding: 16.h),
          const ForgetPasswordMessage(message: AppStrings.otpMessage),
          CustomOTPFields(
            controllers: controllers,
          ),
          CustomButton(text: 'التحقق', onPressed: () {}),
          const CustomTextButton(
            text: AppStrings.resendCode,
            alignment: Alignment.center,
          ),
        ],
      ),
    );
  }
}
