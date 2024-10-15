import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../models/community.dart';
import '../models/ranking.dart';
import '../service/community_service.dart';
import '../widgets/community/community_signin_bottomsheet.dart';
import 'bottom_sheet_controller.dart';

class CommunityInfoController extends GetxController {
  final CommunityService communityService = CommunityService();
  final RxString name = "".obs;
  final RxString imageUrl = "".obs;
  final RxString password = "".obs;
  final RxInt communityId = 0.obs;
  final RxInt memberCount = 0.obs;
  final RxInt communityColor = 0.obs;
  final RxInt communityRanking = 0.obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;
  final RxInt maxPixelCount = 0.obs;
  final RxInt maxRanking = 0.obs;
  final RxBool isLoading = true.obs;

  final RxList members = [].obs;

  final BottomSheetController bottomSheetController =
      Get.find<BottomSheetController>();

  init(int communityId) async {
    Community community = await communityService.getCommunityInfo(communityId);
    name.value = community.name;
    imageUrl.value = community.backgroundImageUrl;
    this.communityId.value = communityId;
    memberCount.value = community.memberCount;
    communityColor.value = community.communityColor;
    communityRanking.value = community.communityRanking;
    currentPixelCount.value = community.currentPixelCount;
    accumulatePixelCount.value = community.accumulatePixelCount;
    maxPixelCount.value = community.maxPixelCount;
    maxRanking.value = community.maxRanking;
    List<Ranking> members = await communityService.getMembers(communityId, 5);
    this.members.assignAll(members);
    isLoading.value = false;
    password.value = community.password;
  }

  signUpCommunity() async {
    bottomSheetController.minimize();
    Get.bottomSheet(
      CommunitySignInBottomSheet(
        communityName: name.value,
        communityImageUrl: imageUrl.value,
        communityId: communityId.value,
      ),
      backgroundColor: AppColors.backgroundSecondary,
      enterBottomSheetDuration: Duration(milliseconds: 100),
      exitBottomSheetDuration: Duration(milliseconds: 100),
      isScrollControlled: true,
    );
  }

  void signInBottomSheet() {}
}
