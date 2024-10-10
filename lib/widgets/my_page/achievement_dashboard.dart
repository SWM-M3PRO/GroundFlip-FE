import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class AchievementDashboard extends StatelessWidget {
  const AchievementDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print('123');
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "업적",
                  style: TextStyles.fs17w600cTextPrimary,
                ),
                SizedBox(
                  width: 10,
                ),
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColors.textPrimary,
                  size: 15,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  "assets/images/badge/badge_1.png",
                  width: 100,
                ),
                Image.asset(
                  "assets/images/badge/badge_5.png",
                  width: 100,
                ),
                Image.asset(
                  "assets/images/badge/badge_3.png",
                  width: 100,
                ),
                // Image.asset(
                //   "assets/images/badge/badge_1.png",
                //   width: 100,
                // ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
