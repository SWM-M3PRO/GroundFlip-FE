import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../models/user.dart';
import '../service/user_service.dart';
import '../widgets/common/alert.dart';
import 'my_page_controller.dart';

class UserInfoController extends GetxController {
  final UserService userService = UserService();
  final ImagePicker picker = ImagePicker();
  late final TextEditingController textEditingController;
  final FocusNode textFocusNode = FocusNode();

  late User user;

  final RegExp regExp1 = RegExp(r'^[A-Za-z가-힣0-9]{3,10}$');
  final RegExp regExp2 = RegExp(r'^[A-Za-z가-힣0-9ㄱ-ㅎㅏ-ㅣ]{3,10}$');

  var profileImage = Rxn<XFile>();

  late RxList<bool> toggleSelection;

  RxString nickname = "-".obs;
  RxInt birthYear = 2000.obs;
  RxString gender = "MALE".obs;
  RxString imageS3Url = "".obs;
  RxString nicknameValidation = "".obs;
  RxBool isNicknameTyped = false.obs;
  RxBool isUserInfoInit = false.obs;
  RxBool isInitImageUrl = false.obs;
  RxInt isMale = 0.obs;
  RxInt isFemale = 0.obs;
  RxInt isNoneGender = 0.obs;

  @override
  void onInit() async {
    await userInfoInit();
    super.onInit();
    checkGender();
    isUserInfoInit.value = true;
    initTextFocusNode();
    update();
  }

  @override
  Future<void> onClose() async{
    await textDispose();
    super.onClose();
  }

  Future<void> textDispose() async{
    textEditingController.dispose();
    textFocusNode.dispose();
  }

  void checkGender() {
    genderValueToZero();
    switch (gender.value) {
      case 'MALE':
        isMale.value = 1;
        break;
      case 'FEMALE':
        isFemale.value = 1;
        break;
      case 'NONE':
        isNoneGender.value = 1;
        break;
    }
  }

  void updateSelectedGender(int genderValue) {
    genderValueToZero();
    switch (genderValue) {
      case 0:
        isMale.value = 1;
        gender.value = 'MALE';
        break;
      case 1:
        isFemale.value = 1;
        gender.value = 'FEMALE';
        break;
      case 2:
        isNoneGender.value = 1;
        gender.value = 'NONE';
        break;
    }
  }

  void genderValueToZero() {
    isMale.value = 0;
    isFemale.value = 0;
    isNoneGender.value = 0;
  }

  void initTextFocusNode() {
    textFocusNode.addListener(
      () {
        if (textFocusNode.hasFocus) {
          textEditingController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textEditingController.text.length,
          );
        }
        if (!textFocusNode.hasFocus) {
          onSubmitted(textEditingController.text);
        }
      },
    );
  }

  Future<void> userInfoInit() async {
    user = await userService.getCurrentUserInfo();
    nickname.value = user.nickname ?? "-";
    birthYear.value = user.birthYear ?? 2000;
    gender.value = user.gender ?? "MALE";
    imageS3Url.value = user.profileImageUrl ?? "";
    isInitImageUrl.value = true;
    textEditingController = TextEditingController(text: nickname.value);
  }

  Future getImage(BuildContext context) async {
    int imageSize = 0;
    double imageSizeMB = 0.0;
    XFile? selectedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (selectedImage != null) {
      imageSize = await selectedImage.length();
      imageSizeMB = imageSize / (1024 * 1024);
      if (imageSizeMB > 10) {
        if(context.mounted){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Alert(text1: "10MB 이하 사이즈의 이미지를 넣어주세요!", text2: "확인");
            },
          );
        }
      } else {
        profileImage.value = selectedImage;
      }
    }
  }

  void updateBirthYear(int inputBirthYear) {
    birthYear.value = inputBirthYear;
  }

  void updateNickname(String value) {
    nickname.value = value;
    if (regExp2.hasMatch(value) && !regExp1.hasMatch(value)) {
      nicknameValidation.value = "자음 모음은 사용할 수 없습니다!";
    }
    if (!regExp1.hasMatch(value) && !regExp2.hasMatch(value)) {
      nicknameValidation.value = "형식에 맞지 않습니다!";
    }
    if (regExp1.hasMatch(value)) {
      nicknameValidation.value = "3~10자 이내";
    }
    if (value == '') {
      isNicknameTyped.value = false;
    } else {
      isNicknameTyped.value = true;
    }
  }

  void showErrorDialog(String message) {
    Get.dialog(
      AlertDialog(
        title: Padding(
          padding: const EdgeInsets.only(top: 10),
          child: Align(
            alignment: Alignment.topLeft,
            child: Text(
              message,
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            child: Text(
              '확인',
              style: TextStyle(
                color: AppColors.textSecondary,
              ),
            ),
            onPressed: () async {
              Get.back();
            },
          ),
        ],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        backgroundColor: AppColors.boxColor,
      ),
    );
  }

  void completeUserInfoUpdate() async {
    try {
      int? statusCode = await userService.putUserInfo(
        gender: gender.value,
        birthYear: birthYear.value,
        nickname: nickname.value,
        profileImagePath: profileImage.value?.path,
      );
      if (statusCode == 200) {
        await Get.find<MyPageController>().updateUserInfo();
        Get.back();
      }
    } catch (e) {
      if (!regExp1.hasMatch(nickname.value)) {
        showErrorDialog('닉네임 형식이 맞지 않습니다!');
      }
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 400) {
          showErrorDialog('중복된 닉네임입니다!');
        }
      }
    }
  }

  void onSubmitted(String value) {
    nickname.value = value;
    if (regExp2.hasMatch(value) && !regExp1.hasMatch(value)) {
      nicknameValidation.value = "자음 모음은 사용할 수 없습니다!";
    }
    if (!regExp1.hasMatch(value) && !regExp2.hasMatch(value)) {
      nicknameValidation.value = "형식에 맞지 않습니다!";
    }
    if (regExp1.hasMatch(value)) {
      nicknameValidation.value = "3~10자 이내";
    }
    FocusScope.of(Get.context!).unfocus();
  }

  void selectBirthYear(int year) async {
    birthYear.value = year;
  }

  void deleteImage() {
    profileImage.value = null;
    update();
  }
}
