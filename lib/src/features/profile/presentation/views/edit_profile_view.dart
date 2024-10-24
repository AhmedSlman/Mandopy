import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/common/widgets/custom_text_form_field.dart';
import 'package:mandopy/core/utils/app_strings.dart';

import '../components/edit_profile_form.dart';
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
