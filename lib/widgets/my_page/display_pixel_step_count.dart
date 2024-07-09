import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';
import '../../controllers/walking_controller.dart';

class DisplayPixelStepCount extends StatelessWidget {
  final String check;

  DisplayPixelStepCount({
    super.key,
    required this.check,
  });
  MyPageController myPageController = Get.find<MyPageController>();
  WalkingController walkingController = Get.find<WalkingController>();

  RxString textValue = '-'.obs;
  RxInt countValue = 0.obs;
  RxString iconImageUrl = '-'.obs;

  checkValue(check){
    switch(check){
      case '현재':
        textValue.value = '현재 픽셀수';
        countValue.value = myPageController.getCurrentUserPixel();
        iconImageUrl.value = 'currentTile.png';
        break;
      case '누적':
        textValue.value = '누적 픽셀수';
        countValue.value = myPageController.getAccumulateUserPixel();
        iconImageUrl.value = 'allTile.png';
        break;
      case '걸음수':
        textValue.value = '걸음수';
        countValue = walkingController.currentStep;
        iconImageUrl.value = 'stepIcon.png';
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    checkValue(check);
    return Container(
      width: 100,
      height: 140,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$textValue'),
          Image.asset(
            'assets/${iconImageUrl}',
            width: 40,
            height: 40,
          ), // () => Text('$countValue'),
          Obx(() =>Text('${countValue.value}')),
        ],
      ),
    );
  }
}
