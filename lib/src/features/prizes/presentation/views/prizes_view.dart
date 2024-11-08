// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:mandopy/core/common/widgets/custom_app_bar.dart';
import 'package:mandopy/core/services/service_locator.dart';
import 'package:mandopy/core/utils/app_strings.dart';
import 'package:mandopy/core/utils/app_styles.dart';
import 'package:mandopy/src/features/prizes/cubit/points_cubit.dart';

import '../../data/reward_model.dart';
import '../components/delivered_rewards_list_view.dart';
import '../components/rewards_list_view.dart';
import '../widgets/total_rewarded_prizes_container.dart';

class PrizesView extends StatelessWidget {
  const PrizesView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Reward> rewards = [
      Reward(
        name: 'الميدالية الذهبيه',
        price: '200 دولار',
        points: '300 نقطة',
      ),
      Reward(
        name: 'الميدالية الفضية',
        price: '150 دولار',
        points: '200 نقطة',
      ),
      Reward(
        name: 'الميدالية البرونزية',
        price: '100 دولار',
        points: '100 نقطة',
      ),
    ];

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const CustomAppBar(
              title: AppStrings.prizes,
            ),
            BlocProvider(
              create: (context) => getIt<PointsCubit>()..fetchPoints(),
              child: const TotalRewardedPrizesContainer(),
            ),
            SizedBox(
              height: 5.h,
            ),
            Text(
              AppStrings.viewRewards,
              style: AppStyles.s16.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            RewardsListView(rewards: rewards),
            Text(
              AppStrings.previousRewards,
              style: AppStyles.s16.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const DeliveredRewardsListView(),
          ],
        ),
      ),
    );
  }
}
