import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/ranking.dart';
import '../service/ranking_service.dart';
import '../utils/date_handler.dart';
import '../utils/user_manager.dart';

class RankingController extends GetxController {
  final RankingService rankingService = RankingService();
  final ScrollController scrollController = ScrollController();

  final RxBool isLoading = true.obs;

  late final Rx<Ranking> myRanking;
  final RxInt selectedType = 0.obs;
  final RxList rankings = [].obs;

  final RxDouble t = 0.0.obs;
  final RxDouble myRankingInfoHeight = 40.0.obs;
  final RxDouble myRankingInfoPadding = 20.0.obs;

  final RxString selectedWeekString =
      DateHandler.convertDateToWeekFormat(DateHandler.getStartOfThisWeek()).obs;
  DateTime selectedWeek = DateHandler.getStartOfThisWeek();
  int selectedWeekNumber = 0;

  @override
  void onInit() async {
    super.onInit();
    scrollController.addListener(_onScroll);
    _initRanking();
  }

  _initRanking() async {
    isLoading.value = true;
    List<Ranking> rankings = await rankingService.getAllUserRanking();
    Ranking myRanking =
        await rankingService.getUserRanking(UserManager().getUserId()!);
    this.rankings.assignAll(rankings);
    this.myRanking = myRanking.obs;
    isLoading.value = false;
  }

  updateRanking() async {
    List<Ranking> rankings = await rankingService.getAllUserRanking();
    Ranking myRanking =
        await rankingService.getUserRanking(UserManager().getUserId()!);
    await Future.delayed(Duration(seconds: 1));
    this.rankings.assignAll(rankings);
    this.myRanking.value = myRanking;
  }

  _updateRankingWithProgressIndicator() async {
    isLoading.value = true;
    await updateRanking();
    isLoading.value = false;
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

  selectWeek(int selectedWeekNumber, DateTime selectedWeek) {
    this.selectedWeek = selectedWeek;
    this.selectedWeekNumber = selectedWeekNumber;
    selectedWeekString.value =
        DateHandler.convertDateToWeekFormat(selectedWeek);
    _updateRankingWithProgressIndicator();
  }

  getSelectedType() {
    return selectedType.value;
  }

  updateSelectedType(int type) {
    selectedType.value = type;
    _updateRankingWithProgressIndicator();
  }

  void _onScroll() {
    double t = (scrollController.offset / 200).clamp(0.0, 1.0);
    double t2 = (scrollController.offset / 100).clamp(0.0, 1.0);
    this.t.value = t;
    myRankingInfoHeight.value = 40 - 40 * t2;
    myRankingInfoPadding.value = 20 - 20 * t;
  }
}
