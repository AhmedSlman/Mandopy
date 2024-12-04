import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/common/functions/validator.dart';
import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/routes/router_names.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../cubit/auth_cubit.dart';
import '../widgets/auth_text_form_field.dart';
import '../../../../../core/functions/show_toast.dart';
import 'package:path/path.dart' as path;

class SignUpFormSection extends StatefulWidget {
  const SignUpFormSection({super.key});

  @override
  State<SignUpFormSection> createState() => _SignUpFormSectionState();
}

class _SignUpFormSectionState extends State<SignUpFormSection> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

          context.go(
            RouterNames.verifyEmail,
            extra: emailController.text,
          );
        } else if (state is RegisterFailureState) {
          Navigator.of(context).pop();
          showToast(
              message: state.errorMessage.message, state: ToastStates.ERROR);
        }
      },
      child: Form(
        key: _formKey,
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
              isPassword: true,
            ),
            AuthTextFormField(
              titleOfField: AppStrings.confirmPassword,
              hintText: AppStrings.hintPassword,
              controller: passwordConfirmController,
              validator: (value) {
                if (value != passwordController.text) {
                  return AppStrings.passwordMismatch;
                }
                return null;
              },
              isPassword: true,
            ),
            AuthTextFormField(
              titleOfField: AppStrings.confirmationCode,
              hintText: AppStrings.hintConfirmationCode,
              controller: adminCodeController,
              validator: Validator.validateManagerCode,
            ),
            CustomButton(
              text: AppStrings.creatAccount,
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
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
                } else {
                  showToast(
                    message: AppStrings.invalidForm,
                    state: ToastStates.ERROR,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
