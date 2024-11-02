import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../screens/notification_screen.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // mapController.openFilterBottomSheet();
        Get.to(NotificationScreen());
      },
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(12)),
              color: AppColors.backgroundSecondary,
            ),
            padding: EdgeInsets.all(10),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
              size: 20, // 아이콘 크기
            ),
          ),
          // 안 읽은게 있는 경우만 표시 되게
          Positioned(
            top: 8,
            right: 8,
            child: Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(
                color: AppColors.primary, // 초록색 점
                shape: BoxShape.circle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
