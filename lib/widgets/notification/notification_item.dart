import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../controllers/notification_controller.dart';
import '../../models/notification.dart' as n;
import '../../screens/announcement_screen.dart';

class NotificationItem extends StatelessWidget {
  final n.Notification notification;
  final int index;
  final NotificationController controller = Get.find<NotificationController>();

  NotificationItem({
    super.key,
    required this.notification,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          borderRadius: BorderRadius.all(Radius.circular(16)),
          onTap: () {
            if (notification.categoryId == 1) {
              Get.to(AnnouncementScreen(
                  title: '버전 1.0.2 알림', date: DateTime.now(), content: '# 안녕'));
            }
            if (!notification.isRead) {
              controller.markAsRead(index);
            }
          },
          child: Stack(
            children: [
              Ink(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(16)),
                  color: AppColors.backgroundSecondary,
                ),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      notification.category,
                                      style: TextStyle(
                                        color: AppColors.textSecondary,
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    if (!notification.isRead)
                                      Container(
                                        width: 5,
                                        height: 5,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary, // 초록색 점
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                  ],
                                ),
                                Text(
                                  DateFormat('yyyy.MM.dd')
                                      .format(notification.date),
                                  style: TextStyle(
                                    color: AppColors.textSecondary,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              notification.contents,
                              style: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 17,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
  }
}
