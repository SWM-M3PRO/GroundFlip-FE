import 'package:dio/dio.dart';

import '../models/permission.dart';
import '../utils/dio_service.dart';

class PermissionService {
  static final PermissionService _instance = PermissionService._internal();

  final Dio dio = DioService().getDio();

  PermissionService._internal();

  factory PermissionService() {
    return _instance;
  }

  Future<Permission> getPermission(int userId) async {
    var response = await dio.get('/permission/$userId');
    return Permission.fromJson(response.data['data']);
  }
}
