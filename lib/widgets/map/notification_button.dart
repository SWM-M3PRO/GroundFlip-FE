import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/map_controller.dart';
import '../../screens/notification_screen.dart';

class NotificationButton extends StatelessWidget {
  const NotificationButton({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    return GestureDetector(
      onTap: () {
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
          Obx(() {
            if (mapController.isNotificationRead.value) {
              return Positioned(
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
              );
            } else {
              return SizedBox();
            }
          })
        ],
      ),
    );
  }
}
