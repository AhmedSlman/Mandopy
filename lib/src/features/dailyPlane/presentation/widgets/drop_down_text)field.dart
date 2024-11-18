import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_cubit.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_state.dart';
import 'package:mandopy/src/features/dailyPlane/data/models/medecation_model.dart';

class DropDownTextField extends StatefulWidget {
  const DropDownTextField({
    super.key,
    required this.onSelect,
    this.isMultiSelect = false,
  });
  final ValueChanged<List<String>> onSelect;
  final bool isMultiSelect;

  @override
  State<DropDownTextField> createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  List<MedicationModel> _selectedMedications = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: BlocBuilder<TargetsCubit, TargetsState>(
        builder: (context, state) {
          if (state is TargetsLoading) {
            return const CircularProgressIndicator();
          } else if (state is TargetsMedicationsLoaded) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _selectedMedications.isNotEmpty
                    ? Wrap(
                        spacing: 8.0,
                        runSpacing: 4.0,
                        children: _selectedMedications
                            .map(
                              (medication) => Chip(
                                label: Text(medication.name),
                                onDeleted: () {
                                  setState(() {
                                    _selectedMedications.remove(medication);
                                  });
                                  widget.onSelect(
                                    _selectedMedications
                                        .map((e) => e.id.toString())
                                        .toList(),
                                  );
                                },
                              ),
                            )
                            .toList(),
                      )
                    : Text(
                        AppStrings.selectActiveIngredient,
                        style: AppStyles.s10.copyWith(
                          color: const Color.fromRGBO(102, 102, 102, .74),
                        ),
                      ),
                DropdownButton<MedicationModel>(
                  value: null,
                  hint: const Text(
                    AppStrings.selectActiveIngredient,
                    style: TextStyle(
                      color: Color.fromRGBO(102, 102, 102, .74),
                    ),
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  isExpanded: true,
                  onChanged: widget.isMultiSelect
                      ? (MedicationModel? newValue) {
                          setState(() {
                            if (_selectedMedications.contains(newValue)) {
                              _selectedMedications.remove(newValue);
                            } else {
                              _selectedMedications.add(newValue!);
                            }
                          });
                          widget.onSelect(
                            _selectedMedications
                                .map((medication) => medication.id.toString())
                                .toList(),
                          );
                        }
                      : (MedicationModel? newValue) {
                          setState(() {
                            _selectedMedications = [newValue!];
                          });
                          widget.onSelect(
                            _selectedMedications
                                .map((medication) => medication.id.toString())
                                .toList(),
                          );
                        },
                  items: state.medications
                      .map<DropdownMenuItem<MedicationModel>>((medication) {
                    return DropdownMenuItem<MedicationModel>(
                      value: medication,
                      child: Text(medication.name),
                    );
                  }).toList(),
                ),
              ],
            );
          } else if (state is TargetsError) {
            return Center(
              child: Text('Failed to load medications: ${state.error.message}'),
            );
          } else {
            return const Center(child: Text('No medications available'));
          }
        },
      ),
    );
  }
}
