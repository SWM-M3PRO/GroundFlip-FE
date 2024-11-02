import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../models/achievement/achievement.dart';
import '../models/announcement_info.dart';
import '../models/notification.dart' as n;
import '../screens/achievement_info_screen.dart';
import '../screens/announcement_screen.dart';
import '../service/achievement_service.dart';
import '../service/announcement_service.dart';
import '../service/notification_service.dart';
import '../utils/user_manager.dart';

class NotificationController extends GetxController {
  final AchievementService achievementService = AchievementService();
  final AnnouncementService announcementService = AnnouncementService();
  final NotificationService notificationService = NotificationService();

  var selectedCategory = 0.obs;
  var notifications = <n.Notification>[].obs;
  var filteredNotifications = <n.Notification>[].obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await loadNotifications();
    _filterNotifications();
    ever(selectedCategory, (_) => _filterNotifications());
  }

  @override
  onReady() {
    print('hello');
  }

  Future<void> loadNotifications() async {
    List<n.Notification> userNotifications =
        await notificationService.getNotifications(UserManager().userId!);
    notifications.addAll(userNotifications);
  }

  void _filterNotifications() {
    if (selectedCategory.value == 0) {
      filteredNotifications.assignAll(notifications);
    } else {
      filteredNotifications.assignAll(
        notifications.where((notification) =>
            notification.categoryId == selectedCategory.value),
      );
    }
  }

  void updateCategory(int category) {
    selectedCategory.value = category;
  }

  Future<void> moveToContents(int index) async {
    n.Notification notification = filteredNotifications[index];
    notificationService.markAsRead(notification.notificationId);
    if (notification.categoryId == 1) {
      AnnouncementInfo announcementInfo = await announcementService
          .getAnnouncementContent(notification.contentId!);
      Get.to(
        AnnouncementScreen(
          title: announcementInfo.title,
          date: announcementInfo.date,
          content: announcementInfo.content,
        ),
      );
    } else if (notification.categoryId == 2) {
      Get.dialog(
        AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16), // 원하는 radius 값으로 설정
          ),
          backgroundColor: AppColors.backgroundSecondary,
          title: Center(
            child: Text(
              notification.contents == null ? "알림" : notification.title,
              style: TextStyles.fs20w600cTextPrimary,
            ),
          ),
          content: Text(
            notification.contents == null
                ? notification.title
                : notification.contents!,
            style: TextStyles.fs17w400cTextPrimary,
          ),
          actions: [
            Center(
              child: TextButton(
                onPressed: () {
                  Get.back();
                },
                child: Text(
                  "확인",
                  style: TextStyles.fs14w500cPrimary,
                ),
              ),
            ),
          ],
        ),
      );
    } else if (notification.categoryId == 3) {
      Achievement achievement = await achievementService.getAchievementInfo(
        UserManager().getUserId()!,
        notification.contentId!,
      );
      Get.to(AchievementInfoScreen(achievement: achievement));
    }
    markAsRead(index);
  }

  void markAsRead(int index) {
    if (!filteredNotifications[index].isRead) {
      filteredNotifications[index].isRead = true;
      filteredNotifications.refresh();
    }
  }
}
