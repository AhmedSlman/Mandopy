import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';

class RadioOption extends StatelessWidget {
  final String choice;
  final String? groupValue;
  final ValueChanged<String?> onChanged;

  const RadioOption({
    super.key,
    required this.choice,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          activeColor: AppColors.accentColor,
          value: choice,
          groupValue: groupValue,
          onChanged: onChanged,
        ),
        Text(choice),
      ],
    );
  }
}
