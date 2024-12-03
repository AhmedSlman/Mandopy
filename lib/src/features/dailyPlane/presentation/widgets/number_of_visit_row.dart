import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class NumberOfVisitRow extends StatelessWidget {
  const NumberOfVisitRow({super.key, required this.visitNumber});
  final String visitNumber;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'زيارة $visitNumber',
          style: AppStyles.s20.copyWith(color: AppColors.accentColor),
        ),
        const Spacer(),
        const Icon(
          Icons.edit_note_rounded,
          color: AppColors.primaryColor,
          size: 30,
        )
      ],
    );
  }
}
