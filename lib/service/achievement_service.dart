import 'package:dio/dio.dart';

import '../models/achievement/user_achievements.dart';
import '../utils/dio_service.dart';
import '../utils/secure_storage.dart';

class AchievementService {
  static final AchievementService _instance = AchievementService._internal();
  final SecureStorage secureStorage = SecureStorage();
  final Dio dio = DioService().getDio();

  AchievementService._internal();

  factory AchievementService() {
    return _instance;
  }

  Future<UserAchievements> getUserAchievements(int userId, int? count) async {
    var response = await dio.get(
      '/users/$userId',
      queryParameters: {"user-id": userId, 'count': count},
    );
    return UserAchievements.fromJson(response.data['data']);
  }
}
