// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/src/features/location/cubit/location_cubit.dart';
import 'package:mandopy/src/features/pharmacyprofile/cubit/pharmacy_profile_cubit.dart';

import 'package:mandopy/src/features/pharmacyprofile/presentation/components/pharmacy_add_details_section.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../doctorprofile/cubit/note/note_cubit.dart';
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
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => getIt<PharmacyProfileCubit>()
                ..getPharmacyProfile(pharmacyId: pharmacyId),
            ),
            BlocProvider(
              create: (context) => getIt<LocationCubit>(),
            ),
            BlocProvider(
              create: (context) => getIt<NoteCubit>(),
            ),
          ],
          child: SingleChildScrollView(
            child: Column(
              children: [
                const PharmacyProfileImageStack(),
                SizedBox(height: 50.h),
                PharmacyInfoContainer(
                  pharmacyId: pharmacyId,
                ),
                SizedBox(height: 33.h),
                BlocConsumer<LocationCubit, LocationState>(
                  listener: (context, state) {
                    if (state is LocationLoading) {
                    } else if (state is LocationFailure) {
                      String message;
                      if (state.message.contains("إذن الموقع")) {
                        message =
                            "برجاء تفعيل إذن الموقع لاستخدام هذه الخاصية.";
                      } else {
                        message = state.message;
                      }
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(message)),
                      );
                    } else if (state is LocationSuccess) {
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(state.message)),
                      );
                    }
                  },
                  builder: (context, state) {
                    return CustomButton(
                      text: 'اضغط للوصول للموقع',
                      onPressed: () {
                        context
                            .read<LocationCubit>()
                            .savePharmacyLocation(pharmacyId);
                      },
                    );
                  },
                ),
                SizedBox(height: 33.h),
                PharmacyAddDetailsSection(
                  pharmacyId: pharmacyId,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
