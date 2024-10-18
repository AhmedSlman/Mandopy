import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';
import 'rating_info.dart';
import 'report_card_info.dart';

class ReportCardWidget extends StatelessWidget {
  final int index;
  const ReportCardWidget({
    super.key,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 394.w,
      height: 300.h,
      margin: EdgeInsets.symmetric(
        horizontal: 16.w,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 10.h,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.greyForBackground,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
            color: const Color.fromRGBO(0, 0, 0, .05),
            blurRadius: 4.h,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'تقرير ${index + 1}',
            style: AppStyles.s16.copyWith(
              color: AppColors.accentColor,
            ),
          ),
          SizedBox(
            height: 4.h,
          ),
          Padding(
            padding: EdgeInsets.only(right: 10.w),
            child: Column(
              children: [
                const ReportCardInfo(
                  title: 'اسم الطبيب/ الصيدلية:',
                  value: 'صيدلية العزبي',
                ),
                SizedBox(
                  height: 2.h,
                ),
                const ReportCardInfo(
                  title: 'الموقع:',
                  value: ' حي الجامعة ',
                ),
                SizedBox(
                  height: 2.h,
                ),
                const ReportCardInfo(
                  title: 'التاريخ:',
                  value: ' 20يناير 2024',
                ),
                SizedBox(
                  height: 2.h,
                ),
                const ReportCardInfo(
                  title: 'الوقت: ',
                  value: ' 3:30 AM',
                ),
                SizedBox(
                  height: 2.h,
                ),
                const ReportCardInfo(
                  title: 'المادة الفعالة/الدواء المسوق:',
                  value: ' إراستابيكس كو',
                ),
                SizedBox(
                  height: 2.h,
                ),
                const ReportCardInfo(
                  title: 'مدة الزيارة:',
                  value: ' 3:30 AM',
                ),
                SizedBox(
                  height: 2.h,
                ),
                const ReportCardInfo(
                  title: 'الملاحظات:',
                  value: '  ملاحظات............',
                ),
                SizedBox(
                  height: 8.h,
                ),
                const RatingInfo(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.centerLeft,
            child: CustomButton(
              width: 85.w,
              height: 30.h,
              borderRadius: BorderRadius.circular(
                2,
              ),
              textStyle: AppStyles.s10,
              text: AppStrings.showDetails,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
