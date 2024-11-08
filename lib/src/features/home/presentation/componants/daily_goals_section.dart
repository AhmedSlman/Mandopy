import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mandopy/core/utils/app_strings.dart';

import 'package:mandopy/src/features/home/presentation/widgets/daily_goals_title.dart';
import 'package:mandopy/src/features/home/presentation/widgets/progress_bar_widget.dart';

import '../../cubit/percentage/cubit/percentage_cubit.dart';

class DailyGoalsSection extends StatelessWidget {
  const DailyGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GoalsTitle(
          title: AppStrings.dailyGoals,
          hent: AppStrings.visit6Doctors,
        ),
        BlocBuilder<PercentageCubit, PercentageState>(
          builder: (context, state) {
            if (state is PercentageLoading) {
              return const CircularProgressIndicator();
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
