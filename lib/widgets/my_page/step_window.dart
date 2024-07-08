import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';
import '../../controllers/walking_controller.dart';

class StepWindow extends StatelessWidget {
  const StepWindow({super.key});

  @override
  Widget build(BuildContext context) {
    final WalkingController walkController = Get.put(WalkingController());
    final MyPageController myPageController = Get.put(MyPageController());

    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          padding: const EdgeInsets.all(10.0),
          height: 150,
          decoration: BoxDecoration(
            color: Color(0xFFD9D9D9),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width: 120,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('현재 픽셀수'),
                  Image.asset(
                    'assets/currentTile.png',
                    width: 80,
                    height: 80,
                  ),
                  Obx(
                    () => Text(
                      myPageController.getCurrentUserPixel().toString(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('누적 픽셀수'),
                  Image.asset(
                    'assets/allTile.png',
                    width: 80,
                    height: 80,
                  ),
                  Obx(
                    () => Text(
                      myPageController.getAccumulateUserPixel().toString(),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: 120,
              height: 130,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('걸음 수'),
                  Image.asset(
                    'assets/stepIcon.png',
                    width: 80,
                    height: 80,
                  ),
                  Obx(() => Text('${walkController.currentStep.value}'))
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
