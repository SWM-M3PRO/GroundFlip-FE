import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_page_controller.dart';
import '../controllers/walking_controller.dart';
import '../widgets/my_page/dash_board.dart';
import '../widgets/my_page/step_bar_chart.dart';
import '../widgets/my_page/today_goal_chart.dart';
import '../widgets/my_page/user_info.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WalkingController());
    Get.put(MyPageController());

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          UserInfo(),
          Container(
            height: 10,
          ),
          DashBoard(),
          SizedBox(
            height: 10,
          ),
          TodayGoalChart(),
          StepBarChart(),
        ],
      ),
    );
  }
}
