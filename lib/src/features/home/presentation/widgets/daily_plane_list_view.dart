import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../../dailyPlane/cubit/vistiCubit/visit_cubit.dart';
import '../../../dailyPlane/cubit/vistiCubit/visit_state.dart';
import '../../data/models/visit_card_model.dart';
import 'daily_plane_item_card.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/theme/app_colors.dart';

class DailyPlanListView extends StatelessWidget {
  const DailyPlanListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: SizedBox(
        height: 100.h,
        child: BlocBuilder<VisitCubit, VisitState>(
          builder: (context, state) {
            if (state is VisitLoading) {
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Skeletonizer(
                      child: Container(
                        width: 120.w,
                        height: 80.h,
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is VisitsLoaded) {
              if (state.visits.isEmpty) {
                return Center(
                  child: Text(
                    'No visits available',
                    style: AppStyles.s16,
                  ),
                );
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.visits.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: DailyPlaneItemCard(
                      doctorName: state.visits[index].doctor?.name ??
                          state.visits[index].pharmacy?.name ??
                          'N/A',
                      time: state.visits[index].time ?? "N/A",
                      status: state.visits[index].status ?? "N/A",
                      statusColor: state.visits[index].status == "أكتملت"
                          ? AppColors.primaryColor
                          : state.visits[index].status == "جارية"
                              ? AppColors.gereen
                              : AppColors.accentColor,
                      icon: state.visits[index].status == "أكتملت"
                          ? const Icon(
                              Icons.done,
                              color: Colors.white,
                            )
                          : state.visits[index].status == "جارية"
                              ? const Icon(
                                  Icons.check_circle,
                                  color: Colors.white,
                                )
                              : const Icon(
                                  Icons.timer,
                                  color: Colors.white,
                                ),
                    ),
                  );
                },
              );
            } else {
              return const Text('No Data');
            }
          },
        ),
      ),
    );
  }
}
