import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/achievement_controller.dart';
import '../../models/achievement/achievement_category.dart';

class AchievementCategoryElement extends StatelessWidget {
  final AchievementCategory achievementCategory;
  final AchievementController achievementController =
      Get.find<AchievementController>();

  AchievementCategoryElement({
    super.key,
    required this.achievementCategory,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {
        achievementController.moveToCategoryAchievementListScreen(
          achievementCategory.categoryId,
        );
      },
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.secondary,
              AppColors.third,
            ],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                achievementCategory.categoryName,
                style: TextStyles.fs17w700cTextPrimary,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Image(
              image: CachedNetworkImageProvider(
                achievementCategory.categoryImageUrl,
              ),
              width: 80,
              height: 80,
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
