import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../widgets/daily_plan_card.dart';

class AddDailyPlanListView extends StatelessWidget {
  const AddDailyPlanListView({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200.h,
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: 2,
        itemBuilder: (context, index) {
          return const DailyPlanCard();
        },
        separatorBuilder: (context, index) {
          return SizedBox(
            height: 13.h,
          );
        },
      ),
    );
  }
}
