import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/src/features/profile/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:mandopy/src/features/profile/cubit/user/user_cubit.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/app_strings.dart';
import '../widgets/edit_image_widget.dart';

class EditProfileForm extends StatelessWidget {
  const EditProfileForm({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Profile updated successfully!'),
            ),
          );
          GoRouter.of(context).pop();
        } else if (state is EditProfileError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Failed to update profile: ${state.error.message}'),
            ),
          );
          GoRouter.of(context).pop();
        }
      },
      child: Column(
        children: [
          const EditImageWidget(),
          SizedBox(
            height: 38.h,
          ),
          CustomTextFormField(
            hintText: AppStrings.hintName,
            controller: nameController,
          ),
          SizedBox(
            height: 20.h,
          ),
          SizedBox(
            width: 288.w,
            height: 65.h,
            child: CustomButton(
              text: AppStrings.save,
              onPressed: () {
                BlocProvider.of<EditProfileCubit>(context)
                    .updateProfile(name: nameController.text);
              },
            ),
          ),
        ],
      ),
    );
  }
}
