import 'package:flutter/material.dart';

import '../widgets/ranking/week_selector.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        WeekSelector(),
      ],
    );
  }
}
