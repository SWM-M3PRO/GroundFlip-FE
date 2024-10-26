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
            Text(
              '내 업적',
              style: TextStyles.fs17w600cTextPrimary,
            ),
            SizedBox(
              height: 10,
            ),
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
                ),
                SizedBox(width: 20),
                AchievementCategory(
                  categoryName: "정복자",
                  badgeImage: "assets/images/badge/badge_2.png",
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AchievementCategory(
                  categoryName: "식민지화",
                  badgeImage: "assets/images/badge/badge_3.png",
                ),
                SizedBox(width: 20),
                AchievementCategory(
                  categoryName: "특수 목표",
                  badgeImage: "assets/images/badge/badge_6.png",
                ),
              ],
            ),
            SizedBox(height: 20),
            Row(
              children: [
                AchievementCategory(
                  categoryName: "식민지화",
                  badgeImage: "assets/images/badge/badge_3.png",
                ),
                SizedBox(width: 20),
                AchievementCategory(
                  categoryName: "특수 목표",
                  badgeImage: "assets/images/badge/badge_6.png",
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
