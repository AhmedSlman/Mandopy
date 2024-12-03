import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class VisitItemRowWidget extends StatelessWidget {
  const VisitItemRowWidget(
      {super.key, required this.title, required this.icon});
  final String title;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: AppColors.primaryColor,
        ),
        SizedBox(
          width: 6.w,
        ),
        Text(
          title,
          style: AppStyles.s16,
        )
      ],
    );
  }
}
