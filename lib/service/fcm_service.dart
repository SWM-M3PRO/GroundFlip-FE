import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../utils/dio_service.dart';

class FcmService {
  static final FcmService _instance = FcmService._internal();

  final Dio dio = DioService().getDio();

  FcmService._internal();

  factory FcmService() {
    return _instance;
  }

  registerFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    dio.post(
      "/users/fcm-token",
      data: {
        "fcmToken": fcmToken,
      },
    );
  }
}
