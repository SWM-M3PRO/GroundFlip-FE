import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../models/achievement/achievements_by_category.dart';
import '../widgets/achievement/achievement_grid.dart';
import '../widgets/achievement/achievement_list_element.dart';
import '../widgets/common/app_bar.dart';

class CategoryAchievementListScreen extends StatelessWidget {
  final AchievementsByCategory achievementsByCategory;

  const CategoryAchievementListScreen({
    super.key,
    required this.achievementsByCategory,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: AppBarTitle(
          title: achievementsByCategory.categoryName,
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
            Image(
              image: CachedNetworkImageProvider(
                achievementsByCategory.categoryImageUrl,
              ),
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
                    achievementsByCategory.categoryName,
                    style: TextStyles.fs28w700cTextPrimary,
                  ),
                  Text(
                    achievementsByCategory.categoryDescription,
                    style: TextStyles.fs14w800cTextPrimary,
                  ),
                  Divider(
                    height: 10,
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            AchievementGrid(
              achievements: [
                for (int i = 0;
                    i < achievementsByCategory.achievements.length;
                    i++)
                  AchievementListElement(
                    achievementId:
                        achievementsByCategory.achievements[i].achievementId,
                    badgeUrl:
                        achievementsByCategory.achievements[i].badgeImageUrl,
                    achievementName:
                        achievementsByCategory.achievements[i].achievementName,
                    obtainedDate:
                        achievementsByCategory.achievements[i].obtainedDate,
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
