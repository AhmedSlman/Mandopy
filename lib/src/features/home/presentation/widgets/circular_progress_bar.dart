import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';
import 'package:mandopy/src/features/home/cubit/percentage/cubit/percentage_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import 'progress_bar_widget.dart';

class CircularProgressBarWidget extends StatelessWidget {
  const CircularProgressBarWidget({
    super.key,
    required this.progressValue,
  });
  final double progressValue;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73.h,
      width: 390.w,
      decoration: BoxDecoration(
        color: AppColors.greyForBackground,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: BlocBuilder<PercentageCubit, PercentageState>(
          builder: (context, state) {
            if (state is PercentageLoading) {
              return Skeletonizer(
                containersColor: Colors.grey.shade300,
                enabled: true,
                child: Container(
                  color: Colors.grey.shade300,
                ),
              );
            }
            if (state is MonthlyTargetLoaded) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "You have ${state.montlyTargetModel.monthlyTarget.toString()} visits this month",
                  ),
                  const Spacer(),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        strokeWidth: 10,
                        value: double.parse(state.montlyTargetModel.percentage
                                    ?.replaceAll('%', '') ??
                                "N/A") /
                            100,
                        backgroundColor: AppColors.yellow,
                        color: AppColors.primaryColor,
                      ),
                      Text(
                        state.montlyTargetModel.percentage ?? "N/A",
                        style: AppStyles.s12.copyWith(
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              );
            } else {
              return const Text('No data available');
            }
          },
        ),
      ),
    );
  }
}
