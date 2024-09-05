import 'package:get/get.dart';

import '../models/ranking.dart';

class CommunityController extends GetxController {
  final RxString name = "".obs;
  final RxString imageUrl = "".obs;

  final RxInt memberCount = 0.obs;
  final RxInt communityColor = 0.obs;
  final RxInt communityRanking = 0.obs;
  final RxInt currentPixelCount = 0.obs;
  final RxInt accumulatePixelCount = 0.obs;
  final RxInt maxPixelCount = 0.obs;
  final RxInt maxRankingCount = 0.obs;
  final RxBool isJoin = true.obs;

  final RxList members = [
    Ranking(userId: 1, rank: 1, currentPixelCount: 123, nickname: "test1"),
    Ranking(userId: 1, rank: 2, currentPixelCount: 123, nickname: "test2"),
    Ranking(userId: 1, rank: 3, currentPixelCount: 123, nickname: "test3"),
    Ranking(userId: 1, rank: 4, currentPixelCount: 123, nickname: "test4"),
    Ranking(userId: 1, rank: 5, currentPixelCount: 123, nickname: "test5"),
  ].obs;

  init(int groupId) {
    name.value = "세종대학교";
    imageUrl.value =
        "https://ground-flip-prod-storage-resized.s3.ap-northeast-2.amazonaws.com/resized-static/42166cf0-b557-42a1-a1fb-d04472ea0ac1%23%23%23622.jpg";
    memberCount.value = 3;
    communityColor.value = 0xFF0DF69E;
    communityRanking.value = 534;
    currentPixelCount.value = 124;
    accumulatePixelCount.value = 11394;
    maxPixelCount.value = 945;
    maxRankingCount.value = 53;
  }
}
