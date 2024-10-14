import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/src/features/pharmacyprofile/presentation/components/pharmacy_add_details_section.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../components/pharmacy_info_container.dart';
import '../widgets/pharmacy_profile_image_stack.dart';

class PharmacyProfileView extends StatelessWidget {
  const PharmacyProfileView({super.key});

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
          const PharmacyInfoContainer(),
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
          const PharmacyAddDetailsSection(),
        ],
      )),
    );
  }
}
