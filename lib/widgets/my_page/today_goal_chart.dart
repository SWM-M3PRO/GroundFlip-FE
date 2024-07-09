import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/walking_controller.dart';

class TodayGoalChart extends StatelessWidget {
  const TodayGoalChart({super.key});

  @override
  Widget build(BuildContext context) {
    WalkingController walkingController = Get.put(WalkingController());
    return Column(
      children: [
        Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(10.0),
              height: 30,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
              ),
            ),
            Obx(
              () => Container(
                padding: const EdgeInsets.all(10.0),
                height: 30,
                width: walkingController.currentStep.value <= 10000
                    ? (MediaQuery.of(context).size.width - 20) /
                        10000 *
                        walkingController.currentStep.value
                    : 10000,
                decoration: BoxDecoration(
                  color: Colors.greenAccent,
                  borderRadius: BorderRadius.all(
                    Radius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
        Obx(
          () => Text(
            '목표 걸음의 ${(walkingController.currentStep.value / 10000 * 100).toStringAsFixed(2)} % 달성!!',
          ),
        ),
      ],
    );
  }
}
