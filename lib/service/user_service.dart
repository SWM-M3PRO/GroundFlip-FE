import 'dart:convert';

import 'package:dio/dio.dart';

import '../models/user.dart';
import '../models/user_pixel_count.dart';
import '../utils/dio_service.dart';
import '../utils/secure_storage.dart';
import '../utils/user_manager.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  final SecureStorage secureStorage = SecureStorage();
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

  deleteUser() async {
    String? accessToken = await secureStorage.readAccessToken();
    String? refreshToken = await secureStorage.readRefreshToken();
    await dio.delete(
      '/users/${UserManager().userId}',
      data: {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      },
    );
    await secureStorage.deleteAccessToken();
    await secureStorage.deleteRefreshToken();
  }

  Future<int?> putUserInfo({
    required String gender,
    required int birthYear,
    required String nickname,
    String? profileImagePath,
  }) async {
    int? userId = UserManager().getUserId();
    late String fileName;

    var userInfoJson = jsonEncode(
      {
        'gender': gender,
        'birthYear': birthYear,
        'nickname': nickname,
      },
    );

    var formData = FormData();

    formData.files.add(
      MapEntry(
        'userInfoRequest',
        MultipartFile.fromString(
          userInfoJson,
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

    var response = await dio.put(
      '/users/$userId',
      data: formData,
      options: Options(contentType: 'multipart/form-data'),
    );

    return response.statusCode;
  }
}
