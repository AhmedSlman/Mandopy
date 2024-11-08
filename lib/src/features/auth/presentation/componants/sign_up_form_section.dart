import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/core/common/functions/validator.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/routes/router_names.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/auth/cubit/auth_cubit.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/auth_text_form_field.dart';
import 'package:mandopy/src/features/auth/presentation/widgets/repersentative_type_widget.dart';

class SignUpFormSection extends StatelessWidget {
  const SignUpFormSection({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final passwordController = TextEditingController();
    final passwordConfirmController = TextEditingController();
    final adminCodeController = TextEditingController();

    String selectedRole = 'commercial';

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
              );
              context.go(RouterNames.verifyEmail, extra: emailController.text);
            },
          ),
        ],
      ),
    );
  }
}
