import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/group_screen.dart';
import '../screens/map_screen.dart';
import '../screens/my_page_screen.dart';
import '../screens/ranking_screen.dart';
import '../widgets/app_bar.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  static List<Widget> tabPages = <Widget>[
    const MapScreen(),
    const RankigScreen(),
    const GroupScreen(),
    const MyPageScreen(),
  ];
  static List<Widget> appBars = <Widget>[
    const MapAppBar(),
    const RankingAppBar(),
    const GroupAppBar(),
    const MyPageAppBar(),
  ];

  void changeIndex(int index) {
    selectedIndex(index);
  }

  Widget getCurrentPage() {
    return tabPages[selectedIndex.value];
  }

  Widget getCurrentAppBar() {
    return appBars[selectedIndex.value];
  }
}
