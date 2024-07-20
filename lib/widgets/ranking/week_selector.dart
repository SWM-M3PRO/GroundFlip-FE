import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/ranking_controller.dart';
import 'week_wheel_picker.dart';

class WeekSelector extends StatelessWidget {
  const WeekSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();

    return SizedBox(
      height: 44,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        child: GestureDetector(
          onTap: () {
            Get.bottomSheet(
              WeekWheelPicker(),
              backgroundColor: AppColors.backgroundSecondary,
              enterBottomSheetDuration: Duration(milliseconds: 100),
              exitBottomSheetDuration: Duration(milliseconds: 100),
            );
          },
          child: Row(
            children: [
              Obx(() {
                return Text(
                  rankingController.selectedWeekString.value,
                  style: TextStyles.title2,
                );
              }),
              SizedBox(
                width: 5,
              ),
              Image.asset(
                "assets/images/chevron_down.png",
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
