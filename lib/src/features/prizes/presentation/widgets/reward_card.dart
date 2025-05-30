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
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0.w, vertical: 8.h),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16.r),
        child: InkWell(
          borderRadius: BorderRadius.circular(16.r),
          onTap: () {}, // يمكن ربطها لاحقاً
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.only(
                top: 16.h, left: 16.w, right: 16.w, bottom: 12.h),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Reward Info (Name and Price)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rewardName,
                            style: AppStyles.s16.copyWith(
                              color: AppColors.primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            'قدرها $rewardPrice',
                            style: AppStyles.s14.copyWith(
                              color: AppColors.greyForText,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 16.w),
                    // Points Display
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10.w, vertical: 6.h),
                      decoration: BoxDecoration(
                          color: AppColors.accentColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(
                              color: AppColors.accentColor.withOpacity(0.2))),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(Icons.star_border_outlined,
                              color: AppColors.accentColor, size: 18.w),
                          SizedBox(width: 4.w),
                          Text(
                            rewardPoints,
                            style: AppStyles.s14.copyWith(
                              color: AppColors.accentColor,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Divider(
                    height: 24.h,
                    thickness: 1,
                    color: Colors.grey[200]), // Styled Divider
                // Requirement Text
                Text(
                  'للحصول علي $rewardName يجب ان تمتلك بحد ادني $rewardPoints مكتسبة',
                  style: AppStyles.s12.copyWith(
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                // يمكن إضافة زر الاسترداد هنا عند تفعيله
                // SizedBox(height: 12.h),
                // Align(
                //   alignment: Alignment.centerRight,
                //   child: CustomButton(
                //     textStyle: AppStyles.s12.copyWith(
                //       color: Colors.white,
                //       fontWeight: FontWeight.w600,
                //     ),
                //     text: 'استرداد المكافأة',
                //     backgroundColor: AppColors.accentColor,
                //     onPressed: onButtonPressed,
                //     borderRadius: BorderRadius.circular(8.r),
                //     width: 100.w,
                //     height: 35.h,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
