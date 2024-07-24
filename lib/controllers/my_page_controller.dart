import 'package:get/get.dart';

import '../models/user.dart';
import '../models/user_pixel_count.dart';
import '../service/user_service.dart';

class MyPageController extends GetxController {
  final UserService userService = UserService();
  final Rx<User> currentUserInfo = User().obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    User userInfo = await userService.getCurrentUserInfo();
    currentUserInfo.value = userInfo;
    await _updatePixelCount();
  }

  _updatePixelCount() async {
    UserPixelCount currentUserPixelCount =
        await userService.getUserPixelCount();
    currentPixelCount.value = currentUserPixelCount.currentPixelCount!;
    accumulatePixelCount.value = currentUserPixelCount.accumulatePixelCount!;
  }

  getProfileImageURL() {
    return currentUserInfo.value.profileImageUrl;
  }

  String getCurrentUserNickname() {
    return currentUserInfo.value.nickname ?? "-";
  }

  String? getCurrentUserCommunityName() {
    return currentUserInfo.value.communityName;
  }
}
