import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/services/service_locator.dart';
import '../../cubit/targetsCubit/targets_cubit.dart';

import '../../../../../core/functions/show_toast.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../cubit/vistiCubit/visit_cubit.dart';
import '../../cubit/vistiCubit/visit_state.dart';
import '../widgets/add_purpose_custom_text_field.dart';
import '../widgets/date_picker.dart';
import '../widgets/drop_down_text)field.dart';

import '../widgets/searchable_text_field.dart';
import '../widgets/time_picker.dart';

class AddDailyPlanForm extends StatefulWidget {
  const AddDailyPlanForm({super.key});

  @override
  State<AddDailyPlanForm> createState() => _AddDailyPlanFormState();
}

class _AddDailyPlanFormState extends State<AddDailyPlanForm> {
  List<String> _selectedMedicationIds = [];
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
        _selectedMedicationIds.isNotEmpty) {
      final notes = addPurposeTextEditingController.text;
      const isSold = false;

      final formattedTime = _formatTime(_selectedTime!);

      context.read<VisitCubit>().addVisit(
            date: _selectedDate.toString(),
            time: formattedTime,
            medicationIds: _selectedMedicationIds,
            pharmacyId: _selectedPharmacyId,
            doctorId: _selectedDoctorId,
            notes: notes,
            isSold: isSold,
          );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Please fill all required fields"),
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  String _formatTime(TimeOfDay time) {
    final hours = time.hour.toString().padLeft(2, '0');
    final minutes = time.minute.toString().padLeft(2, '0');
    return '$hours:$minutes';
  }

  void _showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withOpacity(0.3),
      builder: (context) => Dialog(
        backgroundColor: Colors.transparent,
        elevation: 0,
        child: Container(
          padding: EdgeInsets.all(24.r),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.r),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.all(16.r),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: const CircularProgressIndicator(
                  valueColor:
                      AlwaysStoppedAnimation<Color>(AppColors.primaryColor),
                  strokeWidth: 3,
                ),
              ),
              SizedBox(height: 16.h),
              Text(
                'Adding to plan...',
                style: TextStyle(
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                  letterSpacing: 0.3,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                'Please wait while we process your request',
                style: TextStyle(
                  fontSize: 12.sp,
                  color: Colors.grey[600],
                  letterSpacing: 0.2,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<VisitCubit, VisitState>(
      listener: (context, state) {
        if (state is VisitLoading) {
          _showLoadingDialog(context);
        }
        if (state is VisitError) {
          GoRouter.of(context).pop();
          showToast(message: state.error.message, state: ToastStates.ERROR);
        } else if (state is VisitsLoaded) {
          GoRouter.of(context).pop();
          showToast(
              message: "Visit added successfully", state: ToastStates.SUCCESS);
          Future.delayed(const Duration(milliseconds: 500), () {
            GoRouter.of(context).pop();
          });
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 16.w),
        padding: EdgeInsets.all(20.r),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.r),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSectionTitle(AppStrings.selectActiveIngredient),
            SizedBox(height: 8.h),
            BlocProvider(
              create: (context) => getIt<TargetsCubit>()..fetchMedications(),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: Colors.grey.shade200),
                ),
                child: DropDownTextField(
                  isMultiSelect: true,
                  onSelect: (List<String> ids) {
                    setState(() {
                      _selectedMedicationIds = ids;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
            _buildSectionTitle(AppStrings.selectAppointment),
            SizedBox(height: 8.h),
            Row(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: DatePicker(
                      onDateSelected: (DateTime? date) {
                        setState(() {
                          _selectedDate = date;
                        });
                      },
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: TimePicker(
                      onTimeSelected: (TimeOfDay? time) {
                        setState(() {
                          _selectedTime = time;
                        });
                      },
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20.h),
            _buildSectionTitle(AppStrings.addPurposeOfplan),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: AddPurposeCustomTextField(
                controller: addPurposeTextEditingController,
                hintText: AppStrings.addPurposeOfplan,
              ),
            ),
            SizedBox(height: 20.h),
            _buildSectionTitle(AppStrings.choosePlans),
            SizedBox(height: 8.h),
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(color: Colors.grey.shade200),
              ),
              child: BlocProvider(
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
            ),
            SizedBox(height: 24.h),
            Center(
              child: CustomButton(
                width: 275.w,
                height: 45.h,
                text: AppStrings.addToPlan,
                onPressed: () => _onAddToPlanPressed(context),
              ),
            ),
            SizedBox(height: 16.h),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      children: [
        Icon(
          Icons.circle,
          size: 8.r,
          color: AppColors.primaryColor,
        ),
        SizedBox(width: 8.w),
        Text(
          title,
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }
}
