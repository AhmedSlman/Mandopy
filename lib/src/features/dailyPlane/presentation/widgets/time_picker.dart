// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_strings.dart';

class TimePicker extends StatefulWidget {
  const TimePicker({
    super.key,
    required this.onTimeSelected,
  });
  final ValueChanged<TimeOfDay?> onTimeSelected;

  @override
  State<TimePicker> createState() => _TimePickerState();
}

class _TimePickerState extends State<TimePicker> {
  TimeOfDay? _selectedTime;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        TimeOfDay? pickedTime = await showTimePicker(
          context: context,
          initialTime: TimeOfDay.now(),
        );
        if (pickedTime != null) {
          setState(() {
            _selectedTime = pickedTime;
          });
          widget.onTimeSelected(pickedTime);
        }
      },
      child: Container(
        width: 150.w,
        height: 47.h,
        padding: const EdgeInsets.symmetric(
          horizontal: 10.0,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              _selectedTime != null
                  ? _selectedTime!.format(context)
                  : AppStrings.time,
              style: const TextStyle(color: Colors.black54),
            ),
            const Icon(
              Icons.access_time,
              color: Colors.black54,
            ),
          ],
        ),
      ),
    );
  }
}
