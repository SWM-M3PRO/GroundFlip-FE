import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_page_controller.dart';
import '../controllers/navigation_controller.dart';
import '../controllers/ranking_controller.dart';
import '../widgets/common/naviagtion_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(MyPageController());
    Get.put(RankingController());
    final NavigationController navigationController =
        Get.put(NavigationController());

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: Obx(() => navigationController.getCurrentAppBar()),
      ),
      body: Obx(
        () => SafeArea(child: navigationController.getCurrentPage()),
      ),
      backgroundColor: Colors.black,
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
