import 'dart:io';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:intl/intl.dart';

import '../utils/android_notification.dart';
import '../utils/secure_storage.dart';

class AlarmService {
  static initializeStepCount(String? title) async {
    if (title != null && title.contains("걸음 수")) {
      if (Platform.isAndroid) {
        DateTime previousDay = DateTime.now().subtract(Duration(days: 1));

        final SecureStorage secureStorage = SecureStorage();

        String dailyStepKey = "STEP:${DateFormat('yyyy-MM-dd').format(previousDay)}";
        String currentStepKey = "currentSteps";
        if (!await secureStorage.secureStorage.containsKey(key: dailyStepKey)) {
          await secureStorage.secureStorage.write(
            key: dailyStepKey,
            value: await secureStorage.secureStorage.read(key: currentStepKey),
          );

          await secureStorage.secureStorage.write(key: currentStepKey, value: '0');
          AndroidWalkingHandler.currentSteps = 0;

          FlutterForegroundTask.updateService(
            notificationTitle: "걸음수",
            notificationText: 0.toString(),
          );
        }
      }
    }
  }
}
