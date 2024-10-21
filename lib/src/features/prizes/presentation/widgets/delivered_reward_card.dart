import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_styles.dart';

class DeliveriedRewardCard extends StatelessWidget {
  const DeliveriedRewardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 402.w,
      height: 54.h,
      padding: EdgeInsets.symmetric(
        horizontal: 12.w,
      ),
      decoration: BoxDecoration(
        color: AppColors.greyForBackground,
        borderRadius: BorderRadius.circular(
          17,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                "الميداليه البرونزية",
                style: AppStyles.s12.copyWith(
                  color: AppColors.primaryColor,
                ),
              ),
              SizedBox(
                width: 2.w,
              ),
              SvgPicture.asset(
                AppAssets.medalIcon,
                width: 13.w,
                height: 12.h,
                color: AppColors.primaryColor,
              ),
            ],
          ),
          Text(
            '2-2-2024',
            style: AppStyles.s10.copyWith(
              color: AppColors.greyForText,
            ),
          ),
          Text(
            'تم التسليم',
            style: AppStyles.s10.copyWith(
              color: AppColors.greyForText,
            ),
          ),
        ],
      ),
    );
  }
}
