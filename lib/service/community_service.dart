import 'package:dio/dio.dart';

import '../models/community.dart';
import '../models/ranking.dart';
import '../models/search_community_response.dart';
import '../utils/dio_service.dart';

class CommunityService {
  static final CommunityService _instance = CommunityService._internal();
  final Dio dio = DioService().getDio();

  CommunityService._internal();

  factory CommunityService() {
    return _instance;
  }

  Future<Community> getCommunityInfo(int communityId) async {
    var response = await dio.get('/communities/$communityId');
    return Community.fromJson(response.data['data']);
  }

  Future<List<SearchCommunityResponse>> getSearchCommunities({
    required String searchKeyword,
  }) async {
    var response = await dio.get(
      '/communities',
      queryParameters: {'searchKeyword': searchKeyword},
    );
    return SearchCommunityResponse.listFromJson(response.data['data']);
  }

  Future<List<Ranking>> getMembers(int communityId) async {
    var response = await dio.get(
      '/community/{communityId}/members',
    );

    return Ranking.listFromJsonUser(response.data['data']);
  }

  Future<int> getCommunityPixelCount(int? communityId) async {
    if (communityId == null) {
      return 0;
    }
    var response = await dio.get(
      '/pixels/community/count',
      queryParameters: {"community-id": communityId},
    );
    return response.data['data']['currentPixelCount'];
  }
}
