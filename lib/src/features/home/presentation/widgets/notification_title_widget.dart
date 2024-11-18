import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';

class NotificationTitleWidget extends StatelessWidget {
  const NotificationTitleWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: const Row(
        children: [
          Text(
            AppStrings.notifications,
            style: AppStyles.s18,
          ),
          Spacer(),
          Icon(
            Icons.notifications,
            color: AppColors.primaryColor,
          )
        ],
      ),
    );
  }
}
