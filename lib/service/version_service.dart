import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

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
    var response = await dio.get('/version');
    return VersionResponse.fromJson(response.data['data']);
  }
}
