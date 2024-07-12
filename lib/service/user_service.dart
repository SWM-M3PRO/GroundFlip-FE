import 'package:dio/dio.dart';
import 'package:get/get.dart';

import '../models/user.dart';
import '../models/user_pixel_count.dart';
import '../utils/dio_service.dart';
import '../utils/user_manager.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  final Dio dio = DioService().getDio();

  UserService._internal();

  factory UserService() {
    return _instance;
  }

  Future<User> getCurrentUserInfo() async {
    int? userId = UserManager().getUserId();
    var response = await dio.get('/users/$userId');
    return User.fromJson(response.data['data']);
  }

  Future<UserPixelCount> getUserPixelCount() async {
    int? userId = UserManager().getUserId();
    var response = await dio.get(
      '/pixels/count',
      queryParameters: {"user-id": userId},
    );
    return UserPixelCount.fromJson(response.data['data']);
  }

  Future<void> putUserInfo(
      String gender, int birthYear, String nickname) async {
    int? userId = UserManager().getUserId();
    var response = await dio.put(
      '/users/$userId',
      data: {
        'gender': gender,
        'birthYear': birthYear,
        'nickname': nickname,
      },
    );

    if (response.statusCode == 400) {
      throw Error();
    }
  }
}
