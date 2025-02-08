import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../data/models/visit_card_model.dart';
import '../widgets/daily_goals_title.dart';
import '../widgets/daily_plane_list_view.dart';

class DailyPlaneSection extends StatelessWidget {
 const DailyPlaneSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
         GoalsTitle(title: AppStrings.dailuPlane),
        DailyPlanListView(),
      ],
    );
  }
}
