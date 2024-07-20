import 'package:flutter/material.dart';

import '../widgets/ranking/my_ranking_info.dart';
import '../widgets/ranking/ranking_list.dart';
import '../widgets/ranking/week_selector.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
      child: Column(
        children: [
          WeekSelector(),
          MyRankingInfo(),
          SizedBox(
            height: 20,
          ),
          RankingList(),
        ],
      ),
    );
  }
}
