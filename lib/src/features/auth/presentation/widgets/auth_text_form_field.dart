import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/utils/app_styles.dart';

class AuthTextFormField extends StatefulWidget {
  const AuthTextFormField({
    super.key,
    this.validator,
    this.hintText,
    required this.titleOfField,
    this.controller,
    this.isPassword = false,
  });

  final FormFieldValidator<String>? validator;
  final String? hintText;
  final String titleOfField;
  final TextEditingController? controller;
  final bool isPassword;

  @override
  _AuthTextFormFieldState createState() => _AuthTextFormFieldState();
}

class _AuthTextFormFieldState extends State<AuthTextFormField> {
  bool _isPasswordVisible = false;

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 1.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            child: Text(
              widget.titleOfField,
              style: AppStyles.s16,
            ),
          ),
          CustomTextFormField(
            controller: widget.controller,
            hintText: widget.hintText,
            validator: widget.validator,
            obscureText: widget.isPassword ? !_isPasswordVisible : false,
            suffixIcon: widget.isPassword
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: _togglePasswordVisibility,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}
