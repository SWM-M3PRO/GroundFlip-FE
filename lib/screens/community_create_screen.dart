import 'dart:io';

import 'package:flutter/material.dart';
//import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/community_create_controller.dart';
import '../widgets/user_modify/select_birth_widget.dart';
import '../widgets/user_modify/select_gender_widget.dart';

class CommunityCreateScreen extends StatelessWidget {
  const CommunityCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunityCreateController communityCreateController =
        Get.put(CommunityCreateController());

    Color pickerColor = Color(0xff443a49);

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
        body: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.only(top: 20),
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Column(
                    children: [
                      Obx(
                        () => Column(
                          children: [
                            CircleAvatar(
                              radius: 80.0,
                              backgroundImage: communityCreateController
                                          .profileImage.value !=
                                      null
                                  ? FileImage(
                                      File(communityCreateController
                                          .profileImage.value!.path),
                                    ) as ImageProvider
                                  : AssetImage(
                                      'assets/images/default_profile_image.png',
                                    ) as ImageProvider,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                vertical: 10,
                                horizontal: 0,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      communityCreateController
                                          .getImage(context);
                                    },
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
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 15),
                                  InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap:
                                        communityCreateController.deleteImage,
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.baseline,
                                  textBaseline: TextBaseline.alphabetic,
                                  children: [
                                    Text(
                                      '그룹명',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: AppColors.textForth,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 7.0,
                                    ),
                                    Text(
                                      '영어,한글,숫자 조합 2~15자',
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
                                  vertical: 0,
                                  horizontal: 15,
                                ),
                                child: Center(
                                  child: TextField(
                                    controller: communityCreateController
                                        .textEditingController,
                                    autofocus: false,
                                    focusNode:
                                        communityCreateController.textFocusNode,
                                    onChanged: communityCreateController
                                        .updateNickname,
                                    onSubmitted:
                                        communityCreateController.onSubmitted,
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
                                        communityCreateController
                                            .nicknameValidation.value,
                                        style: TextStyle(
                                          fontSize: 14,
                                          color: communityCreateController
                                                      .nicknameValidation
                                                      .value ==
                                                  "3~10자 이내"
                                              ? AppColors.primary
                                              : AppColors.textForth,
                                        ),
                                      ),
                                      Icon(
                                        communityCreateController
                                                    .nicknameValidation.value ==
                                                "3~10자 이내"
                                            ? Icons.check
                                            : null,
                                        color: AppColors.primary,
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
                          vertical: 10,
                          horizontal: 0,
                        ),
                        child: Column(
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 8),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '그룹 컬러',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: AppColors.textForth,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                    Obx(
                                      () => Container(
                                        width: 30,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(5),
                                            color: Color(communityCreateController
                                                .selectedColor.value),
                                      ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 10),
                            Obx(() {
                              return Column(
                                children: [
                                  InkWell(
                                    borderRadius: BorderRadius.circular(16),
                                    onTap: () {
                                      communityCreateController
                                              .colorPickerStatement.value
                                          ? communityCreateController
                                              .colorPickerStatement
                                              .value = false
                                          : communityCreateController
                                              .colorPickerStatement
                                              .value = true;
                                      print(communityCreateController
                                          .colorPickerStatement.value);
                                    },
                                    child: Container(
                                      height: 60,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(16),
                                        color: AppColors.primary,
                                      ),
                                      child: Center(
                                        child: Text(
                                          '컬러 선택',
                                          style: TextStyles.fx17w700cTextThird,
                                        ),
                                      ),
                                    ),
                                  ),
                                  communityCreateController
                                          .colorPickerStatement.value
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10),
                                          child: ColorPicker(
                                            color: pickerColor,
                                            onColorChanged : communityCreateController.updateColor,
                                            pickersEnabled: const<ColorPickerType, bool>{
                                              ColorPickerType.both: true,
                                              ColorPickerType.accent: false,
                                              ColorPickerType.primary: false,
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            })
                          ],
                        ),
                      ),
                      Obx(() {
                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: communityCreateController.isNicknameTyped.value
                              ? communityCreateController.completeRegistration
                              : null,
                          child: Container(
                            height: 60,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: communityCreateController
                                      .isNicknameTyped.value
                                  ? AppColors.primary
                                  : AppColors.boxColorSecond,
                            ),
                            child: Center(
                              child: Text(
                                '완료',
                                style: TextStyles.fx17w700cTextThird,
                              ),
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
