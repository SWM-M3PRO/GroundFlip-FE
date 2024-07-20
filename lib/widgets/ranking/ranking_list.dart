import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import 'ranking_list_element.dart';

class RankingList extends StatelessWidget {
  const RankingList({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          child: Column(
            children: [
              RankingListElement(
                nickname: "구미니",
                profileImageUrl: null,
                currentPixelCount: 3708,
                rank: 1,
                isLast: false,
              ),
              RankingListElement(
                nickname: "상미니",
                profileImageUrl: null,
                currentPixelCount: 3483,
                rank: 2,
                isLast: false,
              ),
              RankingListElement(
                nickname: "민우기",
                profileImageUrl: null,
                currentPixelCount: 3115,
                rank: 3,
                isLast: true,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
