import 'package:flutter/material.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/home/presentation/componants/add_new_visit_section.dart';
import 'package:mandopy/src/features/home/presentation/componants/daily_goals_section.dart';
import 'package:mandopy/src/features/home/presentation/componants/daily_plane_section.dart';
import 'package:mandopy/src/features/home/presentation/componants/monthly_goals_section.dart';
import 'package:mandopy/src/features/home/presentation/componants/notification_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const CustomAppBar(
                  title: AppStrings.home,
                  iconleft: Icons.menu,
                  iconright: Icons.notifications),
              const DailyGoalsSection(),
              const MonthlyGoalsSection(),
              NotificationSection(),
              const AddNewVisitSection(),
              DailyPlaneSection()
            ],
          ),
        ),
      ),
    );
  }
}
