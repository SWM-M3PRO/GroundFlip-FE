import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../models/reissue_response.dart';
import 'secure_storage.dart';

class DioService {
  static final DioService _dioServices = DioService._internal();
  static final String baseUrl = dotenv.env['BASE_URL']!;
  final SecureStorage secureStorage = SecureStorage();

  factory DioService() => _dioServices;

  static Dio _dio = Dio();

  DioService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000),
    );
    _dio = Dio(options);
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await secureStorage.readAccessToken();
          options.headers.addAll({
            'Authorization': 'Bearer $accessToken',
          });
          logRequest(options);
          return handler.next(options);
        },
        onResponse: (Response response, ResponseInterceptorHandler handler) {
          logResponse(response);
          return handler.next(response);
        },
        onError: (
          DioException dioException,
          ErrorInterceptorHandler errorInterceptorHandler,
        ) async {
          if (dioException.response?.statusCode == HttpStatus.unauthorized) {
            final refreshToken = await secureStorage.readRefreshToken();
            final dio = Dio();
            var response = await dio.post("$baseUrl/auth/reissue",
                data: {"refreshToken": refreshToken});
            ReissueResponse reissueResponse =
                ReissueResponse.fromJson(response.data["data"]);

            await secureStorage.writeAccessToken(reissueResponse.accessToken);
            await secureStorage.writeRefreshToken(reissueResponse.refreshToken);

            final options = dioException.requestOptions;
            options.headers.addAll({
              'Authorization': 'Bearer ${reissueResponse.accessToken}',
            });
            var response2 = await _dio.fetch(options);
            errorInterceptorHandler.resolve(response2);
            print('-------------refresh---------------');
            // AuthService().logout();
            // Get.offAllNamed('/login');
          } else {
            logError(dioException);
            return errorInterceptorHandler.next(dioException);
          }
        },
      ),
    );
  }

  Dio getDio() {
    return _dio;
  }

  logRequest(options) {
    if (kDebugMode) {
      var requestTimestamp = DateTime.now();
      options.extra['requestTimestamp'] = requestTimestamp;
      debugPrint(
        '---------------[Request - $requestTimestamp]---------------\n'
        '[Method] : ${options.method}\n'
        '[Path] : ${options.path}\n'
        '[Headers] : ${options.headers}\n'
        '[Query Parameters] : ${options.queryParameters}\n'
        '[Body] : ${options.data}',
      );
    }
  }

  void logResponse(Response<dynamic> response) {
    if (kDebugMode) {
      var requestTimestamp = response.requestOptions.extra['requestTimestamp'];
      var requestEndTime = DateTime.now();
      var requestDuration = requestEndTime.difference(requestTimestamp);
      debugPrint(
        '\n---------------[Response - $requestTimestamp]---------------\n'
        '[Status Code] : ${response.statusCode}\n'
        '[Data] : ${response.data}\n'
        '[Duration] : ${requestDuration.inMilliseconds} ms\n'
        '----------------------------------------------\n',
      );
    }
  }

  void logError(DioException dioException) {
    debugPrint(
      '\n---------------[Response - ERROR]---------------\n'
      '[Status Code] : ${dioException.response?.statusCode}\n'
      '[Message]: ${dioException.message}'
      '[Data] : ${dioException.response?.data}\n'
      '----------------------------------------------\n',
    );
  }
}
