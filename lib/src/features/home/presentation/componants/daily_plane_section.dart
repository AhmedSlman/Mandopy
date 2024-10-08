import 'package:flutter/material.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/home/data/models/visit_card_model.dart';
import 'package:mandopy/src/features/home/presentation/widgets/daily_goals_title.dart';
import 'package:mandopy/src/features/home/presentation/widgets/daily_plane_list_view.dart';

class DailyPlaneSection extends StatelessWidget {
  DailyPlaneSection({super.key});

  final List<VisitCardModel> visits = [
    VisitCardModel(
      doctorName: 'أحمد سلطان',
      time: '2:00 PM',
      status: 'تم الانتهاء',
      statusColor: AppColors.primaryColor,
      icon: Icons.done,
    ),
    VisitCardModel(
      doctorName: 'شعيب',
      time: '6:00 PM',
      status: 'في زيارة',
      statusColor: AppColors.gereen,
      icon: Icons.check_circle,
    ),
    VisitCardModel(
      doctorName: 'الجندي',
      time: '6:00 PM',
      status: 'قيد الانتظار',
      statusColor: AppColors.accentColor,
      icon: Icons.timer,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const GoalsTitle(title: AppStrings.dailuPlane),
        DailyPlanListView(visits: visits),
      ],
    );
  }
}
