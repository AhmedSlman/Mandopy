import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mandopy/core/common/functions/validator.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/routes/router_names.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/cubit/auth_cubit.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/repersentative_type_widget.dart';
import 'package:path/path.dart' as path;

class SignUpFormSection extends StatefulWidget {
  const SignUpFormSection({super.key});

  @override
  State<SignUpFormSection> createState() => _SignUpFormSectionState();
}

class _SignUpFormSectionState extends State<SignUpFormSection> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final passwordConfirmController = TextEditingController();
  final adminCodeController = TextEditingController();

  String selectedRole = 'commercial';
  File? _imageFile;

  final ImagePicker _picker = getIt<ImagePicker>();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    passwordConfirmController.dispose();
    adminCodeController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final XFile? pickedFile =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        debugPrint("Image file : $_imageFile");
        final String fileName = path.basename(pickedFile.path);
        debugPrint("Image file name: $fileName");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is RegisterSuccessState) {
          Navigator.of(context).pop();
          context.go(RouterNames.home);
        } else if (state is RegisterFailureState) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errorMessage.message)),
          );
        }
      },
      child: Column(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.grey[200],
              backgroundImage:
                  _imageFile == null ? null : FileImage(_imageFile!),
              child: _imageFile == null
                  ? Icon(
                      Icons.camera_alt,
                      size: 40,
                      color: Colors.grey[600],
                    )
                  : null,
            ),
          ),
          const SizedBox(height: 20),
          AuthTextFormField(
            titleOfField: AppStrings.name,
            hintText: AppStrings.hintName,
            controller: nameController,
            validator: Validator.validateName,
          ),
          AuthTextFormField(
            titleOfField: AppStrings.email,
            hintText: AppStrings.emailHint,
            controller: emailController,
            validator: Validator.validateEmail,
          ),
          AuthTextFormField(
            titleOfField: AppStrings.password,
            hintText: AppStrings.hintPassword,
            controller: passwordController,
            validator: Validator.validatePassword,
          ),
          AuthTextFormField(
            titleOfField: AppStrings.confirmPassword,
            hintText: AppStrings.hintPassword,
            controller: passwordConfirmController,
            validator: Validator.validatePassword,
          ),
          AuthTextFormField(
            titleOfField: AppStrings.confirmationCode,
            hintText: AppStrings.hintConfirmationCode,
            controller: adminCodeController,
            validator: Validator.validateManagerCode,
          ),
          RepresentativeType(
            initialSelectedType: selectedRole,
            onTypeChanged: (String? newType) {
              if (kDebugMode) {
                print('نوع المندوب تم تغييره إلى: $newType');
              }
              selectedRole = newType ?? 'commercial';
            },
          ),
          CustomButton(
            text: AppStrings.creatAccount,
            onPressed: () {
              final authCubit = context.read<AuthCubit>();
              authCubit.register(
                email: emailController.text,
                name: nameController.text,
                password: passwordController.text,
                passwordConfirmation: passwordConfirmController.text,
                role: selectedRole,
                admincode: adminCodeController.text,
                image: _imageFile,
              );
              context.go(RouterNames.verifyEmail, extra: emailController.text);
            },
          ),
        ],
      ),
    );
  }
}
