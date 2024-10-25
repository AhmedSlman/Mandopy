import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/app_assets.dart';
import '../../../../../core/utils/app_strings.dart';
import '../../../../../core/utils/app_styles.dart';

class TotalRewardedPrizesContainer extends StatelessWidget {
  const TotalRewardedPrizesContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 404.w,
      height: 129.h,
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          top: 5.h,
          right: 8.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  AppStrings.rewardedPrizes,
                  style: AppStyles.s10.copyWith(
                    color: AppColors.accentColor,
                  ),
                ),
                const Icon(
                  Icons.emoji_events,
                  color: AppColors.accentColor,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                right: 6.w,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '120 نقطة',
                    style: AppStyles.s16.copyWith(
                      color: AppColors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  RichText(
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: "ستحصل علي الميدالية الفضية",
                          style: AppStyles.s10.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        WidgetSpan(
                          child: SvgPicture.asset(
                            AppAssets.medalIcon,
                            width: 13.w,
                            height: 12.h,
                          ),
                        ),
                        TextSpan(
                          text: " عند حصولك علي 80 نقطه اضافية.",
                          style: AppStyles.s10.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            Align(
              alignment: Alignment.center,
              child: SizedBox(
                width: 279.w,
                child: LinearProgressIndicator(
                  borderRadius: BorderRadius.circular(
                    4,
                  ),
                  value: .6,
                  backgroundColor: AppColors.white,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                      AppColors.accentColor),
                  minHeight: 9.h,
                ),
              ),
            ),
            SizedBox(
              height: 7.h,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                'لقد حققت 60% من الهدف',
                style: AppStyles.s10.copyWith(
                  color: AppColors.grey,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}