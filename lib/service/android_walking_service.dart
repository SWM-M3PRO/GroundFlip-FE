import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:intl/intl.dart';
import 'package:pedometer/pedometer.dart';

import '../models/user_step_response.dart';
import '../utils/android_notification.dart';
import '../utils/dio_service.dart';
import '../utils/user_manager.dart';
import '../utils/walking_service.dart';

class AndroidWalkingService implements WalkingService {
  final Dio dio = DioService().getDio();
  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  static const _walking = 'walking';
  static const _stopped = 'stopped';
  static const _unknown = 'unknown';
  static final AndroidWalkingService _instance =
      AndroidWalkingService._internal();

  String pedestrianStatus = _stopped;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  AndroidWalkingService._internal() {
    // _initForegroundWalkingTask();
  }

  factory AndroidWalkingService() {
    return _instance;
  }

  init() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen((PedestrianStatus event) {
      String status = event.status;
      pedestrianStatus = status;
    });
  }

  @override
  Future<int> getCurrentStep() async {
    String? currentStep = await secureStorage.read(key: 'currentSteps');
    return int.parse(currentStep ?? '0');
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
        UserStepResponse.fromJson(response.data['data']).steps ?? [];
    if (result.isEmpty) {
      return [0, 0, 0, 0, 0, 0, 0];
    } else {
      return result;
    }
  }

  Future<void> postUserStep(userId, date, steps) async {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    await dio.post(
      '/steps',
      data: {"userId": userId, "date": formattedDate, "steps": steps},
    );
  }

  Future<void> postAllUserStepFromStorage() async {
    Map<String, int> allSteps = await _getStepData();

    allSteps.forEach((date, steps) async {
      await dio.post(
        '/steps',
        data: {
          "userId": UserManager().getUserId(),
          "date": date,
          "steps": steps,
        },
      );
    });
  }

  Future<void> _initForegroundWalkingTask() async {
    if (Platform.isAndroid) {
      initForegroundTask();
    }
  }

  Future<Map<String, int>> _getStepData() async {
    Map<String, String> allSteps = await secureStorage.readAll();

    Map<String, int> stepData = {};
    allSteps.forEach((key, value) async {
      if (key.startsWith("STEP:")) {
        String dateKey = key.substring(5);
        stepData[dateKey] = int.parse(value);
        await secureStorage.delete(key: key);
      }
    });

    return stepData;
  }

  @override
  isWalking() {
    if (pedestrianStatus == _unknown) {
      return false;
    } else {
      return pedestrianStatus == _walking;
    }
  }
}
