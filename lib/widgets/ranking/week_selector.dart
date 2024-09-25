import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/ranking_controller.dart';
import 'week_wheel_picker.dart';

class WeekSelector extends StatelessWidget {
  static String rankingGuideUrl =
      'https://autumn-blouse-355.notion.site/b90c1f81e247499ab244137634b066bc?pvs=4';

  const WeekSelector({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Get.bottomSheet(
                WeekWheelPicker(),
                backgroundColor: AppColors.backgroundSecondary,
                enterBottomSheetDuration: Duration(milliseconds: 100),
                exitBottomSheetDuration: Duration(milliseconds: 100),
              );
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
          ),
          Spacer(),
          IconButton(
            icon: Icon(Icons.info_outline),
            color: AppColors.buttonColor,
            onPressed: () {
              launchUrl(Uri.parse(rankingGuideUrl));
            },
          ),
        ],
      ),
    );
  }
}
