
import 'package:dio/dio.dart';

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

  Future<int?> putUserInfo({
    required String gender,
    required int birthYear,
    required String nickname,
    String? profileImagePath,
  }) async {
    int? userId = UserManager().getUserId();
    var formData = FormData.fromMap(
      {
        'gender': gender,
        'birthYear': birthYear,
        'nickname': nickname,
      },
    );

    if (profileImagePath != null) {
      formData.fields.add(MapEntry('profileImage', profileImagePath));
    }

    var response = await dio.put(
      '/users/$userId',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return response.statusCode;
  }
}
