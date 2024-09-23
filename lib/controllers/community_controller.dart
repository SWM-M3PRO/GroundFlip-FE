import 'package:get/get.dart';

import '../models/community.dart';
import '../models/ranking.dart';
import '../service/community_service.dart';
import '../widgets/common/alert/alert.dart';
import '../widgets/community/signout_bottom_sheet.dart';
import 'my_page_controller.dart';

class CommunityController extends GetxController {
  final CommunityService communityService = CommunityService();
  final RxString name = "".obs;
  final RxString imageUrl = "".obs;
  final RxInt communityId = 0.obs;
  final RxInt memberCount = 0.obs;
  final RxInt communityColor = 0.obs;
  final RxInt communityRanking = 0.obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;
  final RxInt maxPixelCount = 0.obs;
  final RxInt maxRanking = 0.obs;
  final RxBool isJoin = true.obs;
  final RxBool isLoading = true.obs;

  final RxList members = [].obs;

  init() async {
    MyPageController myPageController = Get.find<MyPageController>();
    if (myPageController.currentUserInfo.value.communityId == null) {
      isJoin.value = false;
    } else {
      await updateCommunityInfo();
    }
  }

  updateCommunityInfoWithDelay() async {
    await Future.delayed(Duration(seconds: 1));
    await updateCommunityInfo();
  }

  updateCommunityInfo() async {
    isJoin.value = true;
    communityId.value =
        Get.find<MyPageController>().currentUserInfo.value.communityId!;
    Community community =
        await communityService.getCommunityInfo(communityId.value);
    name.value = community.name;
    imageUrl.value = community.backgroundImageUrl;
    memberCount.value = community.memberCount;
    communityColor.value = community.communityColor;
    communityRanking.value = community.communityRanking;
    currentPixelCount.value = community.currentPixelCount;
    accumulatePixelCount.value = community.accumulatePixelCount;
    maxPixelCount.value = community.maxPixelCount;
    maxRanking.value = community.maxRanking;
    await updateCommunityMember();
    isLoading.value = false;
  }

  updateCommunityMember() async {
    List<Ranking> members =
        await communityService.getMembers(communityId.value, 5);
    this.members.assignAll(members);
  }

  quitCommunity() {
    Get.bottomSheet(
      SignOutBottomSheet(
        name: name.value,
        profileImageUrl: imageUrl.value,
        onTap: signOut,
      ),
      isScrollControlled: true,
    );
  }

  signOut() async {
    try {
      await communityService.signOutCommunity(communityId.value);
      MyPageController myPageController = Get.find<MyPageController>();
      myPageController.updateUserInfo();
      isJoin.value = false;
      Get.back();
    } catch (e) {
      Get.dialog(
        Alert(
          title: '회원탈퇴에 실패했습니다!',
          content: '다시 시도 해주세요.',
          buttonText: '확인',
        ),
      );
    }
  }
}
