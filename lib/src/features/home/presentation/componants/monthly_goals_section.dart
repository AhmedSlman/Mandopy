import 'package:flutter/material.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/home/presentation/widgets/circular_progress_bar.dart';
import 'package:mandopy/src/features/home/presentation/widgets/daily_goals_title.dart';

class MonthlyGoalsSection extends StatelessWidget {
  const MonthlyGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        GoalsTitle(title: AppStrings.monthlyGoals),
        CircularProgressBarWidget(progressValue: 0.6)
      ],
    );
  }
}
