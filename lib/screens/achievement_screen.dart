import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/achievement_controller.dart';
import '../widgets/achievement/achievement_category_element.dart';
import '../widgets/achievement/recent_achievement_dashboard.dart';
import '../widgets/common/app_bar.dart';

class AchievementScreen extends StatelessWidget {
  AchievementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    AchievementController achievementController =
        Get.put(AchievementController());

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
      body: Stack(
        children: [
          Padding(
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
                Obx(
                  () => GridView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 20,
                      childAspectRatio: 1,
                    ),
                    itemCount:
                        achievementController.achievementCategories.length,
                    itemBuilder: (context, index) {
                      return AchievementCategoryElement(
                        achievementCategory:
                            achievementController.achievementCategories[index],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
          Obx(() {
            if (achievementController.isLoading.value) {
              return Center(
                child: CircularProgressIndicator(
                  color: AppColors.primary,
                ),
              );
            } else {
              return SizedBox();
            }
          }),
        ],
      ),
    );
  }
}
