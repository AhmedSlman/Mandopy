// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/utils/app_strings.dart';

import '../components/performance_details_section.dart';
import '../components/profile_details_container.dart';
import '../components/profile_image_name.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        child: Column(
          children: [
            const CustomAppBar(
              title: AppStrings.profile,
            ),
            const ProfileImageAndname(),
            SizedBox(
              height: 16.h,
            ),
            const ProfileDetailsContainer(),
            SizedBox(
              height: 20.h,
            ),
            const PerformanceDetailsSection(),
          ],
        ),
      ),
    );
  }
}
