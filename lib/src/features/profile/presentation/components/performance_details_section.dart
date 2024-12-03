import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../cubit/statistics/cubit/statistics_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../data/models/performance_data_model.dart';
import '../widgets/performance_data_item_card.dart';

class PerformanceDetailsSection extends StatelessWidget {
  const PerformanceDetailsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.performanceDetails,
          style: AppStyles.s16,
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 300.h,
          child: BlocBuilder<StatisticsCubit, StatisticsState>(
            builder: (context, state) {
              if (state is StatisticsLoading) {
                return Skeletonizer(
                  enabled: true,
                  child: GridView.builder(
                    padding: EdgeInsets.zero,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 16.h,
                      crossAxisSpacing: 16.w,
                      childAspectRatio: 1.65,
                    ),
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return SizedBox(
                        height: 120,
                        width: 100,
                        child: Card(
                          color: Colors.grey.shade300,
                        ),
                      );
                    },
                  ),
                );
              } else if (state is StatisticsLoaded) {
                List<PerformanceData> performanceData = [
                  PerformanceData(
                    iconPath: AppAssets.visitsIcon,
                    title: 'عدد الزيارات المكتملة هذا الشهر',
                    value: state.statisticsModel.allVisits.toString(),
                  ),
                  PerformanceData(
                    iconPath: AppAssets.flagIcon,
                    title: 'عدد الاهداف المحققة هذا الشهر',
                    value: state.statisticsModel.completedVisits.toString(),
                  ),
                  PerformanceData(
                    iconPath: AppAssets.drugIcon,
                    title: 'افضل ماده فعالة مسوقه',
                    value: state.statisticsModel.mostSoldMedication ?? 'N/A',
                  ),
                  PerformanceData(
                    iconPath: AppAssets.banIcon,
                    title: 'عدد الزيارات الغير مكتملة',
                    value: state.statisticsModel.pendingVisits.toString(),
                    valueColor: Colors.red,
                  ),
                ];

                return GridView(
                  padding: EdgeInsets.zero,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 16.h,
                    crossAxisSpacing: 16.w,
                    childAspectRatio: 1.65,
                  ),
                  children: performanceData.map((data) {
                    return PerformanceDataItemCard(data: data);
                  }).toList(),
                );
              } else {
                return const SizedBox();
              }
            },
          ),
        ),
      ],
    );
  }
}
