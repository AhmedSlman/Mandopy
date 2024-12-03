import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/common/widgets/custom_btn.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_styles.dart';

class RewardCard extends StatelessWidget {
  final String rewardName;
  final String rewardPrice;
  final String rewardPoints;
  final VoidCallback onButtonPressed;

  const RewardCard({
    super.key,
    required this.rewardName,
    required this.rewardPrice,
    required this.rewardPoints,
    required this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 404.w,
      height: 110.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(22),
        color: AppColors.lightGreen,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 12.w,
          vertical: 4.h,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              textHeightBehavior: const TextHeightBehavior(
                applyHeightToFirstAscent: false,
                applyHeightToLastDescent: false,
              ),
              text: TextSpan(
                children: [
                  TextSpan(
                    text: rewardName,
                    style: AppStyles.s14.copyWith(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: '\u00A0\u00A0'),
                  TextSpan(
                    text: 'قدرها $rewardPrice',
                    style: AppStyles.s12.copyWith(
                      color: AppColors.greyForText,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  rewardPoints,
                  style: AppStyles.s16.copyWith(
                    color: AppColors.accentColor,
                  ),
                ),
                CustomButton(
                  textStyle: AppStyles.s8.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                  ),
                  text: 'استرداد المكافأة',
                  backgroundColor: AppColors.accentColor,
                  onPressed: onButtonPressed,
                  borderRadius: BorderRadius.circular(
                    7,
                  ),
                  width: 73.w,
                  height: 25.h,
                ),
              ],
            ),
            Text(
              'للحصول علي $rewardName يجب ان تمتلك بحد ادني $rewardPoints مكتسبة',
              style: AppStyles.s8.copyWith(
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
