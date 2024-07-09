import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';
import '../../controllers/walking_controller.dart';
import 'dash_board_widget.dart';

class DashBoard extends StatelessWidget {
  DashBoard({
    super.key,
  });

  final MyPageController myPageController = Get.find<MyPageController>();
  final WalkingController walkingController = Get.find<WalkingController>();

  @override
  Widget build(BuildContext context) {
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
            DashBoardWidget(
                textValue: "현재 픽셀수",
                iconImageUrl: "currentTile.png",
                countValue: myPageController.getCurrentUserPixel().obs,),
            DashBoardWidget(
                textValue: "누적 픽셀수",
                iconImageUrl: "allTile.png",
                countValue: myPageController.getAccumulateUserPixel().obs,),
            DashBoardWidget(
                textValue: "걸음수",
                iconImageUrl: "stepIcon.png",
                countValue: walkingController.currentStep,
            ),
          ],
        ),
      ],
    );
  }
}
