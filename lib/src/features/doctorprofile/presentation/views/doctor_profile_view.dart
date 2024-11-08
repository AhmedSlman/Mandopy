// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/src/features/doctorprofile/cubit/doctor_profile_cubit.dart';

import '../components/doctor_add_details_section.dart';
import '../components/doctor_info_container.dart';
import '../widgets/doctor_profile_image_stack.dart';

class DoctorProfileView extends StatelessWidget {
  final String doctorId;
  const DoctorProfileView({
    super.key,
    required this.doctorId,
  });

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
            BlocProvider(
              create: (context) => getIt<DoctorProfileCubit>()
                ..getDoctorProfile(doctorId: doctorId),
              child: const DoctorInfocontainer(),
            ),
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
