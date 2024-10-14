import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';

class DailyPlanCard extends StatelessWidget {
  const DailyPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      padding: EdgeInsetsDirectional.all(10.h),
      decoration: BoxDecoration(
        color: AppColors.openGrey,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.pharmcyIcon,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 12.w,
                  ),
                  const Text('صيدلية العزبي'),
                ],
              ),
              SizedBox(
                height: 10.h,
              ),
              Row(
                children: [
                  SvgPicture.asset(
                    AppAssets.drugIcon,
                    width: 20.w,
                    height: 20.h,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  const Text('إراستابيكس كو'),
                ],
              ),
            ],
          ),
          Column(
            children: [
              CustomButton(
                backgroundColor: AppColors.moreYellower,
                borderRadius: BorderRadius.circular(
                  5,
                ),
                width: 70.w,
                height: 22.h,
                textStyle: const TextStyle(
                  color: Colors.black,
                ),
                text: 'تعديل',
                onPressed: () {},
              ),
              SizedBox(height: 4.h),
              CustomButton(
                backgroundColor: AppColors.errorColor,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                borderRadius: BorderRadius.circular(
                  5,
                ),
                width: 70.w,
                height: 22.h,
                text: 'حذف',
                onPressed: () {},
              ),
            ],
          ),
        ],
      ),
    );
  }
}