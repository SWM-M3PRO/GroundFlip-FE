import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/map_controller.dart';

class PlaceChangeButton extends StatelessWidget {
  PlaceChangeButton({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    return Obx(() {
      return Center(
        child: AnimatedToggleSwitch<int>.size(
          current: mapController.getSelectedPlace(),
          style: ToggleStyle(
            backgroundColor: AppColors.backgroundThird,
            indicatorColor: AppColors.buttonColor,
            borderColor: Colors.transparent,
            borderRadius: BorderRadius.circular(16.0),
            indicatorBorderRadius: BorderRadius.circular(16.0),
          ),
          values: const [0, 1, 2],
          iconOpacity: 1.0,
          selectedIconScale: 1.0,
          indicatorSize: Size.fromWidth(200),
          height: 50,
          iconAnimationType: AnimationType.onHover,
          styleAnimationType: AnimationType.onHover,
          spacing: 2.0,
          customIconBuilder: (context, local, global) {
            final text = const ['집', '학교/직장', '기타'][local.index];
            return Center(
              child: Text(
                text,
                style: TextStyle(
                  color: Color.lerp(
                    Colors.white,
                    Colors.black,
                    local.animationValue,
                  ),
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                ),
              ),
            );
          },
          borderWidth: 0.0,
          onChanged: (i) => mapController.changePlace(i),
        ),
      );
    });
  }
}
