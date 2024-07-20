import 'package:flutter/material.dart';

import '../../constants/colors.dart';
import '../../models/ranking.dart';
import 'ranking_list_element.dart';

class RankingList extends StatelessWidget {
  RankingList({super.key, required this.rankings});

  final List<Ranking> rankings;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          RankingSection(
            rankings: rankings,
          ),
          SizedBox(
            height: 20,
          ),
          RankingSection(
            rankings: rankings,
          ),
        ],
      ),
    );
  }
}

class RankingSection extends StatelessWidget {
  RankingSection({
    super.key,
    required this.rankings,
  });

  final List<Ranking> rankings;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rankings.length; i++)
            RankingListElement(
              nickname: rankings[i].nickname!,
              profileImageUrl: rankings[i].profileImageUrl,
              currentPixelCount: rankings[i].currentPixelCount!,
              rank: rankings[i].rank!,
              isLast: false,
            ),
        ],
      ),
    );
  }
}
