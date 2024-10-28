import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../screens/achievement_screen.dart';

class AchievementDashboard extends StatelessWidget {
  const AchievementDashboard({super.key});

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
                    Text(
                      "3",
                      style: TextStyles.fs20w700cPrimary,
                    ),
                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/badge/badge_1.png",
                      width: 50,
                      height: 50,
                    ),
                    Image.asset(
                      "assets/images/badge/badge_2.png",
                      width: 50,
                      height: 50,
                    ),
                    Image.asset(
                      "assets/images/badge/badge_3.png",
                      width: 50,
                      height: 50,
                    ),
                    Image.asset(
                      "assets/images/badge/badge_4.png",
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
