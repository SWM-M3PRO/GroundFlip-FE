import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

class MyRankingInfo extends StatelessWidget {
  const MyRankingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              children: [
                ClipOval(
                  child: Image.asset(
                    "assets/images/default_profile_image.png",
                    width: 44,
                    height: 44,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('김치치즈스마일', style: TextStyles.title1),
                      Text('256px', style: TextStyles.body1),
                    ],
                  ),
                ),
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundThird,
                    borderRadius: BorderRadius.all(Radius.circular(22)),
                  ),
                  child: Center(
                    child: Text('10', style: TextStyles.rank),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Container(
              padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              height: 40,
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('3px 더 먹으면 순위 상승!', style: TextStyles.body1),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
