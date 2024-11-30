import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_styles.dart';

class DatePickerWidget extends StatefulWidget {
  final Color containerColor;
  final Function(DateTime) onDateSelected;

  const DatePickerWidget({
    super.key,
    required this.containerColor,
    required this.onDateSelected,
  });

  @override
  _DatePickerWidgetState createState() => _DatePickerWidgetState();
}

class _DatePickerWidgetState extends State<DatePickerWidget> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      locale: const Locale('ar', ''),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
      widget.onDateSelected(selectedDate);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _selectDate(context),
      child: Container(
        width: 190.w,
        height: 40.h,
        decoration: BoxDecoration(
          color: widget.containerColor,
          borderRadius: BorderRadius.circular(2.0),
        ),
        child: Row(
          children: [
            SizedBox(width: 5.w),
            Text(
              "${selectedDate.day} ${DateFormat('MMMM', 'ar').format(selectedDate)} ${selectedDate.year}",
              style: AppStyles.s14,
            ),
            SizedBox(width: 5.w),
            SvgPicture.asset(
              AppAssets.calenderIcon,
              width: 16.w,
              height: 17.h,
            ),
            SizedBox(width: 15.w),
            const VerticalDivider(
              color: Color.fromRGBO(175, 181, 175, 0.2),
              thickness: 1.0,
            ),
            SizedBox(width: 5.w),
            SvgPicture.asset(AppAssets.dropDownIcon),
          ],
        ),
      ),
    );
  }
}
