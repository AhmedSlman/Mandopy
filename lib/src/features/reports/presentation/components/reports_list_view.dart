import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/src/features/reports/cubit/reports_cubit.dart';
import 'package:mandopy/src/features/reports/presentation/widgets/report_card_widget.dart';

class ReportsListView extends StatelessWidget {
  const ReportsListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: BlocBuilder<ReportsCubit, ReportsState>(
        builder: (context, state) {
          if (state is ReportsLoading) {
            return const CircularProgressIndicator();
          } else if (state is ReportsLoaded) {
            return ListView.separated(
              padding: EdgeInsets.zero,
              itemCount: state.reports.length,
              itemBuilder: (context, index) {
                return ReportCardWidget(
                  index: index,
                  reports: state.reports[index],
                );
              },
              separatorBuilder: (BuildContext context, int index) {
                return SizedBox(
                  height: 10.h,
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}
