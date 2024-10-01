import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class DailyPlaneItemCard extends StatelessWidget {
  const DailyPlaneItemCard({
    super.key,
    required this.doctorName,
    required this.time,
    required this.status,
    required this.statusColor,
    required this.icon,
  });

  final String doctorName;
  final String time;
  final String status;
  final Color statusColor;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80.h,
      width: 120.w,
      decoration: BoxDecoration(
        color: statusColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              doctorName,
              style: AppStyles.s12.copyWith(color: AppColors.white),
            ),
            Text(
              time,
              style: AppStyles.s12.copyWith(
                color: AppColors.white,
                fontSize: 10.sp,
              ),
            ),
            Row(
              children: [
                Text(
                  status,
                  style: AppStyles.s12.copyWith(color: AppColors.white),
                ),
                SizedBox(width: 8.w), // إضافة مسافة بين النص والأيقونة
                icon, // عرض الأيقونة
              ],
            ),
          ],
        ),
      ),
    );
  }
}
