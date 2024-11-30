import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../cubit/percentage/cubit/percentage_cubit.dart';
import '../componants/custom_drawer.dart';
import '../componants/daily_goals_section.dart';
import '../componants/monthly_goals_section.dart';
import '../componants/notification_section.dart';

import '../../../dailyPlane/cubit/vistiCubit/visit_cubit.dart';
import '../../../dailyPlane/data/repo/visitRepo/vistit_repo.dart';
import '../componants/daily_plane_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      drawer: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const CustomDrawer(),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              CustomAppBar(
                title: AppStrings.home,
                iconleft: Icons.menu,
                onPressedLeft: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
              BlocProvider(
                create: (context) =>
                    getIt<PercentageCubit>()..getPercentagePerDay(),
                child: const DailyGoalsSection(),
              ),
              BlocProvider(
                create: (context) =>
                    getIt<PercentageCubit>()..getMonthlyTarget(),
                child: const MonthlyGoalsSection(),
              ),
              const NotificationSection(),
              // const AddNewVisitSection(),
              BlocProvider(
                create: (context) =>
                    VisitCubit(getIt<VisitRepoAbstract>())..getAllVisits(),
                child: DailyPlaneSection(),
              )
            ],
          ),
        ),
      ),
    );
  }
}
