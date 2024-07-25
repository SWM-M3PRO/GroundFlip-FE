import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/sign_up_controller.dart';
import '../../controllers/user_info_controller.dart';
import 'birth_year_picker.dart';

class SelectBirthWidget extends StatelessWidget {
  final int checkVersion;
  late final dynamic controller;

  SelectBirthWidget({super.key, required this.checkVersion}) {
    if (checkVersion == 0) {
      controller = Get.find<UserInfoController>();
    } else {
      controller = Get.find<SignUpController>();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.bottomSheet(
          BirthYearPicker(),
          backgroundColor: AppColors.backgroundSecondary,
          enterBottomSheetDuration: Duration(milliseconds: 100),
          exitBottomSheetDuration: Duration(milliseconds: 100),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.boxColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Obx(
                () =>
                Row(
                  children: [
                    Text(
                      '${controller.birthYear.value}',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 17,
                      ),
                    ),
                    Spacer(),
                    Icon(
                      Icons.keyboard_arrow_down,
                      color: AppColors.textPrimary,
                    ),
                  ],
                ),
          ),
        ),
      ),
    );
  }
}
