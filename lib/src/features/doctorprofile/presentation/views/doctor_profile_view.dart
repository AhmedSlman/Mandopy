// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';


import '../components/doctor_add_details_section.dart';
import '../components/doctor_info_container.dart';
import '../widgets/doctor_profile_image_stack.dart';

class DoctorProfileView extends StatelessWidget {
  const DoctorProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const DoctorProfileImageStack(),
            SizedBox(
              height: 50.h,
            ),
            const DoctorInfocontainer(),
            SizedBox(
              height: 33.h,
            ),
            CustomButton(
              text: 'اضغط للوصول للموقع',
              onPressed: () {},
            ),
            SizedBox(
              height: 33.h,
            ),
            const DoctorAddDetailsSection(),
          ],
        ),
      ),
    );
  }
}
