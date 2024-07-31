import 'dart:async';
import 'dart:isolate';
import 'dart:math';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:pedometer/pedometer.dart';

import '../service/android_walking_service.dart';
import '../service/auth_service.dart';
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
  AuthService authService = AuthService();

  static String todayStepKey = 'currentSteps';
  static String lastSavedStepKey = 'lastSteps';
  Timer? _midnightTimer;
  int currentSteps = 0;

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    currentSteps = await getTodayStep() ?? 0;

    _stepCountStream = Pedometer.stepCountStream.asBroadcastStream();
    _stepCountStream.listen(updateStep).onError(onStepCountError);
    _initializeMidnightReset();
  }

  void onStepCountError(error) {
    currentSteps = 0;
  }

  void _initializeMidnightReset() {
    DateTime now = DateTime.now();
    DateTime midnight = DateTime(
      now.year,
      now.month,
      now.day + 1,
      0,
      Random().nextInt(40) + 10,
    );
    Duration timeUntilMidnight = midnight.difference(now);
    _midnightTimer?.cancel();
    _midnightTimer = Timer(timeUntilMidnight, () {
      _resetStepsAtMidnight();
      _midnightTimer?.cancel();
      _midnightTimer = Timer.periodic(Duration(days: 1), (timer) {
        _resetStepsAtMidnight();
      });
    });
  }

  void _resetStepsAtMidnight() async {
    String token = await secureStorage.readAccessToken();
    int userId = authService.extractUserIdFromToken(token);
    DateTime previousDay = DateTime.now().subtract(Duration(days: 1));
    await androidWalkingService.postUserStep(userId, previousDay, currentSteps);

    currentSteps = 0;
    await secureStorage.secureStorage.write(key: todayStepKey, value: '0');

    FlutterForegroundTask.updateService(
      notificationTitle: "걸음수",
      notificationText: currentSteps.toString(),
    );
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
