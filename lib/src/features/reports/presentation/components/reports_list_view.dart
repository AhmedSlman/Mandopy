import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../cubit/reports_cubit.dart';
import '../widgets/report_card_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

class ReportsListView extends StatelessWidget {
  const ReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          // Check if reports are loaded and empty
          if (state is ReportsLoaded && state.reports.isEmpty) {
            return Center(
              child: Lottie.asset(
                'assets/images/empty_reports.json',
              ),
            );
          }

          return Skeletonizer(
            enabled: state is ReportsLoading,
            child: ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: state is ReportsLoaded ? state.reports.length : 5,
              itemBuilder: (context, index) {
                if (state is ReportsLoaded) {
                  // Return a report card for each report
                  return ReportCardWidget(
                    index: index,
                    reports: state.reports[index],
                  );
                } else {
                  // Placeholder for loading state
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: 10.h),
                    height: 300.h,
                    width: 394.w,
                    color: Colors.grey.shade300,
                  );
                }
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
