import 'package:flutter/material.dart';
import 'package:mandopy/src/features/dailyPlane/data/visit_model.dart';
import 'package:mandopy/src/features/dailyPlane/presentation/widgets/visit_card_widget.dart';

class DailyPlanListViewSection extends StatelessWidget {
  const DailyPlanListViewSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SizedBox(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            padding: EdgeInsets.zero,
            itemCount: visits.length,
            itemBuilder: (context, index) {
              final visit = visits[index];
              return VisitCardWidget(
                visitNumber: visit['visitNumber'],
                nameOfGoal: visit['nameOfGoal'],
                address: visit['address'],
                time: visit['time'],
                item: visit['item'],
                isPharmacy: visit['isPharmacy'],
                isCompleated: visit['isCompleated'],
              );
            },
          ),
        ),
      ),
    );
  }
}
