import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../cubit/points_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

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
    return BlocBuilder<PointsCubit, PointsState>(
      builder: (context, state) {
        if (state is PointsLoading) {
          return Skeletonizer(
            child: Container(
              width: double.infinity,
              height: 200.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(16.r),
              ),
            ),
          );
        } else if (state is PointsLoaded) {
          final int progressPercentage = (state.progress * 100).toInt();
          return Container(
            width: double.infinity,
            height: 205.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              gradient: LinearGradient(
                colors: [
                  AppColors.primaryColor.withOpacity(0.9),
                  AppColors.accentColor.withOpacity(0.8),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primaryColor.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.all(20.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        AppStrings.rewardedPrizes,
                        style: AppStyles.s16.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Icon(
                        Icons.emoji_events_outlined,
                        color: Colors.white,
                        size: 30.w,
                      ),
                    ],
                  ),
                  SizedBox(height: 8.h),
                  Text(
                    "${state.points.totalPoints} نقاط",
                    style: AppStyles.s24.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      SvgPicture.asset(
                        AppAssets.medalIcon,
                        width: 18.w,
                        height: 18.h,
                      ),
                      SizedBox(width: 8.w),
                      Expanded(
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: state.medal,
                                style: AppStyles.s14.copyWith(
                                  color: Colors.white70,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              // TextSpan(
                              //   text: " عند حصولك علي 80 نقطه اضافية.",
                              //   style: AppStyles.s10.copyWith(
                              //     fontWeight: FontWeight.w500,
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const Expanded(child: SizedBox()), // Spacer
                  SizedBox(
                    height: 10.h,
                    child: LinearProgressIndicator(
                      borderRadius: BorderRadius.circular(
                        4,
                      ),
                      value: state.progress,
                      backgroundColor: Colors.white54,
                      valueColor:
                          const AlwaysStoppedAnimation<Color>(Colors.white),
                      minHeight: 10.h,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'لقد حققت $progressPercentage% من الهدف',
                      style: AppStyles.s12.copyWith(
                        color: Colors.white70,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
