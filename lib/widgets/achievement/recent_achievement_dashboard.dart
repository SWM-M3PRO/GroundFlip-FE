import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/achievement_controller.dart';
import 'achievement_list_element.dart';

class RecentAchievementDashboard extends StatelessWidget {
  RecentAchievementDashboard({super.key});

  final AchievementController controller = Get.find<AchievementController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () async {
        await controller.moveToMyAchievementScreen();
      },
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            SizedBox(
              height: 10,
            ),
            Obx(
              () => Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  for (int i = 0;
                      i < controller.achievementElements.length;
                      i++)
                    AchievementListElement(
                      achievementId:
                          controller.achievementElements[i].achievementId,
                      badgeUrl: controller.achievementElements[i].badgeImageUrl,
                      achievementName:
                          controller.achievementElements[i].achievementName,
                      obtainedDate:
                          controller.achievementElements[i].obtainedDate,
                      isClickable: false,
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
