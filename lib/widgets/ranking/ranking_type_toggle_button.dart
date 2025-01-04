import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/ranking_controller.dart';
import '../../enums/ranking_type.dart';

class RankingTypeToggleButton extends StatelessWidget {
  const RankingTypeToggleButton({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();
    return Obx(() {
      if (rankingController.getSelectedType() == 0) {
        return Center(
          child: AnimatedToggleSwitch<int>.size(
            current: rankingController.getRankingType() == RankingType.current
                ? 0
                : 1,
            style: ToggleStyle(
              backgroundColor: AppColors.backgroundSecondary,
              indicatorColor: AppColors.buttonColor,
              borderColor: Colors.transparent,
              borderRadius: BorderRadius.circular(24.0),
              indicatorBorderRadius: BorderRadius.circular(24.0),
            ),
            values: const [0, 1],
            iconOpacity: 1.0,
            selectedIconScale: 1.0,
            indicatorSize: Size.fromWidth(50),
            height: 28,
            iconAnimationType: AnimationType.onHover,
            styleAnimationType: AnimationType.onHover,
            spacing: 2.0,
            customSeparatorBuilder: (context, local, global) {
              final opacity = ((global.position - local.position).abs() - 0.5)
                  .clamp(0.0, 1.0);
              return VerticalDivider(
                indent: 10.0,
                endIndent: 10.0,
                color: Colors.white38.withOpacity(opacity),
              );
            },
            customIconBuilder: (context, local, global) {
              final text = const ['현재', '누적'][local.index];
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
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
            borderWidth: 0.0,
            onChanged: (i) => rankingController.updateRakingType(i),
          ),
        );
      } else {
        return SizedBox();
      }
    });
  }
}
