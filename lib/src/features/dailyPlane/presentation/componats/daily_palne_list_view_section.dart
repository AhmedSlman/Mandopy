import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/widgets/visit_card_widget.dart';

import '../../cubit/vistiCubit/visit_cubit.dart';
import '../../cubit/vistiCubit/visit_state.dart';

class DailyPlanListViewSection extends StatelessWidget {
  const DailyPlanListViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<VisitCubit, VisitState>(
          builder: (context, state) {
            if (state is VisitLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is VisitsLoaded) {
              final visits = state.visits;
              return ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: visits.length,
                itemBuilder: (context, index) {
                  final visit = visits[index];
                  return BlocProvider(
                    create: (context) => getIt<VisitCubit>(),
                    child: VisitCardWidget(
                      visitNumber: visit.id.toString(),
                      nameOfGoal:
                          visit.pharmacy?.name ?? visit.doctor?.name ?? '',
                      address: visit.pharmacy?.address ??
                          visit.doctor?.address ??
                          '',
                      time: visit.time,
                      item: visit.medication?.name ?? '',
                      isPharmacy: true,
                      isCompleated:
                          visit.status == "قيد الأنتظار" ? false : true,
                      visitId: visit.id.toString(),
                    ),
                  );
                },
              );
            } else if (state is VisitError) {
              return Text(
                state.error.message,
              );
            } else {
              return const Center(
                child: Text('No visits available'),
              );
            }
          },
        ),
      ),
    );
  }
}
