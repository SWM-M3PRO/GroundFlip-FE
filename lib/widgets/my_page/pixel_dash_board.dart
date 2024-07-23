import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/my_page_controller.dart';
import '../../controllers/walking_controller.dart';
import 'pixel_dash_board_widget.dart';

class PixelDashBoard extends StatelessWidget {
  PixelDashBoard({
    super.key,
  });

  final MyPageController myPageController = Get.find<MyPageController>();
  final WalkingController walkingController = Get.find<WalkingController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PixelDashBoardWidget(
          textValue: "현재 px",
          iconImageUrl: "assets/images/current_pixel_icon.png",
          countValue: myPageController.currentPixelCount,
        ),
        SizedBox(width: 20),
        PixelDashBoardWidget(
          textValue: "누적 px",
          iconImageUrl: "assets/images/accumulate_pixel_icon.png",
          countValue: myPageController.accumulatePixelCount,
        ),
      ],
    );
  }
}
