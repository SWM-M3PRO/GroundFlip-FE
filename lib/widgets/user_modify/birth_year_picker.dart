import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/sign_up_controller.dart';
import '../../controllers/user_info_controller.dart';

class BirthYearPicker extends StatelessWidget {
  final int checkVersion;
  late final dynamic controller;

  BirthYearPicker({super.key, required this.checkVersion}){
    if(checkVersion==0){
      controller = Get.find<UserInfoController>();
    }else{
      controller = Get.find<SignUpController>();
    }
  }

  int selectedNumber = 0;

  @override
  Widget build(BuildContext context) {
    final List<int> yearOptions =
        List.generate(2024 - 1900 + 1, (index) => 1900 + index);
    final FixedExtentScrollController fixedExtentScrollController = FixedExtentScrollController(
      initialItem: controller.birthYear.value - 1900,
    );
    selectedNumber = controller.birthYear.value;
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
                    "출생연도 선택",
                    style: TextStyles.fs20w700cTextPrimary,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    FocusManager.instance.primaryFocus?.unfocus();
                    TextEditingController().clear();
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
                  controller.selectBirthYear(selectedNumber);
                  Get.back();
                },
                child: CupertinoPicker(
                  itemExtent: 60,
                  magnification: 1.22,
                  selectionOverlay: CupertinoPickerDefaultSelectionOverlay(
                    background: AppColors.secondary,
                  ),
                  onSelectedItemChanged: (selectedYear) {
                    selectedNumber = yearOptions[selectedYear];
                    controller.birthYear.value = yearOptions[selectedYear];
                  },
                  scrollController: fixedExtentScrollController,
                  children: yearOptions.map((year) {
                    return Center(
                      child: Text(
                        year.toString(),
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
