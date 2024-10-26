import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../screens/category_achievement_list_screen.dart';

class AchievementCategory extends StatelessWidget {
  final String categoryName;
  final String badgeImage;

  const AchievementCategory({
    super.key,
    required this.categoryName,
    required this.badgeImage,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        onTap: () {
          Get.to(CategoryAchievementListScreen(
            categoryName: categoryName,
            categoryImageUrl: badgeImage,
            categoryDescription:
                "앱을 켜고 아무 땅이나 방문하여 얻을 수 있는 업적입니다. 많은 땅을 방문하여 뱃지를 모아보세요.",
          ));
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
                  categoryName,
                  style: TextStyles.fs17w700cTextPrimary,
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Image.asset(
                badgeImage,
                height: 80,
              ),
              SizedBox(
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
