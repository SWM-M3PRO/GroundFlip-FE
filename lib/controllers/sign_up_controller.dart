import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../service/user_service.dart';
import '../utils/secure_storage.dart';

class SignUpController extends GetxController {
  final UserService userService = UserService();
  final ImagePicker picker = ImagePicker();
  final SecureStorage secureStorage = SecureStorage();

  var profileImage = Rxn<XFile>();

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
      await secureStorage.writeSignupStatus("true");
      Get.offAllNamed('/main');
    }
  }
}
