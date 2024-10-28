import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../widgets/achievement/achievement_gage.dart';
import '../widgets/achievement/reward_button.dart';

class AchievementInfoScreen extends StatelessWidget {
  final String badgeUrl;
  final String achievementName;
  final DateTime obtainedDate;
  final String achievementDetail;
  final int currentValue;
  final int completionGoal;
  final bool isRewardReceived;

  const AchievementInfoScreen({
    super.key,
    required this.badgeUrl,
    required this.achievementName,
    required this.obtainedDate,
    required this.achievementDetail,
    required this.currentValue,
    required this.completionGoal,
    required this.isRewardReceived,
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
              Image.asset(
                badgeUrl,
                width: 250,
                height: 250,
                color: Colors.black.withOpacity(
                  currentValue >= completionGoal ? 0 : 0.8,
                ), // 어두운 명암을 줄 색상
                colorBlendMode: BlendMode.darken,
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                achievementName,
                style: TextStyles.fs28w700cTextPrimary,
              ),
              if (currentValue >= completionGoal)
                Text(
                  DateFormat('yyyy.MM.dd').format(obtainedDate),
                  style: TextStyles.fs20w600cTextSecondary,
                ),
              AchievementGage(
                currentValue: currentValue,
                completionGoal: completionGoal,
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                achievementDetail,
                style: TextStyles.fs17w700cTextPrimary,
              ),
              SizedBox(
                height: 20,
              ),
              RewardButton(
                reward: 50,
                isRewardReceived: isRewardReceived,
                isAchieved: currentValue >= completionGoal,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
