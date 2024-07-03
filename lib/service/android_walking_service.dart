import 'dart:async';

import 'package:get_storage/get_storage.dart';
import 'package:pedometer/pedometer.dart';

import '../utils/walking_service.dart';

class AndroidWalkingService implements WalkingService {
  final GetStorage localStorage = GetStorage();

  static String LOCAL_STORE_STEP_KEY = 'pastSteps';
  static int checkDay = 0;

  late Stream<StepCount> _stepCountStream;

  int currentSteps = 0;
  int totalSteps = 0;
  int pastSteps = 0;

  static final AndroidWalkingService _instance =
      AndroidWalkingService._internal();

  AndroidWalkingService._internal() {
    print('생성');
    initPlatformState();
    init();
    Timer.periodic(Duration(minutes: 5), (t) {
      if (checkDay != DateTime.now().day) {
        resetStepTimer();
        checkDay = DateTime.now().day;
      }
    });
  }

  factory AndroidWalkingService() {
    return _instance;
  }

  void init() async {
    await GetStorage.init();
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream.asBroadcastStream();
    _stepCountStream.listen(updateStep).onError(onStepCountError);
  }

  void onStepCountError(error) {
    currentSteps = 0;
  }

  void updateStep(StepCount event) async {
    totalSteps = event.steps;

    int? value = localStorage.read(LOCAL_STORE_STEP_KEY);
    if (value == null || value == 0) {
      pastSteps = totalSteps;
      localStorage.write(LOCAL_STORE_STEP_KEY, totalSteps);
    } else {
      pastSteps = value;
    }
    currentSteps = totalSteps - pastSteps;
    print(currentSteps);
  }

  void resetStepTimer() async {
    pastSteps = totalSteps;
    currentSteps = 0;
    localStorage.write(LOCAL_STORE_STEP_KEY, totalSteps);
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
}
