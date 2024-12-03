import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class ReportCardInfo extends StatelessWidget {
  final String title;
  final String value;
  const ReportCardInfo({
    super.key,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          title,
          style: AppStyles.s14.copyWith(
            color: AppColors.textColor,
          ),
        ),
        Flexible(
          child: Text(
            value,
            style: AppStyles.s14.copyWith(
              color: AppColors.greyForText,
            ),
          ),
        ),
      ],
    );
  }
}
