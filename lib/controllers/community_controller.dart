import 'package:get/get.dart';

import '../models/community.dart';
import '../models/ranking.dart';
import '../service/community_service.dart';

class CommunityController extends GetxController {
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
  final RxBool isJoin = true.obs;
  final RxBool isLoading = true.obs;

  final RxList members = [
    Ranking(userId: 1, rank: 1, currentPixelCount: 123, nickname: "test1"),
    Ranking(userId: 1, rank: 2, currentPixelCount: 123, nickname: "test2"),
    Ranking(userId: 1, rank: 3, currentPixelCount: 123, nickname: "test3"),
    Ranking(userId: 1, rank: 4, currentPixelCount: 123, nickname: "test4"),
    Ranking(userId: 1, rank: 5, currentPixelCount: 123, nickname: "test5"),
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
}
