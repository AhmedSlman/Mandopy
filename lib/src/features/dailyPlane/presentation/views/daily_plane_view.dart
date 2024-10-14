import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/routes/router_names.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/componats/daily_palne_list_view_section.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/widgets/floating_button_widget.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/widgets/visit_card_widget.dart';

class DailyPlaneView extends StatelessWidget {
  const DailyPlaneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          CustomAppBar(title: AppStrings.dailuPlane),
          DailyPlanListViewSection()
        ],
      ),
      floatingActionButton: FloatingButtonWidget(
        onPressed: () {
          GoRouter.of(context).push(RouterNames.addDailyPlan);
        },
      ),
    );
  }
}
