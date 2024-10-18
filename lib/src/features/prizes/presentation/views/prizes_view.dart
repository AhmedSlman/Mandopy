import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mandopy/app.dart';
import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/theme/app_colors.dart';
import 'package:mandopy/core/utils/app_assets.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';

class PrizesView extends StatelessWidget {
  const PrizesView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: AppStrings.prizes,
          ),
          TotalRewardedPrizesContainer(
            prizeNumber: 3,
          )
        ],
      ),
    );
  }
}

class TotalRewardedPrizesContainer extends StatelessWidget {
  final int prizeNumber; // This allows passing the prize number dynamically.

  const TotalRewardedPrizesContainer({
    super.key,
    required this.prizeNumber, // Accept dynamic prize number
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
          right: 4.w,
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
                    alignment: PlaceholderAlignment.middle,
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
    );
  }
}
