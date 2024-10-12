import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class AchievementCategory extends StatelessWidget {
  final String categoryName;
  final String badgeImage;
  final String badgeName;

  const AchievementCategory(
      {super.key,
      required this.categoryName,
      required this.badgeImage,
      required this.badgeName});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
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
            Text(
              badgeName,
              style: TextStyles.fs14w500cTextSecondary,
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  '모두 보기',
                  style: TextStyles.fs17w500cPrimary,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
