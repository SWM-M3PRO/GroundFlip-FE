import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/walking_controller.dart';

class TodayStepChart extends StatelessWidget {
  const TodayStepChart({super.key});

  @override
  Widget build(BuildContext context) {
    WalkingController walkingController = Get.put(WalkingController());
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '걸음수',
                  style: TextStyles.fs17w400cTextSecondary,
                ),
                Spacer(),
                Obx(
                  () => Text(
                    NumberFormat('###,###,###')
                        .format(walkingController.currentStep.value),
                    style: TextStyles.fs17w700cPrimary,
                  ),
                ),
                Text(
                  ' / 10,000 걸음',
                  style: TextStyles.fs17w400cTextSecondary,
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Stack(
              children: [
                Container(
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.backgroundThird,
                    borderRadius: BorderRadius.all(
                      Radius.circular(8),
                    ),
                  ),
                ),
                Obx(
                  () => Container(
                    height: 16,
                    width: walkingController.currentStep.value <= 10000
                        ? (MediaQuery.of(context).size.width - 80) /
                            10000 *
                            walkingController.currentStep.value
                        : 10000,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [AppColors.primaryGradient, AppColors.primary],
                        begin: Alignment.centerLeft,
                        end: Alignment.centerRight,
                      ),
                      borderRadius: BorderRadius.all(
                        Radius.circular(8),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
