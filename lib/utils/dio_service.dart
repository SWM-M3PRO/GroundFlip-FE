import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class DioService {
  static final DioService _dioServices = DioService._internal();
  static final String baseUrl = dotenv.env['BASE_URL']!;

  factory DioService() => _dioServices;
  Map<String, dynamic> dioInformation = {};

  static Dio _dio = Dio();

  DioService._internal() {
    BaseOptions options = BaseOptions(
      baseUrl: dotenv.env['BASE_URL']!,
      connectTimeout: const Duration(milliseconds: 10000),
      receiveTimeout: const Duration(milliseconds: 10000),
      sendTimeout: const Duration(milliseconds: 10000),
    );
    _dio = Dio(options);
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        logRequest(options);
        return handler.next(options);
      },
      onResponse: (Response response, ResponseInterceptorHandler handler) {
        logResponse(response);
        return handler.next(response);
      },
    ),);
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
}
