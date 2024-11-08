// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/src/features/pharmacyprofile/cubit/pharmacy_profile_cubit.dart';

import 'package:mandopy/src/features/pharmacyprofile/presentation/components/pharmacy_add_details_section.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../components/pharmacy_info_container.dart';
import '../widgets/pharmacy_profile_image_stack.dart';

class PharmacyProfileView extends StatelessWidget {
  final String pharmacyId;
  const PharmacyProfileView({
    super.key,
    required this.pharmacyId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          const PharmacyProfileImageStack(),
          SizedBox(
            height: 50.h,
          ),
          BlocProvider(
            create: (context) => getIt<PharmacyProfileCubit>()
              ..getPharmacyProfile(pharmacyId: pharmacyId),
            child: const PharmacyInfoContainer(),
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
          PharmacyAddDetailsSection(),
        ],
      )),
    );
  }
}
