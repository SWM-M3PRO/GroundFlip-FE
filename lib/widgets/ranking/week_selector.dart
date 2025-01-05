import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:ground_flip/widgets/ranking/week_wheel_picker.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/ranking_controller.dart';
import '../../enums/ranking_type.dart';

class WeekSelector extends StatelessWidget {
  const WeekSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();
    return Obx(() {
      if ((!(rankingController.rankingType.value == RankingType.accumulate &&
          rankingController.getSelectedType() == 0))) {
        return GestureDetector(
          onTap: () {
            if (!(rankingController.rankingType.value ==
                    RankingType.accumulate &&
                rankingController.getSelectedType() == 0)) {
              Get.bottomSheet(
                WeekWheelPicker(),
                backgroundColor: AppColors.backgroundSecondary,
                enterBottomSheetDuration: Duration(milliseconds: 100),
                exitBottomSheetDuration: Duration(milliseconds: 100),
              );
            }
          },
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Obx(() {
                return Text(
                  rankingController.selectedWeekString.value,
                  style: TextStyles.fs17w700cTextPrimary,
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
        );
      } else {
        return Text(
          DateFormat('yyyy년 MM월 dd일').format(DateTime.now()),
          style: TextStyles.fs17w600cTextPrimary,
        );
      }
    });
  }
}
