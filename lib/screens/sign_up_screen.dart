import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/sign_up_controller.dart';
import '../widgets/user_modify/select_birth_widget.dart';
import '../widgets/user_modify/select_gender_widget.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SignUpController controller = Get.put(SignUpController());

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
            '회원가입',
            style: TextStyle(
              color: AppColors.textPrimary,
            ),
          ),
        ),
        body: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Column(
                      children: [
                        Obx(
                              () => Column(
                            children: [
                              CircleAvatar(
                                radius: 80.0,
                                backgroundImage: controller.profileImage.value != null
                                    ? FileImage(File(controller.profileImage.value!.path))
                                as ImageProvider
                                    : AssetImage('assets/images/default_profile_image.png')
                                as ImageProvider,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 0,),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: controller.getImage,
                                      child: Container(
                                        height: 44,
                                        width: 104,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          color: AppColors.boxColorThird,
                                        ),
                                        child: Center(
                                          child: Text(
                                            '이미지 변경',
                                            style: TextStyle(
                                                color: AppColors.textPrimary,
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,),
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 15),
                                    InkWell(
                                      onTap: controller.deleteImage,
                                      child: Container(
                                        height: 44,
                                        width: 44,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(24),
                                          color: AppColors.boxColorThird,
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.close,
                                            color: AppColors.buttonColor,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
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
                                      vertical: 0, horizontal: 15,),
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
                              vertical: 10, horizontal: 0,),
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
                              SelectBirthWidget(checkVersion: 1,),
                              SelectGenderWidget(checkVersion: 1,),
                            ],
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: controller.isNicknameTyped.value
                              ? controller.completeRegistration
                              : null,
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
                        ),
                      ],
                    ),
                  ),
                ),
              ),
          ),
      ),
    );
  }
}
