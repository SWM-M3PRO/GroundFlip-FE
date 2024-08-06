import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';
import '../../../controllers/map_controller.dart';
import '../../../controllers/walking_controller.dart';
import '../../../screens/explore_mode_screen.dart';

class StepStats extends StatelessWidget {
  const StepStats({super.key});

  @override
  Widget build(BuildContext context) {
    var walkingController = Get.find<WalkingController>();
    var mapController = Get.find<MapController>();
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            NumberFormat('###,###,###')
                .format(walkingController.currentStep.value),
            style: TextStyles.fs24w900cTextPrimary,
          ),
          Text(
            ' 걸음',
            style: TextStyles.fs17w400cTextSecondary,
          ),
          Spacer(),
          Text(
            '${walkingController.getCurrentCalorie()} kcal · ${walkingController.getCurrentTravelDistance()}km',
            style: TextStyles.fs17w400cTextSecondary,
          ),
        ],
      ),
    );
  }
}

// Todo: 추후에 대시보드 등의 형식으로 변경 필요
class StepStatsBody extends StatelessWidget {
  const StepStatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(children: [
        SizedBox(
          height: 300,
        ),
        TextButton(
          onPressed: () {
            Get.find<MapController>().startExplore();
            Get.to(ExploreModeScreen());
          },
          style: TextButton.styleFrom(
            backgroundColor: AppColors.backgroundThird,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              '점령 모드',
              style: TextStyle(
                fontSize: 20,
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
