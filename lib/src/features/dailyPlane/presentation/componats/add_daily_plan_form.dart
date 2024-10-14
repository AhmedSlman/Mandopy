import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/common/widgets/custom_btn.dart';

import '../../../../../core/common/widgets/custom_text_form_field.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../widgets/add_purpose_custom_text_field.dart';
import '../widgets/date_picker.dart';
import '../widgets/drop_down_text)field.dart';
import '../widgets/radio_option.dart';
import '../widgets/time_picker.dart';

class AddDailyPlanForm extends StatefulWidget {
  const AddDailyPlanForm({super.key});

  @override
  State<AddDailyPlanForm> createState() => _AddDailyPlanFormState();
}

class _AddDailyPlanFormState extends State<AddDailyPlanForm> {
  String? _selectedPurpose;

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: 262.82.h,
      // width: 389.w,
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
        color: AppColors.dailyPlaneItem,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 17.0.h),
          const Text(
            AppStrings.selectPurpose,
          ),
          SizedBox(height: 9.0.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              RadioOption(
                choice: 'طبيب',
                groupValue: _selectedPurpose,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPurpose = value;
                  });
                },
              ),
              RadioOption(
                choice: 'صيدلية',
                groupValue: _selectedPurpose,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPurpose = value;
                  });
                },
              ),
              RadioOption(
                choice: 'مختلط',
                groupValue: _selectedPurpose,
                onChanged: (String? value) {
                  setState(() {
                    _selectedPurpose = value;
                  });
                },
              ),
            ],
          ),
          const Text(AppStrings.selectActiveIngredient),
          SizedBox(
            height: 5.h,
          ),
          const DropDownTextField(),
          SizedBox(
            height: 15.h,
          ),
          const Text(AppStrings.selectAppointment),
          SizedBox(
            height: 5.h,
          ),
          const Row(
            children: [
              DatePicker(),
              SizedBox(width: 10),
              TimePicker(),
            ],
          ),
          SizedBox(
            height: 15.h,
          ),
          const Text(AppStrings.addPurposeOfplan),
          SizedBox(
            height: 5.h,
          ),
          const AddPurposeCustomTextField(
            hintText: AppStrings.addPurposeOfplan,
          ),
          SizedBox(
            height: 15.h,
          ),
          const Text(AppStrings.choosePlans),
          SizedBox(
            height: 5.h,
          ),
          const AddPurposeCustomTextField(
            hintText: AppStrings.choosePlans,
          ),
          SizedBox(
            height: 15.h,
          ),
          Center(
            child: CustomButton(
              width: 275.w,
              height: 33.h,
              text: AppStrings.addToPlan,
              onPressed: () {},
            ),
          ),
          SizedBox(
            height: 20.h,
          ),
          
        ],
      ),
    );
  }
}


