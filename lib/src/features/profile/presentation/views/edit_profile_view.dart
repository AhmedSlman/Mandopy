import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/common/widgets/custom_text_form_field.dart';
import 'package:mandopy/core/utils/app_strings.dart';

import '../widgets/edit_image_widget.dart';

class EditProfileView extends StatelessWidget {
  const EditProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: AppStrings.editProfile,
            iconright: Icons.arrow_forward_ios,
          ),
          EditProfileForm(),
        ],
      ),
    );
  }
}

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const EditImageWidget(),
        SizedBox(
          height: 38.h,
        ),
        const CustomTextFormField(
          hintText: AppStrings.emailHint,
        ),
        SizedBox(
          height: 20.h,
        ),
        const CustomTextFormField(
          hintText: AppStrings.phoneHint,
        ),
        SizedBox(
          height: 20.h,
        ),
        const CustomTextFormField(
          hintText: AppStrings.hintPassword,
        ),
        SizedBox(
          height: 20.h,
        ),
        const CustomTextFormField(
          hintText: AppStrings.visitsHint,
        ),
        SizedBox(
          height: 20.h,
        ),
        const CustomTextFormField(
          hintText: AppStrings.goalsHint,
        ),
        SizedBox(
          height: 20.h,
        ),
        const CustomTextFormField(
          hintText: AppStrings.activeSubstanceHint,
        ),
        SizedBox(
          height: 20.h,
        ),
        const CustomTextFormField(
          hintText: AppStrings.uncompletedVisitsHint,
        ),
        SizedBox(
          height: 41.h,
        ),
        SizedBox(
          width: 288.w,
          height: 65.h,
          child: CustomButton(
            text: AppStrings.save,
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
