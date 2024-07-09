import 'dart:async';
import 'dart:isolate';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

import '../utils/android_notification.dart';
import '../utils/walking_service.dart';

class AndroidWalkingService implements WalkingService {
  ReceivePort? _receivePort;
  int currentSteps = 0;

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
  ) {
    return Future.value([1500, 2500, 3500, 4500, 5500, 6500, 7500]);
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
