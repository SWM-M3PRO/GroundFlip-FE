import 'dart:io';

//import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:flex_color_picker/flex_color_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/community_create_controller.dart';

class CommunityCreateScreen extends StatelessWidget {
  const CommunityCreateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final CommunityCreateController communityCreateController =
        Get.put(CommunityCreateController());

    Color pickerColor = AppColors.primary;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        resizeToAvoidBottomInset: true,
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
            '그룹 생성',
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
                                          .profileImage.value!.path,),
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
                                    horizontal: 10, vertical: 8,),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      '그룹 색상',
                                      style: TextStyle(
                                        fontSize: 17.0,
                                        color: AppColors.textForth,
                                      ),
                                    ),
                                    SizedBox(width: 10),
                                  ],
                                ),
                              ),
                            ),
                            Obx(() {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
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
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 40,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(16),
                                              color: AppColors.primary,
                                            ),
                                            child: Center(
                                              child: Text(
                                                '색상 선택',
                                                style: TextStyle(
                                                  color: AppColors.textThird,
                                                  fontSize: 12,
                                                  fontWeight: FontWeight.w700,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Spacer(),
                                        Obx(
                                              () => Container(
                                            width: 30,
                                            height: 30,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                              BorderRadius.circular(5),
                                              color: Color(communityCreateController
                                                  .selectedColor.value,),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  communityCreateController
                                          .colorPickerStatement.value
                                      ? Padding(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 10,),
                                          child: ColorPicker(
                                            color: AppColors.primary,
                                            onColorChanged:
                                                communityCreateController
                                                    .updateColor,
                                            pickersEnabled: const <ColorPickerType,
                                                bool>{
                                              ColorPickerType.both: true,
                                              ColorPickerType.accent: false,
                                              ColorPickerType.primary: false,
                                            },
                                          ),
                                        )
                                      : Container(),
                                ],
                              );
                            }),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Row(
                                children: [
                                  Text(
                                    '비밀번호',
                                    style: TextStyle(
                                      fontSize: 17.0,
                                      color: AppColors.textForth,
                                    ),
                                  ),
                                  //SizedBox(width: 5),
                                  Obx(
                                    () => Checkbox(
                                      value: communityCreateController
                                          .passwordOnOff.value,
                                      onChanged: (bool? value) {
                                        if (communityCreateController
                                            .passwordOnOff.value) {
                                          communityCreateController
                                              .passwordOnOff.value = false;
                                        } else {
                                          communityCreateController
                                              .passwordOnOff.value = true;
                                        }
                                      },
                                      activeColor: AppColors.primary,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Obx(
                            () => communityCreateController.passwordOnOff.value ?
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
                                    obscureText: true,
                                    controller: communityCreateController
                                        .textEditingController2,
                                    autofocus: false,
                                    focusNode:
                                    communityCreateController.textFocusNode2,
                                    onChanged: communityCreateController
                                        .updatePassword,
                                    onSubmitted:
                                    communityCreateController.passwordSubmitted,
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
                            ) : Container(),
                          ),
                          Obx(
                                () => communityCreateController.passwordOnOff.value ? Padding(
                              padding:
                              const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: [
                                  Text(
                                    "0-9숫자, 4~10자리",
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: communityCreateController
                                          .passwordValidation
                                          .value ==
                                          "0-9숫자, 4~10자리"
                                          ? AppColors.primary
                                          : AppColors.textForth,
                                    ),
                                  ),
                                  Icon(
                                    communityCreateController
                                        .passwordValidation.value ==
                                        "0-9숫자, 4~10자리"
                                        ? Icons.check
                                        : null,
                                    color: AppColors.primary,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ) : Container(),
                          ),
                          Obx(
                              () => communityCreateController.passwordOnOff.value ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  '비밀번호 확인',
                                  style: TextStyle(
                                    fontSize: 17.0,
                                    color: AppColors.textForth,
                                  ),
                                ),
                              ),
                            ) : Container(),
                          ),
                          //SizedBox(height: 10),
                          Obx(
                                () => communityCreateController.passwordOnOff.value ?
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
                                    obscureText: true,
                                    controller: communityCreateController
                                        .textEditingController3,
                                    autofocus: false,
                                    focusNode:
                                    communityCreateController.textFocusNode3,
                                    onChanged: communityCreateController
                                        .updatePasswordCheck,
                                    onSubmitted:
                                    communityCreateController.passwordSubmitted,
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
                            ) : Container(),
                          ),
                          Obx(
                                () => communityCreateController.passwordOnOff.value ? Padding(
                              padding:
                              const EdgeInsets.only(left: 10, top: 5),
                              child: Row(
                                children: [
                                  Text(
                                    communityCreateController
                                        .passwordCheckValidation.value,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: communityCreateController
                                          .passwordCheckValidation
                                          .value ==
                                          "일치"
                                          ? AppColors.primary
                                          : AppColors.textForth,
                                    ),
                                  ),
                                  Icon(
                                    communityCreateController
                                        .passwordCheckValidation.value ==
                                        "일치"
                                        ? Icons.check
                                        : null,
                                    color: AppColors.primary,
                                    size: 15,
                                  ),
                                ],
                              ),
                            ) : Container(),
                          ),
                        ],
                      ),
                      SizedBox(height: 30),
                      Obx(() {
                        return InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            communityCreateController.completeRegistration();
                            // print(2222);
                            // if (communityCreateController.nicknameValidation
                            //     .value=="3~10자 이내") {
                            //   if (communityCreateController.passwordOnOff
                            //       .value) {
                            //     if (communityCreateController.passwordValidation
                            //         .value == "0-9숫자, 4~10자리" &&
                            //         communityCreateController
                            //             .passwordCheckValidation.value ==
                            //             "일치") {
                            //       communityCreateController
                            //           .completeRegistration();
                            //     }
                            //   }else {
                            //     communityCreateController.completeRegistration();
                            //   }
                            // }
                          },
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
