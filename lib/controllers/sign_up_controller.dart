import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/state_manager.dart';

import '../service/user_service.dart';

class SignUpController extends GetxController {
  final UserService userService = UserService();

  late RxList<bool> toggleSelection;
  bool isMale = true;
  bool isFemale = false;

  RxString nickname = ''.obs;
  RxInt birthYear = 2000.obs;
  RxString gender = 'MALE'.obs;
  RxBool isNicknameTyped = false.obs;

  @override
  void onInit() {
    toggleSelection = [isMale, isFemale].obs;
    super.onInit();
  }

  void updateSelectedValue(int index) {
    if (index == 0) {
      toggleSelection.assignAll([true, false]);
      gender.value = 'MALE';
    } else {
      toggleSelection.assignAll([false, true]);
      gender.value = 'FEMALE';
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

  void compltetRegistration() async {
    await userService.putUserInfo(gender.value, birthYear.value, nickname.value);
    Get.offAllNamed('/main');
  }
}
