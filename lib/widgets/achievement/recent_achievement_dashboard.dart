import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../screens/my_achievement_screen.dart';
import 'achievement_list_element.dart';

class RecentAchievementDashboard extends StatelessWidget {
  const RecentAchievementDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Get.to(MyAchievementScreen());
      },
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_1.png",
                  achievementName: "10개의 땅 방문",
                  obtainedDate: DateTime.now(),
                  isClickable: false,
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_3.png",
                  achievementName: "50개의 땅 점령",
                  obtainedDate: DateTime.now(),
                  isClickable: false,
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_4.png",
                  achievementName: "경기도 정복",
                  obtainedDate: DateTime.now(),
                  isClickable: false,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
