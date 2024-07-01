import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_page_controller.dart';
import '../widgets/map/step_stats.dart';
import '../widgets/my_page/step_bar_chart.dart';

class MyPageScreen extends StatelessWidget {
  const MyPageScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPageController walkController = Get.put(MyPageController());

    return Column(
      children: [
        const Text('마이페이지'),
        Obx(() => Text(walkController.getCurrentStep())),
        TextButton(
          onPressed: () {
            walkController.updateCurrentStep();
          },
          child: const Text('업데이트'),
        ),
        StepBarChart(),
        StepStats()
      ],
    );
  }
}
