// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/utils/app_strings.dart';

import '../components/calender_row.dart';
import '../components/reports_list_view.dart';
import '../widgets/report_search_widget.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(
            title: AppStrings.reports,
          ),
          SizedBox(
            height: 33.h,
          ),
          const CalenderRow(),
          SizedBox(
            height: 10.h,
          ),
          const ReportSearchWidget(),
          SizedBox(
            height: 13.h,
          ),
          const ReportsListView(),
        ],
      ),
    );
  }
}
