import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../models/version_response.dart';

class VersionService {
  static final VersionService _instance = VersionService._internal();
  final String baseUrl = dotenv.env['BASE_URL']!;

  VersionService._internal();

  factory VersionService() {
    return _instance;
  }

  Future<VersionResponse> getVersion() async {
    final dio = Dio();
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String currentVersion = packageInfo.version;
    var response = await dio.get(
      '$baseUrl/version',
      queryParameters: {"currentVersion": currentVersion},
    );
    VersionResponse versionResponse =
        VersionResponse.fromJson(response.data['data']);
    return versionResponse;
  }
}
