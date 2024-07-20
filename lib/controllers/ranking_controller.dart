import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/ranking.dart';
import '../service/ranking_service.dart';
import '../utils/date_handler.dart';
import '../utils/user_manager.dart';

class RankingController extends GetxController {
  final RankingService rankingService = RankingService();
  final ScrollController scrollController = ScrollController();
  late final Rx<Ranking> myRanking;
  final RxInt selectedType = 0.obs;
  final RxList rankings = [].obs;

  final RxDouble t = 0.0.obs;
  final RxDouble myRankingInfoHeight = 40.0.obs;
  final RxDouble myRankingInfoPadding = 20.0.obs;

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(_onScroll);
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

  void _onScroll() {
    double t = (scrollController.offset / 200).clamp(0.0, 1.0);
    double t2 = (scrollController.offset / 100).clamp(0.0, 1.0);
    this.t.value = t;
    myRankingInfoHeight.value = 40 - 40 * t2;
    myRankingInfoPadding.value = 20 - 20 * t;
  }
}
