import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import '../../../../../core/services/service_locator.dart';
import '../widgets/visit_card_widget.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
              // Skeleton loading UI
              return Skeletonizer(
                enabled: true,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 10.h),
                      height: 262.82.h,
                      width: 389.w,
                      color: Colors.grey.shade300,
                    );
                  },
                ),
              );
            } else if (state is VisitsLoaded) {
              if (state.visits.isEmpty) {
                return Center(
                  child: Lottie.asset(
                    'assets/images/no_tasks.json',
                  ),
                );
              } else {
                return ListView.builder(
                  padding: EdgeInsets.zero,
                  itemCount: state.visits.length,
                  itemBuilder: (context, index) {
                    final visit = state.visits[index];
                    return BlocProvider(
                      create: (context) => getIt<VisitCubit>(),
                      child: VisitCardWidget(
                        visitNumber: visit.id.toString(),
                        nameOfGoal:
                            visit.pharmacy?.name ?? visit.doctor?.name ?? '',
                        address: visit.pharmacy?.address ??
                            visit.doctor?.address ??
                            '',
                        time: visit.time ?? "N/A",
                        item: visit.medications != null &&
                                visit.medications!.isNotEmpty
                            ? visit.medications!
                                .map((med) => med.name)
                                .join(", ")
                            : "N/A",
                        isPharmacy: visit.pharmacy != null,
                        pharmacyid: visit.pharmacy?.id.toString() ?? '',
                        doctorId: visit.doctor?.id.toString() ?? '',
                        isCompleated: visit.status != "قيد الأنتظار",
                        visitId: visit.id.toString(),
                      ),
                    );
                  },
                );
              }
            } else {
              return Center(
                child: Text(
                  'Something went wrong. Please try again.',
                  style: TextStyle(fontSize: 16.sp),
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
