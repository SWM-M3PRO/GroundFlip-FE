import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/user_info_controller.dart';

class SelectGenderWidget extends StatelessWidget {
  const SelectGenderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoController controller = Get.find<UserInfoController>();
    return Padding(
      padding: const EdgeInsets.only(top: 40, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ButtonTheme(
            height: 178,
            minWidth: 167,
            child: ElevatedButton(
              onPressed: controller.isGender.value == 1
                  ? controller.updateSelectedGender
                  : null,
              style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.boxColor,
                  disabledBackgroundColor:
                  AppColors.buttonColor,
                  shape: RoundedRectangleBorder(
                      borderRadius:
                      BorderRadius.circular(16))),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/male.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    '남성',
                    style: TextStyle(
                      color:
                      controller.isGender.value == 0
                          ? AppColors.textBlack
                          : AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 15),
          ButtonTheme(
            height: 178,
            minWidth: 167,
            child: ElevatedButton(
              onPressed: controller.isGender.value == 0
                  ? controller.updateSelectedGender
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.boxColor,
                disabledBackgroundColor:
                AppColors.buttonColor,
                shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(16)),
              ),
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/female.png',
                    width: 100,
                    height: 100,
                  ),
                  Text(
                    '여성',
                    style: TextStyle(
                      color:
                      controller.isGender.value == 1
                          ? AppColors.textBlack
                          : AppColors.textPrimary,
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
