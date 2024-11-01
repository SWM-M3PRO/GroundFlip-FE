import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/my_page_controller.dart';
import '../../screens/achievement_screen.dart';

class AchievementDashboard extends StatelessWidget {
  AchievementDashboard({super.key});

  final MyPageController myPageController = Get.find<MyPageController>();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      onTap: () {
        Get.to(AchievementScreen());
      },
      child: Ink(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Row(
                  children: [
                    Text(
                      "업적 | ",
                      style: TextStyles.fs20w700cTextPrimary,
                    ),
                    Obx(
                      () => Text(
                        myPageController.achievementCount.value.toString(),
                        style: TextStyles.fs20w700cPrimary,
                      ),
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    for (int i = 0;
                        i < myPageController.achievementElements.length;
                        i++)
                      Image(
                        image: CachedNetworkImageProvider(
                          myPageController.achievementElements[i].badgeImageUrl,
                        ),
                        width: 50,
                        height: 50,
                      ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
