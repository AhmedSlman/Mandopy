import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';
import '../../data/models/performance_data_model.dart';

class PerformanceDataItemCard extends StatelessWidget {
  final PerformanceData data;

  const PerformanceDataItemCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 188.w,
      height: 108.h,
      decoration: BoxDecoration(
        color: AppColors.lightGreen,
        borderRadius: BorderRadius.circular(11),
      ),
      child: Column(
        children: [
          SizedBox(height: 19.h),
          SvgPicture.asset(
            data.iconPath,
            width: 21.w,
            height: 20.h,
          ),
          SizedBox(height: 6.h),
          Text(
            data.title,
            style: AppStyles.s10.copyWith(
              color: AppColors.greyForText,
            ),
          ),
          SizedBox(height: 4.h),
          Text(
            data.value,
            maxLines: 1,
            style: AppStyles.s20.copyWith(
              fontWeight: FontWeight.w600,
              color: data.valueColor ?? AppColors.accentColor,
            ),
          ),
        ],
      ),
    );
  }
}
