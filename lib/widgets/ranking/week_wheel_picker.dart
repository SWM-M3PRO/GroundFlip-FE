import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/ranking_controller.dart';
import '../../utils/date_handler.dart';

// ignore: must_be_immutable
class WeekWheelPicker extends StatelessWidget {
  WeekWheelPicker({
    super.key,
  });

  int selectedNumber = 0;

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();
    final FixedExtentScrollController controller = FixedExtentScrollController(
      initialItem: rankingController.selectedWeekNumber,
    );
    selectedNumber = rankingController.selectedWeekNumber;
    final List<DateTime> weekOptions =
        DateHandler.getDatesFromStartToThisWeek();

    return SizedBox(
      width: 600,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "랭킹 주차 선택",
                    style: TextStyles.fs20w700cTextPrimary,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundThird,
                    shape: CircleBorder(),
                    minimumSize: Size(36, 36),
                    padding: EdgeInsets.all(0),
                    iconColor: AppColors.textPrimary,
                  ),
                  child: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Get.back();
                  rankingController.selectWeek(
                    selectedNumber,
                    weekOptions[selectedNumber],
                  );
                },
                child: CupertinoPicker(
                  itemExtent: 60,
                  magnification: 1.22,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: AppColors.secondary,
                  ),
                  onSelectedItemChanged: (selectedWeekNumber) {
                    selectedNumber = selectedWeekNumber;
                  },
                  scrollController: controller,
                  children: [
                    for (int i = 0; i < weekOptions.length; i++)
                      Center(
                        child: Text(
                          DateHandler.convertDateToWeekFormat(weekOptions[i]),
                          style: TextStyles.fs20w700cPrimary,
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
