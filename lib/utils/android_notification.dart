import 'dart:async';
import 'dart:isolate';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:get_storage/get_storage.dart';
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
  SendPort? _sendPort;
  late Stream<StepCount> _stepCountStream;
  final SecureStorage secureStorage = SecureStorage();
  final AndroidWalkingService androidWalkingService = AndroidWalkingService();
  AuthService authService = AuthService();

  final GetStorage _localStorage = GetStorage();
  static String todayStepKey = 'currentSteps';
  static String lastSavedStepKey = 'lastSteps';
  Timer? _midnightTimer;
  int currentSteps = 0;

  @override
  void onStart(DateTime timestamp, SendPort? sendPort) async {
    _sendPort = sendPort;
    currentSteps = _localStorage.read(todayStepKey) ?? 0;
    _stepCountStream = Pedometer.stepCountStream.asBroadcastStream();
    _stepCountStream.listen(updateStep).onError(onStepCountError);
    _initializeMidnightReset();
  }

  void onStepCountError(error) {
    currentSteps = 0;
  }

  void _initializeMidnightReset() {
    DateTime now = DateTime.now();
    DateTime midnight =
        DateTime(now.year, now.month, now.day + 1, now.minute + 1);
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
    androidWalkingService.postUserStep(userId, previousDay, currentSteps);

    currentSteps = 0;
    _localStorage.write(todayStepKey, 0);

    FlutterForegroundTask.updateService(
      notificationTitle: "걸음수",
      notificationText: currentSteps.toString(),
    );
    _sendPort?.send(currentSteps);
  }

  updateStep(StepCount event) async {
    int currentTotalStep = event.steps;

    int? lastSavedStepCount = _localStorage.read(lastSavedStepKey);
    int todaySteps = _localStorage.read(todayStepKey) ?? 0;

    if (lastSavedStepCount == null) {
      _localStorage.write(lastSavedStepKey, currentTotalStep);
      lastSavedStepCount = currentTotalStep;
    }

    if (currentTotalStep < lastSavedStepCount) {
      todaySteps += currentTotalStep;
      lastSavedStepCount = currentTotalStep;
      _localStorage.write(lastSavedStepKey, currentTotalStep);
    } else {
      int deltaSteps = currentTotalStep - lastSavedStepCount;
      todaySteps += deltaSteps;
      lastSavedStepCount = currentTotalStep;
    }

    _localStorage.write(todayStepKey, todaySteps);
    _localStorage.write(lastSavedStepKey, currentTotalStep);
    currentSteps = todaySteps;

    FlutterForegroundTask.updateService(
      notificationTitle: "걸음수",
      notificationText: currentSteps.toString(),
    );
    _sendPort?.send(currentSteps);
  }

  @override
  void onRepeatEvent(DateTime timestamp, SendPort? sendPort) async {
    sendPort?.send(currentSteps);
  }

  @override
  void onDestroy(DateTime timestamp, SendPort? sendPort) async {}
}
