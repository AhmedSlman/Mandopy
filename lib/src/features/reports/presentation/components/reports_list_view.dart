import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/src/features/reports/presentation/widgets/report_card_widget.dart';

class ReportsListView extends StatelessWidget {
  const ReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        itemCount: 3,
        itemBuilder: (context, index) {
          return ReportCardWidget(
            index: index,
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10.h,
          );
        },
      ),
    );
  }
}
