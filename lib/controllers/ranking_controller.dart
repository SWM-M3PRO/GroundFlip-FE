import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../models/ranking.dart';
import '../models/user_pixel_count.dart';
import '../service/ranking_service.dart';
import '../service/user_service.dart';
import '../utils/date_handler.dart';
import '../utils/user_manager.dart';
import '../widgets/ranking/ranking_bottom_sheet.dart';
import 'my_page_controller.dart';

class RankingController extends GetxController {
  final RankingService rankingService = RankingService();
  final UserService userService = UserService();
  final ScrollController scrollController = ScrollController();

  final RxBool isLoading = true.obs;

  late Rx<Ranking> myRanking;
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

  onVisible() {
    updateRankingWithDelay(0);
  }

  _initRanking() async {
    isLoading.value = true;
    List<Ranking> rankings =
        await rankingService.getAllUserRanking(selectedWeek);
    Ranking myRanking = await rankingService.getUserRanking(
      UserManager().getUserId()!,
      selectedWeek,
    );
    this.rankings.assignAll(rankings);
    this.myRanking = myRanking.obs;
    isLoading.value = false;
  }

  updateRankingWithDelay(int seconds) async {
    await Future.delayed(Duration(seconds: seconds));
    await updateRanking();
  }

  Future<void> updateRanking() async {
    List<Ranking> rankings;
    Ranking myRanking;
    if (selectedType.value == 0) {
      rankings = await rankingService.getAllUserRanking(selectedWeek);
      myRanking = await rankingService.getUserRanking(
        UserManager().getUserId()!,
        selectedWeek,
      );
    } else {
      int? communityId =
          Get.find<MyPageController>().currentUserInfo.value.communityId;
      rankings = await rankingService.getAllCommunityRanking(selectedWeek);
      myRanking = await rankingService.getCommunityRanking(
        communityId,
        selectedWeek,
      );
    }

    this.rankings.assignAll(rankings);
    this.myRanking.value = myRanking;
  }

  _updateRankingWithProgressIndicator() async {
    isLoading.value = true;
    await updateRankingWithDelay(1);
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
    if (rankings.length >= 3) {
      return rankings.sublist(3);
    } else {
      return [];
    }
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

  void openRankingBottomSheet(Ranking ranking) async {
    FirebaseAnalytics.instance.logEvent(name: "ranking_element_click");
    UserPixelCount pixelCount =
        await userService.getAnotherUserPixelCount(null, ranking.id);
    Get.bottomSheet(
      RankingBottomSheet(
        userId: ranking.id,
        nickname: ranking.name!,
        profileImageUrl: ranking.profileImageUrl,
        currentPixelCount: pixelCount.currentPixelCount!,
        accumulatePixelCount: pixelCount.accumulatePixelCount!,
      ),
      backgroundColor: AppColors.background,
      enterBottomSheetDuration: Duration(milliseconds: 100),
      exitBottomSheetDuration: Duration(milliseconds: 100),
    );
  }
}
