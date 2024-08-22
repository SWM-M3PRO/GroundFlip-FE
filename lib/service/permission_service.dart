import 'package:dio/dio.dart';

import '../models/permission.dart';
import '../utils/dio_service.dart';
import '../utils/user_manager.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();

  final Dio dio = DioService().getDio();

  PermissionService._internal();

  factory PermissionService() {
    return _instance;
  }

  Future<Permission> getPermission() async {
    int? userId = UserManager().getUserId();
    var response = await dio.get('/permission/$userId');
    return Permission.fromJson(response.data['data']);
  }

  Future<void> updateServiceNotification(bool isEnabled) async {
    int? userId = UserManager().getUserId();
    await dio.put(
      '/permission/service-notification',
      data: {
        "userId": userId,
        "isEnabled": isEnabled,
      },
    );
  }

  Future<void> updateMarketingNotification(bool isEnabled) async {
    int? userId = UserManager().getUserId();
    await dio.put(
      '/permission/marketing-notification',
      data: {
        "userId": userId,
        "isEnabled": isEnabled,
      },
    );
  }
}
