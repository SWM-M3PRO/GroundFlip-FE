import 'package:get/get.dart';

import '../models/ranking.dart';
import '../service/ranking_service.dart';
import '../utils/user_manager.dart';

class RankingController extends GetxController {
  final RankingService rankingService = RankingService();
  final RxInt selectedType = 0.obs;
  final RxList rankings = [].obs;
  late final Rx<Ranking> myRanking;

  @override
  void onInit() async {
    super.onInit();
    _initRanking();
  }

  _initRanking() async {
    List<Ranking> rankings = await rankingService.getAllUserRanking();
    Ranking myRanking =
        await rankingService.getUserRanking(UserManager().getUserId()!);
    this.rankings.assignAll(rankings);
    this.myRanking = myRanking.obs;
  }

  updateRanking() async {
    List<Ranking> rankings = await rankingService.getAllUserRanking();
    Ranking myRanking =
        await rankingService.getUserRanking(UserManager().getUserId()!);
    this.rankings.assignAll(rankings);
    this.rankings.add(Ranking(userId: 9, nickname: "test", rank: rankings.length, currentPixelCount: 5));
    this.myRanking.value = myRanking;
  }

  Ranking getMyRanking() {
    return myRanking.value;
  }

  getRankingsTop3() {
    if (rankings.length >= 3) {
      return rankings.sublist(0, 3);
    } else {
      return rankings.toList();
    }
  }

  getRankingsAll() {
    return rankings.sublist(3);
  }

  getSelectedType() {
    return selectedType.value;
  }

  updateSelectedType(int type) {
    selectedType.value = type;
  }
}
