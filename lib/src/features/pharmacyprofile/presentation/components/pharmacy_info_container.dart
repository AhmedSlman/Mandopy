import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../doctorprofile/presentation/widgets/info_row.dart';

class PharmacyInfoContainer extends StatelessWidget {
  const PharmacyInfoContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 373.w,
      height: 280.h,
      margin: EdgeInsets.only(left: 8.h),
      padding: EdgeInsets.symmetric(horizontal: 18.h, vertical: 26.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: const Color.fromRGBO(
            247,
            247,
            247,
            1,
          ),
          width: 1.h,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 2.h,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const InfoRow(
            infoIcon: AppAssets.inVisit,
            infoText: 'صيدلية العزبي',
          ),
          const SizedBox(
            height: 15,
          ),
          const InfoRow(
            infoIcon: AppAssets.inVisit,
            infoText: 'المنصورة فرع حي الجامعة وكالة ابو رية',
          ),
          const SizedBox(
            height: 15,
          ),
          const InfoRow(
            infoIcon: AppAssets.inVisit,
            infoText: '01234749782073',
          ),
          const SizedBox(
            height: 15,
          ),
          const InfoRow(
            infoIcon: AppAssets.inVisit,
            infoText: 'طوال الاسبوع',
          ),
          const SizedBox(
            height: 21,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              CustomButton(
                width: 97.w,
                height: 26.h,
                text: 'بدء الزيارة',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                onPressed: () {},
              ),
              const SizedBox(
                width: 16,
              ),
              CustomButton(
                backgroundColor: AppColors.accentColor,
                width: 97.w,
                height: 26.h,
                text: 'انهاء الزيارة',
                textStyle: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      ),
    );
  }
}