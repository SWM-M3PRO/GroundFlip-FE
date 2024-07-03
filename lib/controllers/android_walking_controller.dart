import 'dart:async';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pedometer/pedometer.dart';


const String LOCAL_STORE_STEP_KEY = 'pastSteps';

class AndroidWalkingController extends GetxController {
  static double averageStride = 0.6;
  static int metersPerKilometer = 1000;
  static double averageCalorie = 0.04;

  static int checkDay = 0;

  RxInt currentSteps = 0.obs;
  RxInt totalSteps = 0.obs;
  RxInt pastSteps = 0.obs;

  final GetStorage box = GetStorage();

  late Stream<StepCount> _stepCountStream;

  AndroidWalkingController._privateConstructor();

  static final AndroidWalkingController _instance =
      AndroidWalkingController._privateConstructor();

  factory AndroidWalkingController() {
    return _instance;
  }

  String get getCurrentSteps => currentSteps.value.toString();

  @override
  void onInit() {
    super.onInit();
    initPlatformState();
    init();

    Timer.periodic(Duration(minutes: 5), (t) {
      if (checkDay != DateTime.now().day) {
        resetStepTimer();
        checkDay = DateTime.now().day;
      }
    });
  }

  void init() async {
    await GetStorage.init();
  }

  void updateStep(StepCount event) async {
    totalSteps.value = event.steps;

    int? value = box.read(LOCAL_STORE_STEP_KEY);
    if (value == null || value == 0) {
      pastSteps.value = totalSteps.value;
      box.write(LOCAL_STORE_STEP_KEY, totalSteps.value);
    } else {
      pastSteps.value = value;
    }
    currentSteps.value = totalSteps.value - pastSteps.value;
  }

  void resetStepTimer() async {
    pastSteps.value = totalSteps.value;
    currentSteps.value = 0;
    box.write(LOCAL_STORE_STEP_KEY, totalSteps.value);
  }

  void onStepCountError(error) {
    currentSteps.value = 0;
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream.asBroadcastStream();
    _stepCountStream.listen(updateStep).onError(onStepCountError);
  }

  getCurrentTravelDistance() {
    var currentTravelDistance =
        (currentSteps.value * averageStride) / metersPerKilometer;

    return currentTravelDistance.toStringAsFixed(2);
  }

  getCurrentCalorie() {
    var calorie = currentSteps.value * averageCalorie;

    return calorie.toStringAsFixed(0);
  }
}