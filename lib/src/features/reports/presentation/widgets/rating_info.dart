import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class RatingInfo extends StatelessWidget {
  const RatingInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'التقييم:',
          style: AppStyles.s14.copyWith(
            color: AppColors.textColor,
          ),
        ),
        RatingBarIndicator(
          rating: 4,
          itemBuilder: (context, index) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 20.h,
          direction: Axis.horizontal,
        ),
      ],
    );
  }
}