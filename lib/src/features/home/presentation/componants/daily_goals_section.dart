import 'package:flutter/material.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/home/data/models/visit_card_model.dart';

import 'package:mandopy/src/features/home/presentation/widgets/daily_goals_title.dart';
import 'package:mandopy/src/features/home/presentation/widgets/progress_bar_widget.dart';

class DailyGoalsSection extends StatelessWidget {
  const DailyGoalsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        GoalsTitle(
          title: AppStrings.dailyGoals,
          hent: AppStrings.visit6Doctors,
        ),
        ProgressBarWidget(
          progress: 0.6,
        ),
      ],
    );
  }
}
