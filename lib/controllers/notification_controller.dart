import 'package:get/get.dart';

import '../models/notification.dart';

class NotificationController extends GetxController {
  var selectedCategory = 0.obs;
  var notifications = <Notification>[].obs;
  var filteredNotifications = <Notification>[].obs;

  @override
  void onInit() {
    super.onInit();
    // 예시 알림 데이터를 추가
    notifications.addAll([
      Notification(
        category: '공지사항',
        categoryId: 1,
        contents: '버전 1.0.2 알림',
        date: DateTime.now(),
        isRead: false,
      ),
      Notification(
        category: '공지사항',
        categoryId: 1,
        contents: '버전 1.0.2 알림',
        date: DateTime.now(),
        isRead: false,
      ),
      Notification(
        category: '알림',
        categoryId: 2,
        contents: '이벤트 당첨 안내',
        date: DateTime.now(),
        isRead: false,
      ),
      Notification(
        category: '업적',
        categoryId: 3,
        contents: '초급 탐험가 획득!',
        date: DateTime.now(),
        isRead: false,
      ),
    ]);
    _filterNotifications();
    ever(selectedCategory, (_) => _filterNotifications());
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

  void markAsRead(int index) {
    filteredNotifications[index].isRead = true;
    filteredNotifications.refresh();
  }
}
