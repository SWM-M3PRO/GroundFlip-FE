import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../models/user.dart';
import '../service/user_service.dart';

class UserInfoController extends GetxController {
  final UserService userService = UserService();
  final ImagePicker picker = ImagePicker();

  late User user;

  var profileImage = Rxn<XFile>();

  late RxList<bool> toggleSelection;
  bool isMale = true;
  bool isFemale = false;

  RxString nickname = "-".obs;
  RxInt birthYear = 2000.obs;
  RxString gender = "MALE".obs;
  RxString imageS3Url = "".obs;
  RxBool isNicknameTyped = false.obs;
  RxBool isUserInfoInit = false.obs;
  RxBool isInitImageUrl = false.obs;

  @override
  void onInit() async {
    await userInfoInit();
    super.onInit();
    if (gender.value == "MALE") {
      toggleSelection = [true, false].obs;
    } else {
      toggleSelection = [false, true].obs;
    }
    isUserInfoInit.value = true;
    update();
  }

  Future<void> userInfoInit() async {
    user = await userService.getCurrentUserInfo();
    print(
        'useruser init ${user.profileImageUrl}, ${user.birthYear}, ${user.gender}');
    nickname.value = user.nickname ?? "-";
    birthYear.value = user.birthYear ?? 2000;
    gender.value = user.gender ?? "MALE";
    imageS3Url.value = user.profileImageUrl ?? "";
    isInitImageUrl.value = true;
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

  void updateSelectedGender(int index) {
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

  void completeRegistration() async {
    int? statusCode = await userService.putUserInfo(
      gender: gender.value,
      birthYear: birthYear.value,
      nickname: nickname.value,
      profileImagePath: profileImage.value?.path,
    );
    if (statusCode == 200) {
      Get.offAllNamed('/main');
    }
  }
}
