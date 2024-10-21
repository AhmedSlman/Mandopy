import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../data/models/performance_data_model.dart';
import '../widgets/performance_data_item_card.dart';

class PerformanceDetailsSection extends StatelessWidget {
  const PerformanceDetailsSection({super.key});

  List<PerformanceData> _getPerformanceData() {
    return [
      PerformanceData(
        iconPath: AppAssets.visitsIcon,
        title: 'عدد الزيارات المكتملة هذا الشهر',
        value: '45',
      ),
      PerformanceData(
        iconPath: AppAssets.flagIcon,
        title: 'عدد الاهداف المحققة هذا الشهر',
        value: '30',
      ),
      PerformanceData(
        iconPath: AppAssets.drugIcon,
        title: 'افضل ماده فعالة مسوقه',
        value: 'إراستابيكس كو',
      ),
      PerformanceData(
        iconPath: AppAssets.banIcon,
        title: 'عدد الزيارات الغير مكتملة',
        value: '6',
        valueColor: Colors.red,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final performanceData = _getPerformanceData();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppStrings.performanceDetails,
          style: AppStyles.s16,
        ),
        SizedBox(
          height: 300.h,
          child: GridView.builder(
            itemCount: performanceData.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16.h,
              crossAxisSpacing: 16.w,
              childAspectRatio: 1.65,
            ),
            itemBuilder: (context, index) {
              return PerformanceDataItemCard(data: performanceData[index]);
            },
          ),
        ),
      ],
    );
  }
}
