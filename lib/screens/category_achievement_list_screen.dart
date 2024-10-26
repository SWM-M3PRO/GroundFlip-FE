import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../widgets/achievement/achievement_grid.dart';
import '../widgets/achievement/achievement_list_element.dart';
import '../widgets/common/app_bar.dart';

class CategoryAchievementListScreen extends StatelessWidget {
  final String categoryName;
  final String categoryDescription;
  final String categoryImageUrl;

  const CategoryAchievementListScreen(
      {super.key,
      required this.categoryName,
      required this.categoryDescription,
      required this.categoryImageUrl});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: AppBarTitle(
          title: categoryName,
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
            Image.asset(
              categoryImageUrl,
              width: 150,
              height: 150,
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                children: [
                  Text(
                    categoryName,
                    style: TextStyles.fs28w700cTextPrimary,
                  ),
                  Text(
                    categoryDescription,
                    style: TextStyles.fs14w800cTextPrimary,
                  ),
                  Divider(
                    height: 10,
                  ),
                ],
              ),
            ),
            AchievementGrid(
              achievements: [
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge7.png",
                  achievementName: "10개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge8.png",
                  achievementName: "30개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge9.png",
                  achievementName: "50개의 땅 방문",
                  obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge10.png",
                  achievementName: "100개의 땅 방문",
                  // obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge11.png",
                  achievementName: "300개의 땅 방문",
                  // obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge12.png",
                  achievementName: "500개의 땅 방문",
                  // obtainedDate: DateTime.now(),
                ),
                AchievementListElement(
                  badgeUrl: "assets/images/badge/badge13.png",
                  achievementName: "1000개의 땅 방문",
                  // obtainedDate: DateTime.now(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
