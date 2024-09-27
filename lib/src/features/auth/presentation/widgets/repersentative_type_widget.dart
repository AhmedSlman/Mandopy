// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class RepresentativeType extends StatefulWidget {
  final String? initialSelectedType;
  final Function(String?)? onTypeChanged;

  const RepresentativeType({
    super.key,
    this.initialSelectedType,
    this.onTypeChanged,
  });

  @override
  _RepresentativeTypeState createState() => _RepresentativeTypeState();
}

class _RepresentativeTypeState extends State<RepresentativeType> {
  String? _selectedType;

  @override
  void initState() {
    super.initState();
    _selectedType = widget.initialSelectedType ?? 'تجاري';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.w),
            child: Text(
              AppStrings.typeOfRepersentative,
              style: AppStyles.s16,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildRadioOption(AppStrings.sales, 'تجاري'),
              _buildRadioOption(AppStrings.scienstific, 'علمي'),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRadioOption(String text, String value) {
    return Row(
      children: [
        Radio<String>(
          activeColor: AppColors.accentColor,
          value: value,
          groupValue: _selectedType,
          onChanged: (String? newValue) {
            setState(() {
              _selectedType = newValue;
            });
            if (widget.onTypeChanged != null) {
              widget.onTypeChanged!(newValue);
            }
          },
        ),
        Text(
          text,
          style: AppStyles.s16,
        ),
      ],
    );
  }
}
