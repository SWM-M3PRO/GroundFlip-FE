import 'package:get/get.dart';

import '../models/user.dart';
import '../models/user_pixel_count.dart';
import '../service/user_service.dart';

class MyPageController extends GetxController {
  final UserService userService = UserService();
  final Rx<User> currentUserInfo = User().obs;
  final Rx<UserPixelCount> userPixelCount = UserPixelCount().obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    User userInfo = await userService.getCurrentUserInfo();
    UserPixelCount userPixelLogInfo = await userService.getUserPixelCount();
    currentUserInfo.value = userInfo;
    userPixelCount.value = userPixelLogInfo;
  }

  getProfileImageURL() {
    return currentUserInfo.value.profileImageUrl;
  }

  String getCurrentUserNickname() {
    return currentUserInfo.value.nickname ?? "-";
  }

  String getCurrentUserCommunityName() {
    return currentUserInfo.value.communityName ?? "-";
  }

  int getCurrentUserPixel(){
    return userPixelCount.value.currentPixelCount ?? 0;
  }

  int getAccumulateUserPixel(){
    return userPixelCount.value.accumulatePixelCount ?? 0;
  }
}
