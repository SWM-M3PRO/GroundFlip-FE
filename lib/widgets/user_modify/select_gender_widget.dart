import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/sign_up_controller.dart';
import '../../controllers/user_info_controller.dart';

class SelectGenderWidget extends StatelessWidget {
  final int checkVersion;
  late final dynamic controller;

  SelectGenderWidget({super.key, required this.checkVersion}) {
    if (checkVersion == 0) {
      controller = Get.find<UserInfoController>();
    } else {
      controller = Get.find<SignUpController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(top: 40, bottom: 40),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: (MediaQuery.of(context).size.width - 40) / 3,

              child: ElevatedButton(
                onPressed: controller.isMale.value != 1
                    ? () => controller.updateSelectedGender(0)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boxColor,
                  disabledBackgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    '남성',
                    style: TextStyle(
                      color: controller.isMale.value == 1
                          ? AppColors.textBlack
                          : AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: (MediaQuery.of(context).size.width - 40) / 3,
              child: ElevatedButton(
                onPressed: controller.isFemale.value != 1
                    ? () => controller.updateSelectedGender(1)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boxColor,
                  disabledBackgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    '여성',
                    style: TextStyle(
                      color: controller.isFemale.value == 1
                          ? AppColors.textBlack
                          : AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10),
            Container(
              padding: EdgeInsets.symmetric(vertical: 5),
              width: (MediaQuery.of(context).size.width - 40) / 3,
              child: ElevatedButton(
                onPressed: controller.isNoneGender.value != 1
                    ? () => controller.updateSelectedGender(2)
                    : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boxColor,
                  disabledBackgroundColor: AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    '선택안함',
                    style: TextStyle(
                      color: controller.isNoneGender.value == 1
                          ? AppColors.textBlack
                          : AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
