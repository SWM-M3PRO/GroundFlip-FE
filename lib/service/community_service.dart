import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/community.dart';
import '../models/ranking.dart';
import '../models/search_community_response.dart';
import '../utils/dio_service.dart';
import '../utils/user_manager.dart';

class CommunityService {
  static final CommunityService _instance = CommunityService._internal();
  final Dio dio = DioService().getDio();
  final UserManager userManager = UserManager();

  CommunityService._internal();

  factory CommunityService() {
    return _instance;
  }

  Future<Community> getCommunityInfo(int communityId) async {
    var response = await dio.get('/communities/$communityId');
    return Community.fromJson(response.data['data']);
  }

  Future<int?> signInCommunity(int communityId) async {
    int? userId = UserManager().getUserId();

    var response = await dio.post(
      '/communities/$communityId',
      data: {'userId': userId},
      options: Options(
        validateStatus: (status) {
          return status! == 200;
        },
      ),
    );

    return response.statusCode;
  }

  Future<int?> createCommunity({
    required String communityName,
    required int communityColor,
    String? password,
    required String profileImagePath,
  }) async {
    late String fileName;
    var communityInfoJson = jsonEncode(
      {
        'communityName': communityName,
        'communityColor': communityColor.toString(),
      },
    );

    var formData = FormData();

    formData.files.add(
      MapEntry(
        'communityInfoRequest',
        MultipartFile.fromString(
          communityInfoJson,
          contentType: DioMediaType.parse('application/json'),
        ),
      ),
    );

    if (profileImagePath != null) {
      fileName = profileImagePath.split('/').last;
      formData.files.add(
        MapEntry(
          'profileImage',
          await MultipartFile.fromFile(profileImagePath, filename: fileName),
        ),
      );
    }
    print('2222 ${formData}');
    var response = await dio.put(
      '/community',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );
    print(2222);

    return response.statusCode;
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

  Future<List<Ranking>> getMembers(int communityId, int count) async {
    var response = await dio.get(
      '/communities/$communityId/members?count=$count',
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

  signOutCommunity(int communityId) async {
    await dio.delete(
      '/communities/$communityId',
      data: {
        "userId": UserManager().getUserId(),
      },
    );
  }
}
