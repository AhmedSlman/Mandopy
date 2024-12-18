// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:mandopy/core/utils/app_styles.dart';

import '../../../../../core/utils/app_strings.dart';

class DatePicker extends StatefulWidget {
  const DatePicker({
    super.key,
    required this.onDateSelected,
  });
  final ValueChanged<DateTime?> onDateSelected;

  @override
  State<DatePicker> createState() => _DatePickerState();
}

class _DatePickerState extends State<DatePicker> {
  DateTime? _selectedDate;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          setState(() {
            _selectedDate = pickedDate;
          });
          widget.onDateSelected(_selectedDate);
        }
      },
      child: Container(
        width: 190.w,
        height: 47.h,
        padding: EdgeInsets.symmetric(horizontal: 10.0.h, vertical: 10.h),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedDate != null
                  ? DateFormat('yyyy-MM-dd').format(_selectedDate!)
                  : AppStrings.visitDate,
              style: AppStyles.s14.copyWith(
                color: const Color.fromRGBO(102, 102, 102, .75),
              ),
            ),
            const Icon(
              Icons.calendar_month,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
