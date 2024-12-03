import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/utils/app_strings.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../widgets/daily_goals_title.dart';
import '../widgets/progress_bar_widget.dart';

import '../../cubit/percentage/cubit/percentage_cubit.dart';

class DailyGoalsSection extends StatelessWidget {
  const DailyGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GoalsTitle(
          title: AppStrings.dailyGoals,
          // hent: AppStrings.visit6Doctors,
        ),
        BlocBuilder<PercentageCubit, PercentageState>(
          builder: (context, state) {
            if (state is PercentageLoading) {
              return Skeletonizer(
                containersColor: Colors.grey.shade300,
                enabled: true,
                child: const ProgressBarWidget(progress: 0.0),
              );
            } else if (state is PercentageLoaded) {
              return ProgressBarWidget(progress: state.value / 100);
            } else if (state is PercentageError) {
              return Text(
                state.error.message,
                style: const TextStyle(color: Colors.red),
              );
            } else {
              return const ProgressBarWidget(progress: 0.0);
            }
          },
        ),
      ],
    );
  }
}
