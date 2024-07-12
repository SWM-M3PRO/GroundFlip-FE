import 'dart:async';
import 'dart:isolate';

import 'package:dio/dio.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:intl/intl.dart';

import '../models/user_step_response.dart';
import '../utils/android_notification.dart';
import '../utils/dio_service.dart';
import '../utils/user_manager.dart';
import '../utils/walking_service.dart';

class AndroidWalkingService implements WalkingService {
  ReceivePort? _receivePort;
  int currentSteps = 0;
  UserManager userManager = UserManager();
  final Dio dio = DioService().getDio();

  static final AndroidWalkingService _instance =
      AndroidWalkingService._internal();

  AndroidWalkingService._internal() {
    _initForegroundWalkingTask();
  }

  factory AndroidWalkingService() {
    return _instance;
  }

  @override
  Future<int> getCurrentStep() {
    return Future.value(currentSteps);
  }

  @override
  Future<List<int>> getDailyStepsInInterval(
    DateTime startDate,
    DateTime endDate,
  ) async {
    int? userId = UserManager().getUserId();
    var response = await dio.get(
      '/steps',
      queryParameters: {
        "user-id": userId,
        "start-date": startDate,
        "end-date": endDate,
      },
    );
    List<int>? result =
        UserStepResponse.fromJson(response.data['data']).userId ?? [];
    if (result.isEmpty) {
      return [0, 0, 0, 0, 0, 0, 0];
    } else {
      return result;
    }
  }

  Future<int?> postUserStep(userId, date, steps) async {
    String format = DateFormat('yyyy-MM-dd').format(date);
    var response = await dio.post(
      '/steps',
      data: {"userId": userId, "date": format, "steps": steps},
    );
    return response.statusCode;
  }

  Future<void> _initForegroundWalkingTask() async {
    initForegroundTask();
    final newReceivePort = FlutterForegroundTask.receivePort;
    _registerReceivePort(newReceivePort);
  }

  bool _registerReceivePort(ReceivePort? newReceivePort) {
    if (newReceivePort == null) {
      return false;
    }

    _closeReceivePort();

    _receivePort = newReceivePort;
    _receivePort?.listen((data) {
      currentSteps = data;
    });

    return _receivePort != null;
  }

  void _closeReceivePort() {
    _receivePort?.close();
    _receivePort = null;
  }
}
