import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../cubit/reports_cubit.dart';
import '../widgets/date_picker_widget.dart';

class CalenderRow extends StatefulWidget {
  const CalenderRow({super.key});

  @override
  _CalenderRowState createState() => _CalenderRowState();
}

class _CalenderRowState extends State<CalenderRow> {
  DateTime? startDate;
  DateTime? endDate;

  void _onStartDateSelected(DateTime date) {
    setState(() {
      startDate = date;
    });
    _fetchReportsIfDatesSelected();
  }

  void _onEndDateSelected(DateTime date) {
    setState(() {
      endDate = date;
    });
    _fetchReportsIfDatesSelected();
  }

  void _fetchReportsIfDatesSelected() {
    if (startDate != null && endDate != null) {
      context.read<ReportsCubit>().getReportsBetweenSelectedDates(
            startDate: startDate!,
            endDate: endDate!,
          );
    } else {
      context.read<ReportsCubit>().getReports();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        DatePickerWidget(
          containerColor: AppColors.lightGreen,
          onDateSelected: _onStartDateSelected,
        ),
        SizedBox(width: 22.w),
        DatePickerWidget(
          containerColor: AppColors.moreYellower,
          onDateSelected: _onEndDateSelected,
        ),
      ],
    );
  }
}
