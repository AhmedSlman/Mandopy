import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/app_strings.dart';
import '../widgets/edit_image_widget.dart';

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