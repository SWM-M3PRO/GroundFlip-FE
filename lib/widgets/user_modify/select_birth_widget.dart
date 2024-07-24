import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/user_info_controller.dart';

class SelectBirthWidget extends StatelessWidget {
  const SelectBirthWidget({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoController controller = Get.find<UserInfoController>();
    const int lowBoundYear = 1900;
    const int upperBoundYear = 2024;

    return DropdownButtonHideUnderline(
      child: DropdownButton2<int>(
        value: controller.birthYear.value,
        alignment: Alignment.center,
        isExpanded: true,
        onChanged: (birthYear) =>
        controller.birthYear.value = birthYear!,
        items: List.generate(
          upperBoundYear - lowBoundYear + 1,
              (index) {
            int year = 1900 + index;
            return DropdownMenuItem(
              value: year,
              child: Text(
                year.toString(),
                style: const TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 14.0,
                ),
              ),
            );
          },
        ),
        buttonStyleData: ButtonStyleData(
          height: 60,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.boxColor,
          ),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          decoration: BoxDecoration(
            color: AppColors.boxColor,
          ),
        ),
        iconStyleData: IconStyleData(
          icon: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              // 아이콘의 왼쪽에 패딩 추가
              Icon(
                Icons.keyboard_arrow_down,
                color: AppColors.textPrimary,
              ),
              SizedBox(width: 15.0), // 아이콘의 오른쪽에 패딩 추가
            ],
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(),
      ),
    );
  }
}
