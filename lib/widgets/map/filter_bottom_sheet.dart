import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import 'period_change_button.dart';

// ignore: must_be_immutable
class FilterBottomSheet extends StatelessWidget {
  FilterBottomSheet({
    super.key,
  });

  int selectedNumber = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "필터",
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
            SizedBox(
              height: 5,
            ),
            Align(
              alignment: Alignment.topLeft,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
                decoration: BoxDecoration(
                    color: AppColors.secondary,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                child: Text(
                  "기간 선택",
                  style: TextStyles.fs14w500cPrimary,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            PeriodChangeButton(),
            Spacer(),
          ],
        ),
      ),
    );
  }
}
