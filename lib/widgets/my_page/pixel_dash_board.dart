import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/map_controller.dart';
import '../../controllers/walking_controller.dart';
import 'pixel_dash_board_widget.dart';

class PixelDashBoard extends StatelessWidget {
  PixelDashBoard({
    super.key,
  });

  final MapController mapController = Get.find<MapController>();
  final WalkingController walkingController = Get.find<WalkingController>();

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        PixelDashBoardWidget(
          textValue: "현재 px",
          iconImageUrl: "assets/images/current_pixel_icon.png",
          countValue: mapController.currentPixelCount,
        ),
        SizedBox(width: 20),
        PixelDashBoardWidget(
          textValue: "누적 px",
          iconImageUrl: "assets/images/accumulate_pixel_icon.png",
          countValue: mapController.accumulatePixelCount,
        ),
      ],
    );
  }
}
