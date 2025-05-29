import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class NumberOfVisitRow extends StatelessWidget {
  const NumberOfVisitRow({super.key, required this.visitNumber});
  final String visitNumber;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'زيارة $visitNumber',
            style: AppStyles.s20.copyWith(
              color: AppColors.accentColor,
              fontSize: 16.sp,
            ),
          ),
          Icon(
            Icons.edit_note_rounded,
            color: AppColors.primaryColor,
            size: 24.r,
          )
        ],
      ),
    );
  }
}
