import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/text_styles.dart';
import '../../controllers/walking_controller.dart';

class StepStats extends StatelessWidget {
  const StepStats({super.key});

  @override
  Widget build(BuildContext context) {
    var walkController = Get.find<WalkingController>();
    return Obx(
      () => Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            walkController.getCurrentStep(),
            style: TextStyles.fs24w900cTextPrimary,
          ),
          Text(
            ' 걸음',
            style: TextStyles.fs17w400cTextSecondary,
          ),
          Spacer(),
          Text(
            '${walkController.getCurrentCalorie()} kcal · ${walkController.getCurrentTravelDistance()}km',
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
      child: SizedBox(
        width: 10,
      ),
    );
  }
}
