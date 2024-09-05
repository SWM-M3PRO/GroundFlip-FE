import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/community_screen.dart';
import '../screens/map_screen.dart';
import '../screens/my_page_screen.dart';
import '../screens/no_community_screen.dart';
import '../screens/ranking_screen.dart';
import '../widgets/common/app_bar.dart';
import 'map_controller.dart';
import 'my_page_controller.dart';
import 'ranking_controller.dart';

class NavigationController extends GetxController {
  final RankingController rankingController = Get.find<RankingController>();
  final MapController mapController = Get.find<MapController>();
  final RxInt selectedIndex = 0.obs;

  static List<Widget> appBars = <Widget>[
    const MapAppBar(),
    const RankingAppBar(),
    const GroupAppBar(),
    const MyPageAppBar(),
  ];

  void changeIndex(int index) {
    if (selectedIndex.value != 1 && index == 1) {
      rankingController.onVisible();
    }
    if (selectedIndex.value == 0 && index != 0) {
      mapController.onBottomBarHidden();
    }
    selectedIndex(index);

    FirebaseAnalytics analytics = FirebaseAnalytics.instance;
    switch (index) {
      case 0:
        analytics.logScreenView(screenName: "map_screen");
        break;
      case 1:
        analytics.logScreenView(screenName: "ranking_screen");
        break;
      case 3:
        analytics.logScreenView(screenName: "mypage_screen");
        break;
    }
  }

  Widget getCurrentPage() {
    MyPageController myPageController = Get.find<MyPageController>();
    switch (selectedIndex.value) {
      case 0:
        return MapScreen();
      case 1:
        return RankingScreen();
      case 2:
        if (myPageController.currentUserInfo.value.communityId == null) {
          return const NoCommunityScreen();
        } else {
          return CommunityScreen(
            groupId: myPageController.currentUserInfo.value.communityId!,
            isTap: true,
          );
        }
      case 3:
        return MyPageScreen();
      default:
        return Container();
    }
  }

  Widget getCurrentAppBar() {
    return appBars[selectedIndex.value];
  }
}
