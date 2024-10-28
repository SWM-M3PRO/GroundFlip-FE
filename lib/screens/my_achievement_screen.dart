import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../models/achievement/achievement_element.dart';
import '../widgets/achievement/achievement_grid.dart';
import '../widgets/achievement/achievement_list_element.dart';
import '../widgets/common/app_bar.dart';

class MyAchievementScreen extends StatelessWidget {
  final List<AchievementElement> achievements;

  MyAchievementScreen({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: AppBarTitle(
          title: '내 업적',
        ),
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
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
        child: ListView(
          children: [
            SizedBox(
              height: 10,
            ),
            AchievementGrid(
              achievements: [
                for (int i = 0; i < achievements.length; i++)
                  AchievementListElement(
                    badgeUrl: achievements[i].badgeImageUrl,
                    achievementName: achievements[i].achievementName,
                    obtainedDate: achievements[i].obtainedDate,
                  ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_3.png",
                //   achievementName: "50개의 땅 점령",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_4.png",
                //   achievementName: "경기도 정복",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_2.png",
                //   achievementName: "10개의 땅 방문",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_6.png",
                //   achievementName: "50개의 땅 점령",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_1.png",
                //   achievementName: "경기도 정복",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_1.png",
                //   achievementName: "10개의 땅 방문",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_3.png",
                //   achievementName: "50개의 땅 점령",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_1.png",
                //   achievementName: "10개의 땅 방문",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_3.png",
                //   achievementName: "50개의 땅 점령",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_4.png",
                //   achievementName: "경기도 정복",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_2.png",
                //   achievementName: "10개의 땅 방문",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_6.png",
                //   achievementName: "50개의 땅 점령",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_1.png",
                //   achievementName: "경기도 정복",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_1.png",
                //   achievementName: "10개의 땅 방문",
                //   obtainedDate: DateTime.now(),
                // ),
                // AchievementListElement(
                //   badgeUrl: "assets/images/badge/badge_3.png",
                //   achievementName: "50개의 땅 점령",
                //   obtainedDate: DateTime.now(),
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
