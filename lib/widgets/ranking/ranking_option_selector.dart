import 'package:flutter/material.dart';

import 'ranking_type_toggle_button.dart';
import 'week_selector.dart';

class RankingOptionSelector extends StatelessWidget {
  static String rankingGuideUrl =
      'https://autumn-blouse-355.notion.site/b90c1f81e247499ab244137634b066bc?pvs=4';

  const RankingOptionSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          WeekSelector(),
          Spacer(),
          RankingTypeToggleButton(),
        ],
      ),
    );
  }
}
