import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/src/features/dailyPlane/cubit/targetsCubit/targets_cubit.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../cubit/vistiCubit/visit_cubit.dart';
import '../../cubit/vistiCubit/visit_state.dart';
import '../widgets/add_purpose_custom_text_field.dart';
import '../widgets/date_picker.dart';
import '../widgets/drop_down_text)field.dart';

import '../widgets/radio_option.dart';
import '../widgets/searchable_text_field.dart';
import '../widgets/time_picker.dart';

class AddDailyPlanForm extends StatefulWidget {
  const AddDailyPlanForm({super.key});

  @override
  State<AddDailyPlanForm> createState() => _AddDailyPlanFormState();
}

class _AddDailyPlanFormState extends State<AddDailyPlanForm> {
  String? _selectedPurpose;
  String? _selectedMedicationId;
  String? _selectedDoctorId;
  String? _selectedPharmacyId;

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  TextEditingController addPurposeTextEditingController =
      TextEditingController();

  @override
  void dispose() {
    addPurposeTextEditingController.dispose();
    super.dispose();
  }

  void _onAddToPlanPressed(BuildContext context) {
    if (_selectedDate != null &&
        _selectedTime != null &&
        _selectedMedicationId != null) {
      final notes = addPurposeTextEditingController.text;
      const isSold = false;

      // Format the time for the visit
      final formattedTime =
          _formatTime(_selectedTime!); // New formatting method

      context.read<VisitCubit>().addVisit(
            date: _selectedDate.toString(),
            time: formattedTime, // Use the formatted time here
            medicationId: _selectedMedicationId!,
            pharmacyId: _selectedPharmacyId,
            doctorId: _selectedDoctorId,
            notes: notes,
            isSold: isSold,
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all required fields")),
      );
    }
  }

  String _formatTime(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisitCubit, VisitState>(
      listener: (context, state) {
        if (state is VisitLoading) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Adding visit...")),
          );
        } else if (state is VisitError) {
          // Handle error state
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: ${state.error}")),
          );
        } else if (state is VisitsLoaded) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Visit added successfully!")),
          );

          _resetForm();
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 16),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: AppColors.dailyPlaneItem,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 17.0.h),
            // const Text(AppStrings.selectPurpose),
            // SizedBox(height: 9.0.h),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     RadioOption(
            //       choice: 'طبيب',
            //       groupValue: _selectedPurpose,
            //       onChanged: (String? value) {
            //         setState(() {
            //           _selectedPurpose = value;
            //           debugPrint("Selected purpose: $_selectedPurpose");
            //         });
            //       },
            //     ),
            //     RadioOption(
            //       choice: 'صيدلية',
            //       groupValue: _selectedPurpose,
            //       onChanged: (String? value) {
            //         setState(() {
            //           _selectedPurpose = value;
            //           debugPrint("Selected purpose: $_selectedPurpose");
            //         });
            //       },
            //     ),
            //     RadioOption(
            //       choice: 'مختلط',
            //       groupValue: _selectedPurpose,
            //       onChanged: (String? value) {
            //         setState(() {
            //           _selectedPurpose = value;
            //           debugPrint("Selected purpose: $_selectedPurpose");
            //         });
            //       },
            //     ),
            //   ],
            // ),
            const Text(AppStrings.selectActiveIngredient),
            SizedBox(height: 5.h),
            BlocProvider(
              create: (context) => getIt<TargetsCubit>()..fetchMedications(),
              child: DropDownTextField(
                onSelect: (String? id) {
                  setState(() {
                    _selectedMedicationId = id;
                  });
                },
              ),
            ),
            SizedBox(height: 15.h),
            const Text(AppStrings.selectAppointment),
            SizedBox(height: 5.h),
            Row(
              children: [
                DatePicker(
                  onDateSelected: (DateTime? date) {
                    setState(() {
                      _selectedDate = date;
                      debugPrint("Selected date: ${_selectedDate.toString()}");
                    });
                  },
                ),
                const SizedBox(width: 10),
                TimePicker(
                  onTimeSelected: (TimeOfDay? time) {
                    setState(() {
                      _selectedTime = time;
                    });
                    debugPrint(
                        "Selected time: ${_selectedTime?.format(context)}");
                  },
                ),
              ],
            ),
            SizedBox(height: 15.h),
            const Text(AppStrings.addPurposeOfplan),
            SizedBox(height: 5.h),
            AddPurposeCustomTextField(
              controller: addPurposeTextEditingController,
              hintText: AppStrings.addPurposeOfplan,
            ),
            SizedBox(height: 15.h),
            const Text(AppStrings.choosePlans),
            SizedBox(height: 5.h),

            BlocProvider(
              create: (context) => getIt<TargetsCubit>(),
              child: SearchableTextField(
                hintText: AppStrings.choosePlans,
                onDoctorSelected: (String id) {
                  setState(() {
                    _selectedDoctorId = id;
                  });
                },
                onPharmacySelected: (String id) {
                  setState(() {
                    _selectedPharmacyId = id;
                  });
                },
              ),
            ),

            SizedBox(height: 15.h),
            Center(
              child: CustomButton(
                width: 275.w,
                height: 33.h,
                text: AppStrings.addToPlan,
                onPressed: () => _onAddToPlanPressed(context),
              ),
            ),
            SizedBox(height: 20.h),
          ],
        ),
      ),
    );
  }

  void _resetForm() {
    setState(() {
      _selectedPurpose = null;
      _selectedMedicationId = null;
      _selectedDoctorId = null;
      _selectedPharmacyId = null;
      _selectedDate = null;
      _selectedTime = null;
      addPurposeTextEditingController.clear();
    });
  }
}
