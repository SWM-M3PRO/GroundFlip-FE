import 'package:get/get.dart';

import '../models/user.dart';
import '../models/user_pixel_log.dart';
import '../service/user_service.dart';

class MyPageController extends GetxController {
  final UserService userService = UserService();
  final Rx<User> currentUserInfo = User().obs;
  final Rx<UserPixelLog> userPixelLog = UserPixelLog().obs;

  @override
  Future<void> onInit() async {
    User userInfo = await userService.getCurrentUserInfo();
    UserPixelLog userPixelLogInfo = await userService.getUserPixelLog();
    currentUserInfo.value = userInfo;
    userPixelLog.value = userPixelLogInfo;
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

  getCurrentUserPixel(){
    return userPixelLog.value.currentPixelCount;
  }

  getAccumulateUserPixel(){
    return userPixelLog.value.accumulatePixelCount;
  }
}
