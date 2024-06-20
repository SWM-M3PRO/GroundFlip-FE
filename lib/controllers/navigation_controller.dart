import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../screens/group_screen.dart';
import '../screens/map_screen.dart';
import '../screens/my_page_screen.dart';
import '../screens/ranking_screen.dart';

class NavigationController extends GetxController {
  final RxInt selectedIndex = 0.obs;
  static List<Widget> tabPages = <Widget>[
    const MapScreen(),
    const RankigScreen(),
    const GroupScreen(),
    const MyPageScreen(),
  ];

  void changeIndex(int index) {
    selectedIndex(index);
  }

  Widget getCurrentPage() {
    return tabPages[selectedIndex.value];
  }
}
