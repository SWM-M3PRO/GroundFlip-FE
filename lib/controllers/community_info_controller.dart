import 'package:get/get.dart';

import '../enums/ranking_kind.dart';
import '../models/community.dart';
import '../models/ranking.dart';
import '../service/community_service.dart';
import 'community_controller.dart';
import 'my_page_controller.dart';

class CommunityInfoController extends GetxController {
  final CommunityService communityService = CommunityService();
  final RxString name = "".obs;
  final RxString imageUrl = "".obs;
  final RxInt memberCount = 0.obs;
  final RxInt communityColor = 0.obs;
  final RxInt communityRanking = 0.obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;
  final RxInt maxPixelCount = 0.obs;
  final RxInt maxRanking = 0.obs;
  final RxBool isLoading = true.obs;

  final RxList members = [
    Ranking(
      id: 1,
      rank: 1,
      currentPixelCount: 123,
      name: "test1",
      kind: RankingKind.community,
    ),
    Ranking(
      id: 1,
      rank: 2,
      currentPixelCount: 123,
      name: "test2",
      kind: RankingKind.community,
    ),
    Ranking(
      id: 1,
      rank: 3,
      currentPixelCount: 123,
      name: "test3",
      kind: RankingKind.community,
    ),
    Ranking(
      id: 1,
      rank: 4,
      currentPixelCount: 123,
      name: "test4",
      kind: RankingKind.community,
    ),
    Ranking(
      id: 1,
      rank: 5,
      currentPixelCount: 123,
      name: "test5",
      kind: RankingKind.community,
    ),
  ].obs;

  init(int communityId) async {
    Community community = await communityService.getCommunityInfo(communityId);
    name.value = community.name;
    imageUrl.value = community.backgroundImageUrl;
    memberCount.value = community.memberCount;
    communityColor.value = community.communityColor;
    communityRanking.value = community.communityRanking;
    currentPixelCount.value = community.currentPixelCount;
    accumulatePixelCount.value = community.accumulatePixelCount;
    maxPixelCount.value = community.maxPixelCount;
    maxRanking.value = community.maxRanking;
    isLoading.value = false;
  }

  signUpCommunity() async {
    // ToDo : 그룹 가입 구현
    MyPageController myPageController = Get.find<MyPageController>();
    CommunityController communityController = Get.find<CommunityController>();
    await myPageController.updateUserInfo();
    communityController.updateCommunityInfo();
  }
}
