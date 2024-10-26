import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/text_styles.dart';
import '../../screens/achievement_info_screen.dart';

class AchievementListElement extends StatelessWidget {
  final String badgeUrl;
  final String achievementName;
  final DateTime obtainedDate;

  const AchievementListElement({
    super.key,
    required this.badgeUrl,
    required this.achievementName,
    required this.obtainedDate,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(
          AchievementInfoScreen(
            badgeUrl: "assets/images/badge/badge_4.png",
            achievementName: "경기도 정복왕",
            obtainedDate: DateTime.now(),
            achievementDetail: '경기도 땅의 10%를 방문하여 획득하세요.',
            currentValue: 50,
            completionGoal: 50,
            isRewardReceived: false,
          ),
        );
      },
      child: Column(
        children: [
          Image.asset(
            badgeUrl,
            width: 80,
            height: 80,
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            achievementName,
            style: TextStyles.fs16w700cTextPrimary,
          ),
          Text(
            DateFormat('yyyy.MM.dd').format(obtainedDate),
            style: TextStyles.fs14w500cTextSecondary,
          ),
        ],
      ),
    );
  }
}
