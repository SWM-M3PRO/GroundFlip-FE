import 'package:dio/dio.dart';

import '../models/community.dart';
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
}