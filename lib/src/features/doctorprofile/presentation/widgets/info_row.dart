import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class InfoRow extends StatelessWidget {
  const InfoRow({
    super.key,
    required this.infoIcon,
    required this.infoText,
  });
  final String infoIcon;
  final String infoText;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.asset(
          infoIcon,
          height: 20.h,
          width: 20.w,
        ),
        const SizedBox(
          width: 9,
        ),
        Text(infoText),
      ],
    );
  }
}
