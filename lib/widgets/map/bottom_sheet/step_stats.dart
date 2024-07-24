import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/text_styles.dart';
import '../../../controllers/walking_controller.dart';

class StepStats extends StatelessWidget {
  const StepStats({super.key});

  @override
  Widget build(BuildContext context) {
    var walkingController = Get.find<WalkingController>();
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
      child: SizedBox(
        width: 10,
      ),
    );
  }
}
