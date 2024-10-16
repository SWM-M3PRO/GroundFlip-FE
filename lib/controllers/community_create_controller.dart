import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../constants/app_colors.dart';
import '../service/community_service.dart';
import '../widgets/common/alert/alert.dart';
import 'community_controller.dart';
import 'community_info_controller.dart';
import 'my_page_controller.dart';

class CommunityCreateController extends GetxController {
  final CommunityService communityService = CommunityService();
  final CommunityInfoController communityInfoController = CommunityInfoController();

  late final TextEditingController textEditingController;
  late final TextEditingController textEditingController2;
  late final TextEditingController textEditingController3;
  final FocusNode textFocusNode = FocusNode();
  final FocusNode textFocusNode2 = FocusNode();
  final FocusNode textFocusNode3 = FocusNode();

  final ImagePicker picker = ImagePicker();
  final RegExp regExp1 = RegExp(r'^[A-Za-z가-힣 0-9]{2,20}$');
  final RegExp regExp2 = RegExp(r'^[A-Za-z가-힣0-9ㄱ-ㅎㅏ-ㅣ ]{3,10}$');
  final RegExp regExp3 = RegExp(r'^[0-9]{4,10}$');

  var profileImage = Rxn<XFile>();

  RxString communityName = "".obs;
  RxString imageS3Url = "".obs;
  RxString nicknameValidation = "".obs;
  RxString password = "".obs;
  RxString passwordCheck = "".obs;
  RxString passwordValidation = "".obs;
  RxString passwordCheckValidation = "".obs;
  RxBool isNicknameTyped = false.obs;
  RxBool isPasswordTyped = false.obs;
  RxBool isPasswordCheckTyped = false.obs;
  RxBool colorPickerStatement = false.obs;
  RxBool passwordOnOff = false.obs;
  Color pickerColor = Color(0xff443a49);
  RxInt selectedColor = 0xFF0DF69E.obs;

  @override
  void onInit() {
    textEditingController = TextEditingController();
    textEditingController2 = TextEditingController();
    textEditingController3 = TextEditingController();

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
    textFocusNode2.addListener(
          () {
        if (textFocusNode2.hasFocus) {
          textEditingController2.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textEditingController2.text.length,
          );
        }
        if (!textFocusNode2.hasFocus) {
          passwordSubmitted(textEditingController2.text);
        }
      },
    );
    textFocusNode3.addListener(
          () {
        if (textFocusNode3.hasFocus) {
          textEditingController3.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textEditingController3.text.length,
          );
        }
        if (!textFocusNode3.hasFocus) {
          passwordCheckSubmitted(textEditingController3.text);
        }
      },
    );
  }

  void updatePasswordCheck(String inputString) {
    passwordCheck.value = inputString;
    if (inputString == '') {
      isPasswordCheckTyped.value = false;
    } else {
      isPasswordCheckTyped.value = true;
    }
    if (passwordCheck.value == password.value) {
      passwordCheckValidation.value = "일치";
    } else {
      passwordCheckValidation.value = "";
    }
  }

  void updatePassword(String inputString) {
    password.value = inputString;
    if (inputString == '') {
      isPasswordTyped.value = false;
    } else {
      isPasswordTyped.value = true;
    }
    if (!regExp3.hasMatch(inputString)) {
      passwordValidation.value = "";
    } else {
      passwordValidation.value = "0-9숫자, 4~10자리";
    }
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

  void passwordSubmitted(String value) {
    updatePassword(value);
    if (!regExp3.hasMatch(value)) {
      passwordValidation.value = "";
    } else {
      passwordValidation.value = "0-9숫자, 4~10자리";
    }
  }

  void passwordCheckSubmitted(String value) {
    updatePasswordCheck(value);
    if (passwordCheck.value == password.value) {
      passwordCheckValidation.value = "일치";
    } else {
      passwordCheckValidation.value = "";
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

  void updateColor(Color newColor) {
    selectedColor.value = newColor.value;
  }

  void completeRegistration() async {
    try {
      late int communityId;
      String? dioPassword = password.value;

      if (passwordOnOff.value == false) {
        dioPassword = null;
      }else{
        if (passwordOnOff.value) {
          if (!regExp3.hasMatch(password.value)) {
            showErrorDialog('비밀번호 형식이 맞지 않습니다!');
            return;
          } else {
            if (password.value != passwordCheck.value) {
              showErrorDialog('비밀번호 확인이 맞지 않습니다!');
              return;
            }
          }
        }
      }
      if (profileImage.value == null) {
        showErrorDialog('이미지를 반드시 넣어 주세요!');
        return;
      }
      if (!regExp1.hasMatch(communityName.value)) {
        showErrorDialog('그룹명 형식이 맞지 않습니다!');
        return;
      }

      int? statusCode = await communityService.createCommunity(
        communityName: communityName.value,
        communityColor: selectedColor.value,
        password: dioPassword,
        profileImagePath: profileImage.value!.path,
      );
      communityId = await communityService.getCommunityId(communityName.value);

      await signInCommunity(communityId);

      if (statusCode == 200) {
        Get.offAllNamed('/main');
      }
    } catch (e) {
      if (e is DioException) {
        final response = e.response;
        if (response != null && response.statusCode == 400) {
          showErrorDialog('중복된 그룹명입니다!');
          return;
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
                fontSize: 17,
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

  Future<void> signInCommunity(int communityId) async {
    int? response;
    response = await communityService
        .signInCommunity(communityId);
    if (response == 200) {
      MyPageController myPageController =
      Get.find<MyPageController>();
      CommunityController communityController =
      Get.find<CommunityController>();
      await myPageController.updateUserInfo();
      await communityController.updateCommunityInfo();
    }
  }

}
