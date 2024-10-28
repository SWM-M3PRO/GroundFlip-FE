import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../models/achievement/achievement.dart';
import '../widgets/achievement/achievement_gage.dart';
import '../widgets/achievement/reward_button.dart';

class AchievementInfoScreen extends StatelessWidget {
  final Achievement achievement;

  const AchievementInfoScreen({
    super.key,
    required this.achievement,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 100,
              ),
              Image(
                image: CachedNetworkImageProvider(
                  achievement.badgeImageUrl,
                ),
                width: 250,
                height: 250,
                color: Colors.black.withOpacity(
                  achievement.currentValue >= achievement.completionGoal
                      ? 0
                      : 0.8,
                ),
                colorBlendMode: BlendMode.darken,
              ),
              // Image.asset(
              //   achievement.badgeImageUrl,
              //   width: 250,
              //   height: 250,
              //   color: Colors.black.withOpacity(
              //     achievement.currentValue >= achievement.completionGoal
              //         ? 0
              //         : 0.8,
              //   ), // 어두운 명암을 줄 색상
              //   colorBlendMode: BlendMode.darken,
              // ),
              SizedBox(
                height: 20,
              ),
              Text(
                achievement.achievementName,
                style: TextStyles.fs28w700cTextPrimary,
              ),
              if (achievement.currentValue >= achievement.completionGoal)
                Text(
                  DateFormat('yyyy.MM.dd').format(achievement.obtainedDate!),
                  style: TextStyles.fs20w600cTextSecondary,
                ),
              AchievementGage(
                currentValue: achievement.currentValue,
                completionGoal: achievement.completionGoal,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                achievement.achievementDetail,
                style: TextStyles.fs17w700cTextPrimary,
              ),
              SizedBox(
                height: 20,
              ),
              RewardButton(
                reward: 50,
                isRewardReceived: achievement.isRewardReceived,
                isAchieved:
                    achievement.currentValue >= achievement.completionGoal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
