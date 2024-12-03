import 'package:flutter/material.dart';
import '../../../../../core/utils/app_strings.dart';
import '../widgets/circular_progress_bar.dart';
import '../widgets/daily_goals_title.dart';

class MonthlyGoalsSection extends StatelessWidget {
  const MonthlyGoalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        GoalsTitle(title: AppStrings.monthlyGoals),
        CircularProgressBarWidget()
      ],
    );
  }
}
