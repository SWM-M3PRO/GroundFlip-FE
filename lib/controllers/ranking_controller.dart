import 'package:get/get.dart';

import '../models/ranking.dart';
import '../service/ranking_service.dart';

class RankingController extends GetxController {
  final RankingService rankingService = RankingService();
  final RxInt selectedType = 0.obs;
  final RxList rankings = [].obs;

  @override
  void onInit() async {
    super.onInit();
    List<Ranking> rankings = await rankingService.getAllUserRanking();
    this.rankings.assignAll(rankings);
  }

  List getRankingsTop3() {
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
