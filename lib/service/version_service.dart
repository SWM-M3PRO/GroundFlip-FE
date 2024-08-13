import 'package:dio/dio.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/version_response.dart';
import '../utils/dio_service.dart';

class VersionService {
  static final VersionService _instance = VersionService._internal();

  VersionService._internal();

  factory VersionService() {
    return _instance;
  }

  final Dio dio = DioService().getDio();

  Future<VersionResponse> getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    var response = await dio.get('/version', queryParameters: {"currentVersion":currentVersion});
    VersionResponse versionResponse = VersionResponse.fromJson(response.data['data']);
    return versionResponse;
  }
}
