import 'package:flutter/material.dart';

class TodayGoalChart extends StatelessWidget {
  const TodayGoalChart({super.key});

  @override
  Widget build(BuildContext context) {
    int todayStep = 6666;

    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              height: 30,
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
            Container(
              padding: const EdgeInsets.all(10.0),
              height: 30,
              width:
                  (MediaQuery.of(context).size.width - 20) / 10000 * todayStep,
              decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(Radius.circular(8))),
            ),
          ],
        ),
        Text('목표 걸음의 ${todayStep / 10000 * 100} % 달성!'),
      ],
    );
  }
}
