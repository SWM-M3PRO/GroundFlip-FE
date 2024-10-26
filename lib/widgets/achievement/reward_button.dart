import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class RewardButton extends StatelessWidget {
  final bool isRewardReceived;
  final int reward;
  final bool isAchieved;

  const RewardButton({
    super.key,
    required this.reward,
    required this.isRewardReceived,
    required this.isAchieved,
  });

  @override
  Widget build(BuildContext context) {
    if (isRewardReceived) {
      return Container();
    } else {
      if (isAchieved) {
        return InkWell(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          onTap: () {
            // 보상 받는 로직
          },
          child: Ink(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 15),
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: BorderRadius.all(Radius.circular(16)),
            ),
            child: Text(
              '${reward.toString()}P 보상받기',
              style: TextStyles.fs17w700cPrimary,
            ),
          ),
        );
      } else {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10),
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Text(
            '${reward.toString()}P',
            style: TextStyles.fs17w700cPrimary,
          ),
        );
      }
    }
  }
}
