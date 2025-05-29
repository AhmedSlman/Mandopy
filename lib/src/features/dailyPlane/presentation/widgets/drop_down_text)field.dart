import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/theme/app_colors.dart';
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
  bool _isDropdownOpen = false;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TargetsCubit, TargetsState>(
      builder: (context, state) {
        if (state is TargetsLoading) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.r),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor:
                    AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
              ),
            ),
          );
        } else if (state is TargetsMedicationsLoaded) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (_selectedMedications.isNotEmpty) ...[
                Container(
                  padding: EdgeInsets.all(8.r),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                  child: Wrap(
                    spacing: 8.w,
                    runSpacing: 8.h,
                    children: _selectedMedications.map((medication) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(20.r),
                            onTap: () {
                              setState(() {
                                _selectedMedications.remove(medication);
                              });
                              widget.onSelect(
                                _selectedMedications
                                    .map((e) => e.id.toString())
                                    .toList(),
                              );
                            },
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 12.w,
                                vertical: 6.h,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    medication.name,
                                    style: TextStyle(
                                      color: AppColors.primaryColor,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(width: 4.w),
                                  Icon(
                                    Icons.close,
                                    size: 16.r,
                                    color: AppColors.primaryColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 8.h),
              ],
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(
                    color: _isDropdownOpen
                        ? AppColors.primaryColor
                        : Colors.grey.shade300,
                    width: 1,
                  ),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<MedicationModel>(
                    value: null,
                    hint: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        AppStrings.selectActiveIngredient,
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14.sp,
                        ),
                      ),
                    ),
                    icon: Padding(
                      padding: EdgeInsets.only(right: 12.w),
                      child: Icon(
                        _isDropdownOpen
                            ? Icons.keyboard_arrow_up
                            : Icons.keyboard_arrow_down,
                        color: AppColors.primaryColor,
                        size: 24.r,
                      ),
                    ),
                    isExpanded: true,
                    onChanged: widget.isMultiSelect
                        ? (MedicationModel? newValue) {
                            if (newValue != null) {
                              setState(() {
                                if (_selectedMedications.contains(newValue)) {
                                  _selectedMedications.remove(newValue);
                                } else {
                                  _selectedMedications.add(newValue);
                                }
                              });
                              widget.onSelect(
                                _selectedMedications
                                    .map((medication) =>
                                        medication.id.toString())
                                    .toList(),
                              );
                            }
                          }
                        : (MedicationModel? newValue) {
                            if (newValue != null) {
                              setState(() {
                                _selectedMedications = [newValue];
                              });
                              widget.onSelect(
                                _selectedMedications
                                    .map((medication) =>
                                        medication.id.toString())
                                    .toList(),
                              );
                            }
                          },
                    items: state.medications
                        .map<DropdownMenuItem<MedicationModel>>((medication) {
                      return DropdownMenuItem<MedicationModel>(
                        value: medication,
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12.w),
                          child: Text(
                            medication.name,
                            style: TextStyle(
                              fontSize: 14.sp,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                    onTap: () {
                      setState(() {
                        _isDropdownOpen = !_isDropdownOpen;
                      });
                    },
                  ),
                ),
              ),
            ],
          );
        } else if (state is TargetsError) {
          return Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.red.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 20.r),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'Failed to load medications: ${state.error.message}',
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: Colors.grey.shade50,
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey, size: 20.r),
                SizedBox(width: 8.w),
                Expanded(
                  child: Text(
                    'No medications available',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }
}
