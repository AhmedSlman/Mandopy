import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/common/widgets/custom_app_bar.dart';
import '../../../../../core/routes/router_names.dart';
import '../../../../../core/utils/app_strings.dart';
import '../componats/daily_palne_list_view_section.dart';
import '../widgets/floating_button_widget.dart';

import '../../../../../core/services/service_locator.dart';
import '../../cubit/vistiCubit/visit_cubit.dart';
import '../../data/repo/visitRepo/vistit_repo.dart';

class DailyPlaneView extends StatelessWidget {
  const DailyPlaneView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const CustomAppBar(title: AppStrings.dailuPlane),
          BlocProvider(
            create: (context) =>
                VisitCubit(getIt<VisitRepoAbstract>())..getAllVisits(),
            child: const DailyPlanListViewSection(),
          )
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
