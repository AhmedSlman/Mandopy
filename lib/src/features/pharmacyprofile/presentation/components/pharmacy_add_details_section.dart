// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:mandopy/src/features/pharmacyprofile/presentation/widgets/pharmacy_add_ditals_widget.dart';

import '../../../../../core/utils/app_strings.dart';

class PharmacyAddDetailsSection extends StatelessWidget {
  PharmacyAddDetailsSection({super.key});
  TextEditingController? noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PharmacyAddDetailsWidget(
      details: AppStrings.details,
      noteController: noteController,
      onPressed: () {},
    );
  }
}
