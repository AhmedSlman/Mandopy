import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../widgets/date_picker_widget.dart';

class CalenderRow extends StatelessWidget {
  const CalenderRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const DatePickerWidget(
          containerColor: AppColors.lightGreen,
        ),
        SizedBox(
          width: 22.w,
        ),
        const DatePickerWidget(
          containerColor: AppColors.moreYellower,
        ),
      ],
    );
  }
}
