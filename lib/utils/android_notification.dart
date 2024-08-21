import 'dart:async';
import 'dart:isolate';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:pedometer/pedometer.dart';

import '../service/android_walking_service.dart';
import 'secure_storage.dart';

Future<void> initForegroundTask() async {
  if (!await FlutterForegroundTask.isRunningService) {
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        channelId: 'ground-flip',
        channelName: 'ground-flip Notification',
        channelDescription:
            'This notification appears when the ground-flip is running.',
        channelImportance: NotificationChannelImportance.LOW,
        priority: NotificationPriority.LOW,
        iconData: const NotificationIconData(
          resType: ResourceType.mipmap,
          resPrefix: ResourcePrefix.ic,
          name: 'launcher',
        ),
        isSticky: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: true,
        playSound: false,
      ),
      foregroundTaskOptions: const ForegroundTaskOptions(
        interval: 1000,
        isOnceEvent: false,
        autoRunOnBoot: true,
        allowWakeLock: true,
        allowWifiLock: true,
      ),
    );
    FlutterForegroundTask.startService(
      notificationTitle: "걸음수",
      notificationText: "0",
      callback: startCallback,
    );
  }
}

@pragma('vm:entry-point')
Future<void> startCallback() async {
  await dotenv.load(fileName: ".env");
  FlutterForegroundTask.setTaskHandler(AndroidWalkingHandler());
}

class AndroidWalkingHandler extends TaskHandler {
  late Stream<StepCount> _stepCountStream;
  final SecureStorage secureStorage = SecureStorage();
  final AndroidWalkingService androidWalkingService = AndroidWalkingService();

  static String todayStepKey = 'currentSteps';
  static String lastSavedStepKey = 'lastSteps';

  static int currentSteps = 0;

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    currentSteps = await getTodayStep() ?? 0;

    _stepCountStream = Pedometer.stepCountStream.asBroadcastStream();
    _stepCountStream.listen(updateStep).onError(onStepCountError);
  }

  void onStepCountError(error) {
    currentSteps = 0;
  }

  updateStep(StepCount event) async {
    int currentTotalStep = event.steps;

    int? lastSavedStepCount = await getLastSavedStep();
    int todaySteps = await getTodayStep() ?? 0;

    if (lastSavedStepCount == null) {
      await secureStorage.secureStorage
          .write(key: lastSavedStepKey, value: currentTotalStep.toString());
      lastSavedStepCount = currentTotalStep;
    }

    if (currentTotalStep < lastSavedStepCount) {
      todaySteps += currentTotalStep;
      lastSavedStepCount = currentTotalStep;
      await secureStorage.secureStorage
          .write(key: lastSavedStepKey, value: currentTotalStep.toString());
    } else {
      int deltaSteps = currentTotalStep - lastSavedStepCount;
      todaySteps += deltaSteps;
      lastSavedStepCount = currentTotalStep;
    }

    await secureStorage.secureStorage
        .write(key: todayStepKey, value: todaySteps.toString());
    await secureStorage.secureStorage
        .write(key: lastSavedStepKey, value: currentTotalStep.toString());
    currentSteps = todaySteps;

    FlutterForegroundTask.updateService(
      notificationTitle: "걸음수",
      notificationText: currentSteps.toString(),
    );
  }

  getTodayStep() async {
    String? stringStep =
        await secureStorage.secureStorage.read(key: todayStepKey);
    if (stringStep == null) {
      return null;
    } else {
      return int.parse(stringStep);
    }
  }

  getLastSavedStep() async {
    String? stringStep =
        await secureStorage.secureStorage.read(key: lastSavedStepKey);
    if (stringStep == null) {
      return null;
    } else {
      return int.parse(stringStep);
    }
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    sendPort?.send(currentSteps);
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {}
}
