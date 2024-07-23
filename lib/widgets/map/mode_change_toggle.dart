import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/map_controller.dart';

class ModeChangeToggle extends StatelessWidget {
  ModeChangeToggle({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    return Obx(() {
      return AnimatedToggleSwitch<int>.size(
        current: mapController.getSelectedType(),
        style: ToggleStyle(
          // backgroundColor: AppColors.backgroundSecondary,
          backgroundColor: Color(0xF21D1D1D),
          indicatorColor: AppColors.buttonColor,
          borderColor: Colors.transparent,
          borderRadius: BorderRadius.circular(24.0),
          indicatorBorderRadius: BorderRadius.circular(24.0),
        ),
        values: const [0, 1, 2],
        iconOpacity: 1.0,
        selectedIconScale: 1.0,
        indicatorSize: Size.fromWidth(90),
        height: 40,
        iconAnimationType: AnimationType.onHover,
        styleAnimationType: AnimationType.onHover,
        spacing: 2.0,
        // customSeparatorBuilder: (context, local, global) {
        //   final opacity =
        //       ((global.position - local.position).abs() - 0.5).clamp(0.0, 1.0);
        //   return VerticalDivider(
        //     indent: 10.0,
        //     endIndent: 10.0,
        //     color: Colors.white38.withOpacity(opacity),
        //   );
        // },
        customIconBuilder: (context, local, global) {
          final text = const ['개인 기록', '개인전', '그룹전'][local.index];
          return Center(
            child: Text(
              text,
              style: TextStyle(
                color: Color.lerp(
                  Colors.white,
                  Colors.black,
                  local.animationValue,
                ),
                fontSize: 14,
                fontWeight: FontWeight.w700,
              ),
            ),
          );
        },
        borderWidth: 0.0,
        onChanged: (i) => mapController.changePixelMode(i),
      );
    });
  }
}
