import 'package:get/get.dart';

import '../models/user.dart';
import '../service/user_service.dart';

class MyPageController extends GetxController {
  final UserService userService = UserService();
  final Rx<User> currentUserInfo = User().obs;

  @override
  Future<void> onInit() async {
    User userInfo = await userService.getCurrentUserInfo();
    currentUserInfo.value = userInfo;
    super.onInit();
  }

  getProfileImageURL() {
    return currentUserInfo.value.profileImageUrl;
  }

  getCurrentUserNickname() {
    return currentUserInfo.value.nickname;
  }

  getCurrentUserCommunityName() {
    return currentUserInfo.value.communityName ?? "-";
  }
}
