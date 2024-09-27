import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/functions/validator.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/repersentative_type_widget.dart';

class SignUpFormSection extends StatelessWidget {
  const SignUpFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const AuthTextFormField(
          titleOfField: AppStrings.name,
          hintText: AppStrings.hintName,
          validator: Validator.validateName,
        ),
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
        const AuthTextFormField(
          titleOfField: AppStrings.confirmPassword,
          hintText: AppStrings.hintPassword,
          validator: Validator.validatePassword,
        ),
        const AuthTextFormField(
          titleOfField: AppStrings.confirmationCode,
          hintText: AppStrings.hintConfirmationCode,
          validator: Validator.validateManagerCode,
        ),
        RepresentativeType(
            initialSelectedType: 'علمي',
            onTypeChanged: (String? newType) {
              print('نوع المندوب تم تغييره إلى: $newType');
            }),
        CustomButton(
          text: AppStrings.creatAccount,
          onPressed: () {},
        )
      ],
    );
  }
}
