import 'package:dio/dio.dart';

import '../models/Individual_pixel_log.dart';
import '../models/user.dart';
import '../utils/dio_service.dart';

class UserService {
  static final UserService _instance = UserService._internal();
  final Dio dio = DioService().getDio();
  static const int userId = 2;

  UserService._internal();

  factory UserService() {
    return _instance;
  }

  Future<User> getCurrentUserInfo() async {
    var response = await dio.get('/users/$userId');
    return User.fromJson(response.data['data']);
  }

  Future<IndividualPixelLog> getUserPixelLog() async{
    var response = await dio.get('/usersPixel/$userId');
    return IndividualPixelLog.fromJson(response.data['data']);
  }
}
