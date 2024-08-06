import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/map_screen.dart';
import '../screens/my_page_screen.dart';
import '../screens/ranking_screen.dart';
import '../widgets/common/app_bar.dart';
import 'map_controller.dart';
import 'ranking_controller.dart';

class NavigationController extends GetxController {
  final RankingController rankingController = Get.find<RankingController>();
  final MapController mapController = Get.find<MapController>();
  final RxInt selectedIndex = 0.obs;
  static List<Widget> tabPages = <Widget>[
    const MapScreen(),
    const RankingScreen(),
    // const GroupScreen(),
    const MyPageScreen(),
  ];
  static List<Widget> appBars = <Widget>[
    const MapAppBar(),
    const RankingAppBar(),
    // const GroupAppBar(),
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
  }

  Widget getCurrentPage() {
    return tabPages[selectedIndex.value];
  }

  Widget getCurrentAppBar() {
    return appBars[selectedIndex.value];
  }
}
