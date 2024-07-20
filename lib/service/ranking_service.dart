import 'package:dio/dio.dart';

import '../models/ranking.dart';
import '../utils/dio_service.dart';

class RankingService {
  static final RankingService _instance = RankingService._internal();
  final Dio dio = DioService().getDio();

  RankingService._internal();

  factory RankingService() {
    return _instance;
  }

  getAllUserRanking() async {
    var response = await dio.get('/ranking/user');

    return Ranking.listFromJson(response.data['data']);
  }

  getUserRanking(int userId) async {
    var response = await dio.get('/ranking/user/${userId.toString()}');

    return Ranking.fromJson(response.data['data']);
  }
}
