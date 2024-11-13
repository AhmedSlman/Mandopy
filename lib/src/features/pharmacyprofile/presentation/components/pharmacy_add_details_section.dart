// ignore_for_file: public_member_api_docs, sort_constructors_first
// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mandopy/src/features/pharmacyprofile/presentation/widgets/pharmacy_add_ditals_widget.dart';

import '../../../../../core/utils/app_strings.dart';
import '../../../doctorprofile/cubit/note/note_cubit.dart';

class PharmacyAddDetailsSection extends StatelessWidget {
  final String pharmacyId;
  PharmacyAddDetailsSection({
    super.key,
    required this.pharmacyId,
  });
  TextEditingController noteController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return PharmacyAddDetailsWidget(
      details: AppStrings.details,
      noteController: noteController,
      onPressed: () {
        if (noteController.text.isNotEmpty) {
          context.read<NoteCubit>().addANote(
                id: pharmacyId,
                note: noteController.text,
              );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Please enter a note')),
          );
        }
      },
    );
  }
}
