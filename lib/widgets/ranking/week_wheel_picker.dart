import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/ranking_controller.dart';
import '../../utils/date_handler.dart';

class WeekWheelPicker extends StatelessWidget {
  WeekWheelPicker({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();
    final FixedExtentScrollController controller = FixedExtentScrollController(
      initialItem: rankingController.selectedWeekNumber,
    );
    final List<DateTime> weekOptions =
        DateHandler.getDatesFromStartToThisWeek();

    return SizedBox(
      width: 600,
      height: 1200,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "랭킹 주차 선택",
                    style: TextStyles.title3,
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
            SizedBox(
              height: 400,
              child: GestureDetector(
                onTap: () => Get.back(),
                child: CupertinoPicker(
                  itemExtent: 60,
                  magnification: 1.22,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: AppColors.secondary,
                  ),
                  onSelectedItemChanged: (selectedWeekNumber) {
                    rankingController.selectWeek(
                      selectedWeekNumber,
                      weekOptions[selectedWeekNumber],
                    );
                  },
                  scrollController: controller,
                  children: [
                    for (int i = 0; i < weekOptions.length; i++)
                      Center(
                        child: Text(
                          DateHandler.convertDateToWeekFormat(weekOptions[i]),
                          style: TextStyles.title3,
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
