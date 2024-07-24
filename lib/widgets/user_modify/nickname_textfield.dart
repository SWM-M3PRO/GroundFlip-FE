import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/user_info_controller.dart';

class NicknameTextfield extends StatelessWidget {
  const NicknameTextfield({super.key});

  @override
  Widget build(BuildContext context) {
    UserInfoController controller = Get.find<UserInfoController>();
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 10, bottom: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.baseline,
              textBaseline: TextBaseline.alphabetic,
              children: [
                Text(
                  '닉네임',
                  style: TextStyle(
                    fontSize: 17.0,
                    color: AppColors.textForth,
                  ),
                ),
                SizedBox(
                  width: 7.0,
                ),
                Text(
                  '영어,한글,숫자 조합 3~10자',
                  style: TextStyle(
                    fontSize: 11.0,
                    color: AppColors.textForth,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: 56,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: AppColors.boxColor,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
            child: Center(
              child: TextField(
                controller: controller.textEditingController,
                autofocus: true,
                focusNode: controller.textFocusNode,
                onSubmitted: controller.onSubmitted,
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                style: TextStyle(
                  fontSize: 17.0,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Obx(
            () => Padding(
              padding: const EdgeInsets.only(left: 10,top: 5),
              child: Row(
                children: [
                  Text(
                    controller.nicknameValidation.value,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textForth,
                    ),
                  ),
                  Icon(
                    controller.nicknameValidation.value == "3~10자 이내"?
                        Icons.check:
                        null,
                    color: AppColors.textForth,
                    size: 15,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
