import 'package:flutter/material.dart';

import '../../../../../core/utils/app_styles.dart';

class ProfileDetailsInfo extends StatelessWidget {
  final String title;
  final Widget value;
  const ProfileDetailsInfo({
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
          style: AppStyles.s14,
        ),
        value,
      ],
    );
  }
}