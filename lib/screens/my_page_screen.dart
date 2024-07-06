import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/walking_controller.dart';
import '../widgets/my_page/step_bar_chart.dart';
import '../widgets/my_page/step_window.dart';
import '../widgets/my_page/today_goal_chart.dart';
import '../widgets/my_page/user_info.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final WalkingController walkController = Get.put(WalkingController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          UserInfo(),
          Container(
            height: 10,
          ),
          StepWindow(),
          Container(
            height: 10,
          ),
          TodayGoalChart(),
          TextButton(
            onPressed: () {
              walkController.updateCurrentStep();
            },
            child: const Text('업데이트'),
          ),
          StepBarChart(),
        ],
      ),
    );
  }
}
