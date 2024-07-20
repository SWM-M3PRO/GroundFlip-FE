import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../controllers/navigation_controller.dart';

class CustomBottomNavigationBar extends GetView<NavigationController> {
  const CustomBottomNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: controller.selectedIndex.value,
        onTap: controller.changeIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.map), label: "지도"),
          BottomNavigationBarItem(icon: Icon(Icons.leaderboard), label: "랭킹"),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: "그룹"),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: "마이",
          ),
        ],
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        backgroundColor: AppColors.navigationBarColor,
      ),
    );
  }
}
