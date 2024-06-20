import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/navigation_controller.dart';
import '../widgets/naviagtion_bar.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
      bottomNavigationBar: const CustomBottomNavigationBar(),
    );
  }
}
