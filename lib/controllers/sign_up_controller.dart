import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../service/user_service.dart';
import '../utils/secure_storage.dart';

class SignUpController extends GetxController {
  final UserService userService = UserService();
  final ImagePicker picker = ImagePicker();
  final SecureStorage secureStorage = SecureStorage();
  late final TextEditingController textEditingController;
  final FocusNode textFocusNode = FocusNode();

  var profileImage = Rxn<XFile>();

  final RegExp regExp1 = RegExp(r'^[A-Za-z가-힣0-9]{3,10}$');
  final RegExp regExp2 = RegExp(r'^[A-Za-z가-힣0-9ㄱ-ㅎㅏ-ㅣ]{3,10}$');

  late RxList<bool> toggleSelection;
  bool isMale = true;
  bool isFemale = false;

  RxString nickname = ''.obs;
  RxInt birthYear = 2000.obs;
  RxString gender = 'MALE'.obs;
  RxString nicknameValidation = "".obs;
  RxBool isNicknameTyped = false.obs;
  RxInt isGender = 0.obs;

  @override
  void onInit() {
    textEditingController = TextEditingController();
    initTextFocusNode();
    super.onInit();
  }

  void initTextFocusNode() {
    textFocusNode.addListener(
      () {
        if (textFocusNode.hasFocus) {
          textEditingController.selection = TextSelection(
              baseOffset: 0, extentOffset: textEditingController.text.length,);
        }
        if (!textFocusNode.hasFocus) {
          onSubmitted(textEditingController.text);
        }
      },
    );
  }

  Future getImage() async {
    XFile? selectedImage = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 100,
    );
    if (selectedImage != null) {
      profileImage.value = selectedImage;
    }
  }

  void updateSelectedGender() {
    if (isGender.value == 0) {
      isGender.value = 1;
      gender.value = 'FEMALE';
    } else {
      isGender.value = 0;
      gender.value = 'MALE';
    }
  }

  void updateBirthYear(int inputBirthYear) {
    birthYear.value = inputBirthYear;
  }

  void updateNickname(String inputString) {
    nickname.value = inputString;
    if (inputString == '') {
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
            onPressed: () {
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

  void completeRegistration() async {
    try {
      int? statusCode = await userService.putUserInfo(
        gender: gender.value,
        birthYear: birthYear.value,
        nickname: nickname.value,
        profileImagePath: profileImage.value?.path,
      );
      if (statusCode == 200) {
        await secureStorage.writeSignupStatus("true");
        Get.offAllNamed('/main');
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
    updateNickname(value);
    if (regExp2.hasMatch(value) && !regExp1.hasMatch(value)) {
      nicknameValidation.value = "자음 모음은 사용할 수 없습니다!";
    }
    if (!regExp1.hasMatch(value) && !regExp2.hasMatch(value)) {
      nicknameValidation.value = "형식에 맞지 않습니다!";
    }
    if (regExp1.hasMatch(value)) {
      nicknameValidation.value = "3~10자 이내";
    }
  }

  void deleteImage() {
    profileImage.value = null;
    update();
  }
}
