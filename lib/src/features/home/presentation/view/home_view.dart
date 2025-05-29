import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/services/service_locator.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../auth/cubit/auth_cubit.dart';
import '../../cubit/percentage/cubit/percentage_cubit.dart';
import '../components/custom_drawer.dart';
import '../components/daily_goals_section.dart';
import '../components/monthly_goals_section.dart';
import '../components/notification_section.dart';

import '../../../dailyPlane/cubit/vistiCubit/visit_cubit.dart';
import '../../../dailyPlane/data/repo/visitRepo/vistit_repo.dart';
import '../components/daily_plane_section.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.grey[50],
      drawer: BlocProvider(
        create: (context) => getIt<AuthCubit>(),
        child: const CustomDrawer(),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              CustomAppBar(
                title: AppStrings.home,
                iconleft: Icons.menu,
                onPressedLeft: () {
                  scaffoldKey.currentState!.openDrawer();
                },
              ),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: BlocProvider(
                      create: (context) =>
                          getIt<PercentageCubit>()..getPercentagePerDay(),
                      child: const DailyGoalsSection(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: BlocProvider(
                      create: (context) =>
                          getIt<PercentageCubit>()..getMonthlyTarget(),
                      child: const MonthlyGoalsSection(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: const NotificationSection(),
                  ),
                ),
              ),
              SizedBox(height: 16.h),
              SizedBox(
                width: double.infinity,
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.r),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: BlocProvider(
                      create: (context) =>
                          VisitCubit(getIt<VisitRepoAbstract>())
                            ..getAllVisits(),
                      child: DailyPlaneSection(),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 24.h),
            ],
          ),
        ),
      ),
    );
  }
}
