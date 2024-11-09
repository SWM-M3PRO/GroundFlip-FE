import 'package:dio/dio.dart';

import '../models/notification.dart' as n;
import '../utils/dio_service.dart';

class NotificationService {
  static final NotificationService _instance = NotificationService._internal();
  final Dio dio = DioService().getDio();

  NotificationService._internal();

  factory NotificationService() {
    return _instance;
  }

  getNotifications(int userId) async {
    var response = await dio.get(
      '/notifications',
      queryParameters: {"user-id": userId},
    );
    return n.Notification.listFromJson(response.data['data']);
  }

  markAsRead(int notificationId) async {
    await dio.patch('/notifications/$notificationId/read');
  }

  isUnreadNotification(int userId) async {
    var response = await dio.get(
      '/notifications/unread/check',
      queryParameters: {"user-id": userId},
    );
    return response.data['data'];
  }
}
