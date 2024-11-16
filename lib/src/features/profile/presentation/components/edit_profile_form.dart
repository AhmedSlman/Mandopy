import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/src/features/profile/cubit/edit_profile/edit_profile_cubit.dart';
import 'package:mandopy/src/features/profile/cubit/user/user_cubit.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/functions/show_toast.dart';
import '../../../../../core/utils/app_strings.dart';
import '../widgets/edit_image_widget.dart';
import '../widgets/profile_image_picker.dart';

class EditProfileForm extends StatefulWidget {
  const EditProfileForm({super.key});

  @override
  State<EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends State<EditProfileForm> {
  final nameController = TextEditingController();
  File? _selectedImage;

  @override
  void dispose() {
    nameController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EditProfileCubit, EditProfileState>(
      listener: (context, state) {
        if (state is EditProfileLoaded) {
          showToast(
              message: "Profile updated successfully",
              state: ToastStates.SUCCESS);
          GoRouter.of(context).pop();
        } else if (state is EditProfileError) {
          showToast(message: state.error.message, state: ToastStates.ERROR);
          GoRouter.of(context).pop();
        }
      },
      child: Column(
        children: [
          ProfileImagePicker(
            initialImage: _selectedImage,
            onImagePicked: (File? image) {
              setState(() {
                _selectedImage = image;
              });
            },
          ),
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
                BlocProvider.of<EditProfileCubit>(context).updateProfile(
                    name: nameController.text, image: _selectedImage);
              },
            ),
          ),
        ],
      ),
    );
  }
}
