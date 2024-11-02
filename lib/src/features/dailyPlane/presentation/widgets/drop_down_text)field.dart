// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_cubit.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_state.dart';

class DropDownTextField extends StatefulWidget {
  const DropDownTextField({
    super.key,
    required this.onSelect,
  });
  final ValueChanged<String?> onSelect;

  @override
  State<DropDownTextField> createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  String? _selectedIngredient;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          5,
        ),
      ),
      child: BlocBuilder<TargetsCubit, TargetsState>(
        builder: (context, state) {
          if (state is TargetsLoading) {
            return const CircularProgressIndicator();
          } else if (state is TargetsMedicationsLoaded) {
            return DropdownButton(
              value: _selectedIngredient,
              hint: const Text(
                AppStrings.selectActiveIngredient,
                style: TextStyle(
                  color: Color.fromRGBO(
                    102,
                    102,
                    102,
                    .74,
                  ),
                ),
              ),
              icon: const Icon(Icons.arrow_drop_down),
              isExpanded: true,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedIngredient = newValue;
                });
                widget.onSelect(newValue);
              },
              items:
                  state.medications.map<DropdownMenuItem<String>>((medication) {
                return DropdownMenuItem<String>(
                  value: medication.id.toString(),
                  child: Text(medication.name),
                );
              }).toList(),
            );
          } else if (state is TargetsError) {
            return Center(
                child:
                    Text('Failed to load medications: ${state.error.message}'));
          } else {
            return const Center(child: Text('No medications available'));
          }
        },
      ),
    );
  }
}
