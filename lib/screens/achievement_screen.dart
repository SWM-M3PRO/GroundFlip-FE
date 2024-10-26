import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../widgets/achievement/achievement_category.dart';
import '../widgets/achievement/recent_achievement_dashboard.dart';
import '../widgets/common/app_bar.dart';

class AchievementScreen extends StatelessWidget {
  const AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: AppBarTitle(
          title: '업적',
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
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            RecentAchievementDashboard(),
            SizedBox(
              height: 20,
            ),
            Text(
              '카테고리',
              style: TextStyles.fs17w600cTextPrimary,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                AchievementCategory(
                  categoryName: "탐험왕",
                  badgeImage: "assets/images/badge/badge_5.png",
                  badgeName: "새로운 땅 1000개 방문",
                ),
                SizedBox(width: 20),
                AchievementCategory(
                  categoryName: "정복자",
                  badgeImage: "assets/images/badge/badge_2.png",
                  badgeName: "50개 약탈자",
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AchievementCategory(
                  categoryName: "식민지화",
                  badgeImage: "assets/images/badge/badge_3.png",
                  badgeName: "경기도",
                ),
                SizedBox(width: 20),
                AchievementCategory(
                  categoryName: "특수 목표",
                  badgeImage: "assets/images/badge/badge_6.png",
                  badgeName: "독도 지킴이",
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AchievementCategory(
                  categoryName: "식민지화",
                  badgeImage: "assets/images/badge/badge_3.png",
                  badgeName: "경기도",
                ),
                SizedBox(width: 20),
                AchievementCategory(
                  categoryName: "특수 목표",
                  badgeImage: "assets/images/badge/badge_6.png",
                  badgeName: "독도 지킴이",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
