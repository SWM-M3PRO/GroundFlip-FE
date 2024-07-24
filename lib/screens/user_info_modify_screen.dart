import 'dart:io';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/user_info_controller.dart';
import '../widgets/user_modify/select_birth_widget.dart';
import '../widgets/user_modify/nickname_textfield.dart';
import '../widgets/user_modify/profile_image.dart';
import '../widgets/user_modify/select_gender_widget.dart';
import 'my_page_screen.dart';

class UserInfoModifyScreen extends StatelessWidget {
  const UserInfoModifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final UserInfoController controller = Get.put(UserInfoController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.buttonColor,
            ),
          ),
          backgroundColor: AppColors.background,
          title: Text(
            '프로필 수정',
            style: TextStyle(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Obx(
            () {
              if (!controller.isUserInfoInit.value) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              return Center(
                child: Column(
                  children: [
                    ProfileImage(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 5),
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
                              padding: const EdgeInsets.symmetric(
                                  vertical: 0, horizontal: 15),
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
                                padding:
                                    const EdgeInsets.only(left: 10, top: 5),
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
                                      controller.nicknameValidation.value ==
                                              "3~10자 이내"
                                          ? Icons.check
                                          : null,
                                      color: AppColors.textForth,
                                      size: 15,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 10, bottom: 8),
                              child: Text(
                                '출생년도',
                                style: TextStyle(
                                  fontSize: 17.0,
                                  color: AppColors.textForth,
                                ),
                              ),
                            ),
                          ),
                          SelectBirthWidget(),
                          SelectGenderWidget(),
                        ],
                      ),
                    ),
                    InkWell(
                      borderRadius: BorderRadius.circular(16),
                      onTap: controller.completeUserInfoUpdate,
                      child: Container(
                        height: 60,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.boxColorSecond,
                        ),
                        child: Center(
                          child: Text(
                            '완료',
                            style: TextStyles.fx17w700cTextThird,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
