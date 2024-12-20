import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/map_controller.dart';
import '../controllers/notification_controller.dart';
import '../widgets/common/app_bar.dart';
import '../widgets/notification/category_button.dart';
import '../widgets/notification/notification_item.dart';

class NotificationScreen extends StatelessWidget {
  NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    NotificationController notificationController =
        Get.put(NotificationController());
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: AppBarTitle(
          title: '알림',
        ),
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              final mapController = Get.find<MapController>();
              mapController.loadNotificationStatus();
              Get.back();
            },
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 0, 10, 10),
        child: Column(
          children: [
            Container(
              color: AppColors.background,
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: Row(
                children: [
                  CategoryButton(label: '전체', category: 0),
                  SizedBox(width: 10),
                  CategoryButton(label: '공지사항', category: 1),
                  SizedBox(width: 10),
                  CategoryButton(label: '알림', category: 2),
                  SizedBox(width: 10),
                  CategoryButton(label: '업적', category: 3),
                ],
              ),
            ),
            Expanded(
              child: Obx(() {
                return ListView.builder(
                  itemCount:
                      notificationController.filteredNotifications.length + 1,
                  itemBuilder: (context, index) {
                    if (index ==
                        notificationController.filteredNotifications.length) {
                      return Center(
                        child: Text(
                          "최근 14일 동안의 알림만 표시됩니다.",
                          style: TextStyles.fs14w400cTextSecondary,
                        ),
                      );
                    }
                    final notification =
                        notificationController.filteredNotifications[index];

                    return NotificationItem(
                      notification: notification,
                      index: index,
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
