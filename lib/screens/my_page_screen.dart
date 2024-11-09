import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_page_controller.dart';
import '../controllers/walking_controller.dart';
import '../widgets/my_page/achievement_dashboard.dart';
import '../widgets/my_page/pixel_bar_chart.dart';
import '../widgets/my_page/pixel_dash_board.dart';
import '../widgets/my_page/user_info.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(WalkingController());
    Get.put(MyPageController());

    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
      child: ListView(
        children: [
          UserInfo(),
          SizedBox(
            height: 20,
          ),
          PixelDashBoard(),
          SizedBox(
            height: 20,
          ),
          AchievementDashboard(),
          SizedBox(
            height: 20,
          ),
          PixelBarChart(),
          SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
