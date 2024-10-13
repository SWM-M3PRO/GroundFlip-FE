import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../service/community_service.dart';
import '../widgets/common/alert/alert.dart';

class CommunityCreateController extends GetxController {
  final CommunityService communityService = CommunityService();

  late final TextEditingController textEditingController;
  final FocusNode textFocusNode = FocusNode();

  final ImagePicker picker = ImagePicker();
  final RegExp regExp1 = RegExp(r'^[A-Za-z가-힣 0-9]{2,20}$');
  final RegExp regExp2 = RegExp(r'^[A-Za-z가-힣0-9ㄱ-ㅎㅏ-ㅣ ]{3,10}$');


  var profileImage = Rxn<XFile>();

  RxString communityName = "".obs;
  RxString imageS3Url = "".obs;
  RxString nicknameValidation = "".obs;
  RxBool isNicknameTyped = false.obs;
  RxBool colorPickerStatement = true.obs;
  Color pickerColor = Color(0xff443a49);
  RxInt selectedColor = 0xff443a49.obs;

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

  void updateNickname(String inputString) {
    communityName.value = inputString;
    if (inputString == '') {
      isNicknameTyped.value = false;
    } else {
      isNicknameTyped.value = true;
    }
    if (regExp2.hasMatch(inputString) && !regExp1.hasMatch(inputString)) {
      nicknameValidation.value = "자음 모음은 사용할 수 없습니다!";
    }
    if (!regExp1.hasMatch(inputString) && !regExp2.hasMatch(inputString)) {
      nicknameValidation.value = "형식에 맞지 않습니다!";
    }
    if (regExp1.hasMatch(inputString)) {
      nicknameValidation.value = "3~10자 이내";
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
        if (context.mounted) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Alert(title: "10MB 이하 사이즈의 이미지를 넣어주세요!", buttonText: "확인");
            },
          );
        }
      } else {
        profileImage.value = selectedImage;
      }
    }
  }

  void updateColor(Color newColor){
    selectedColor.value = newColor.value;
  }

  void completeRegistration() async {
    try {
      int? statusCode = await communityService.createCommunity(
        communityName : communityName.value,
        communityColor: selectedColor.value,
        profileImagePath: profileImage.value?.path,
      );
      if (statusCode == 200) {
        Get.offAllNamed('/onboard');
      }
    } catch (e) {
      if (!regExp1.hasMatch(communityName.value)) {
        showErrorDialog('그룹명 형식이 맞지 않습니다!');
      }
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 400) {
          showErrorDialog('중복된 그룹명입니다!');
        }
      }
    }

  }

  void deleteImage() {
    profileImage.value = null;
    update();
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

}