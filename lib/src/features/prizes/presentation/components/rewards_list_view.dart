import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../data/reward_model.dart';
import '../widgets/reward_card.dart';

class RewardsListView extends StatelessWidget {
  const RewardsListView({
    super.key,
    required this.rewards,
  });

  final List<Reward> rewards;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 335.h,
      child: ListView.separated(
        itemCount: rewards.length,
        itemBuilder: (context, index) {
          final reward = rewards[index];
          return RewardCard(
            rewardName: reward.name,
            rewardPrice: reward.price,
            rewardPoints: reward.points,
            onButtonPressed: () {},
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 10.h,
          );
        },
      ),
    );
  }
}
