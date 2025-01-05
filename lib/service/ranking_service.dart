import 'package:dio/dio.dart';

import '../enums/ranking_type.dart';
import '../models/ranking.dart';
import '../utils/dio_service.dart';

class RankingService {
  static final RankingService _instance = RankingService._internal();
  final Dio dio = DioService().getDio();

  RankingService._internal();

  factory RankingService() {
    return _instance;
  }

  getAllUserRanking(DateTime lookupDate, RankingType type) async {
    String path = '/ranking/user';
    if (type == RankingType.accumulate) {
      path = '/ranking/accumulate/user';
    }

    var response = await dio.get(
      path,
      queryParameters: {
        'lookup-date':
            '${lookupDate.year}-${lookupDate.month.toString().padLeft(2, '0')}-${lookupDate.day.toString().padLeft(2, '0')}',
      },
    );

    return Ranking.listFromJsonUser(response.data['data']);
  }

  getUserRanking(int userId, DateTime lookupDate, RankingType type) async {
    String path = '/ranking/user';
    if (type == RankingType.accumulate) {
      path = '/ranking/accumulate/user';
    }

    var response = await dio.get(
      '$path/${userId.toString()}',
      queryParameters: {
        'lookup-date':
            '${lookupDate.year}-${lookupDate.month.toString().padLeft(2, '0')}-${lookupDate.day.toString().padLeft(2, '0')}',
      },
    );

    return Ranking.fromJsonUser(response.data['data']);
  }

  getAllCommunityRanking(DateTime lookupDate) async {
    var response = await dio.get(
      '/ranking/community',
      queryParameters: {
        'lookup-date':
            '${lookupDate.year}-${lookupDate.month.toString().padLeft(2, '0')}-${lookupDate.day.toString().padLeft(2, '0')}',
      },
    );

    return Ranking.listFromJsonCommunity(response.data['data']);
  }

  getCommunityRanking(int? communityId, DateTime lookupDate) async {
    if (communityId == null) {
      return Ranking.fromJsonCommunity({
        "communityId": 1,
        "name": "가입한 그룹이 없습니다.",
        "rank": null,
        "profileImageUrl": null,
        "currentPixelCount": null,
      });
    }
    var response = await dio.get(
      '/ranking/community/${communityId.toString()}',
      queryParameters: {
        'lookup-date':
            '${lookupDate.year}-${lookupDate.month.toString().padLeft(2, '0')}-${lookupDate.day.toString().padLeft(2, '0')}',
      },
    );

    return Ranking.fromJsonCommunity(response.data['data']);
  }
}
