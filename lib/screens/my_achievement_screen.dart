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
                    achievementId: achievements[i].achievementId,
                    badgeUrl: achievements[i].badgeImageUrl,
                    achievementName: achievements[i].achievementName,
                    obtainedDate: achievements[i].obtainedDate,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
