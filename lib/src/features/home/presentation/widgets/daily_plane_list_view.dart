import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/src/features/home/data/models/visit_card_model.dart';
import 'package:mandopy/src/features/home/presentation/widgets/daily_plane_item_card.dart';

class DailyPlanListView extends StatelessWidget {
  final List<VisitCardModel> visits;

  const DailyPlanListView({
    super.key,
    required this.visits,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
        height: 100.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: visits.length,
          itemBuilder: (context, index) {
            final visit = visits[index];
            return Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: DailyPlaneItemCard(
                doctorName: visit.doctorName,
                time: visit.time,
                status: visit.status,
                statusColor: visit.statusColor,
                icon: Icon(visit.icon, color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
