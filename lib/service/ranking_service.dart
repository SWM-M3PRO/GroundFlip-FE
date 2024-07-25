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

  getAllUserRanking(DateTime lookupDate) async {
    var response = await dio.get(
      '/ranking/user',
      queryParameters: {
        'lookup-date':
            '${lookupDate.year}-${lookupDate.month.toString().padLeft(2, '0')}-${lookupDate.day.toString().padLeft(2, '0')}',
      },
    );

    return Ranking.listFromJson(response.data['data']);
  }

  getUserRanking(int userId, DateTime lookupDate) async {
    var response = await dio.get(
      '/ranking/user/${userId.toString()}',
      queryParameters: {
        'lookup-date':
            '${lookupDate.year}-${lookupDate.month.toString().padLeft(2, '0')}-${lookupDate.day.toString().padLeft(2, '0')}',
      },
    );

    return Ranking.fromJson(response.data['data']);
  }
}
