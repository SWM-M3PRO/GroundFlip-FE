import 'package:dio/dio.dart';

import '../models/achievement/achievement.dart';
import '../models/achievement/achievement_category.dart';
import '../models/achievement/achievements_by_category.dart';
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
      '/achievements/user',
      queryParameters: {"user-id": userId, 'count': count},
    );
    return UserAchievements.fromJson(response.data['data']);
  }

  Future<Achievement> getAchievementInfo(int userId, int achievementId) async {
    var response = await dio.get(
      '/achievements/$achievementId',
      queryParameters: {"user-id": userId},
    );
    return Achievement.fromJson(response.data['data']);
  }

  Future<List<AchievementCategory>> getCategories() async {
    var response = await dio.get(
      '/achievements/category',
    );
    return AchievementCategory.listFromJson(response.data['data']);
  }

  Future<AchievementsByCategory> getAchievementsByCategory(
      int userId, int categoryId) async {
    var response = await dio.get(
      '/achievements/category/$categoryId',
      queryParameters: {"user-id": userId},
    );
    return AchievementsByCategory.fromJson(response.data['data']);
  }
}
