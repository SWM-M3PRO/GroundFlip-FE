import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../widgets/achievement/achievement_grid.dart';
import '../widgets/achievement/achievement_list_element.dart';
import '../widgets/common/app_bar.dart';

class MyAchievementScreen extends StatelessWidget {
  const MyAchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String selectedSortOption = '최신순';
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
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: DropdownButton<String>(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              value: selectedSortOption,
              dropdownColor: AppColors.backgroundThird,
              icon: Icon(Icons.arrow_drop_down, color: Colors.white),
              style: TextStyles.fs17w600cTextPrimary,
              underline: SizedBox(),
              borderRadius: BorderRadius.all(Radius.circular(10)),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  selectedSortOption = newValue;
                  // 정렬에 따른 로직 추가
                }
              },
              items: <String>['최신순', '종류순']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ],
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
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_1.png",
                  achievementName: "10개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_3.png",
                  achievementName: "50개의 땅 점령",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_4.png",
                  achievementName: "경기도 정복",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_2.png",
                  achievementName: "10개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_6.png",
                  achievementName: "50개의 땅 점령",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_1.png",
                  achievementName: "경기도 정복",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_1.png",
                  achievementName: "10개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_3.png",
                  achievementName: "50개의 땅 점령",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_1.png",
                  achievementName: "10개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_3.png",
                  achievementName: "50개의 땅 점령",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_4.png",
                  achievementName: "경기도 정복",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_2.png",
                  achievementName: "10개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_6.png",
                  achievementName: "50개의 땅 점령",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_1.png",
                  achievementName: "경기도 정복",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_1.png",
                  achievementName: "10개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge_3.png",
                  achievementName: "50개의 땅 점령",
                  obtainedDate: DateTime.now(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
