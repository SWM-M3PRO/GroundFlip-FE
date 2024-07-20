import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import 'ranking_info.dart';

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
            RankingInfo(
              nickname: "김치치즈스마일",
              profileImageUrl: null,
              currentPixelCount: 2560,
              rank: 10,
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
