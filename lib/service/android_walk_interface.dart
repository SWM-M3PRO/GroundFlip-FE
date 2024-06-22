import 'dart:async';

import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';

import '../utils/walking_service.dart';

class AndroidStepCounter extends GetxController implements WalkingService{
  late Stream<StepCount> _stepCountStream;

  final RxInt _currentSteps = 0.obs;
  final RxInt _pastSteps = 0.obs;
  final RxInt _totalSteps = 0.obs;

  @override
  late RxInt step = 0.obs;

  RxInt get steps => _currentSteps;

  @override
  void onInit(){
    super.onInit();
    initPlatformState();
    Timer.periodic(const Duration(seconds: 10), (t){
      resetStepTimer();
    });
  }

  void resetStepTimer() {//현재는 10초마다 초기화
    //DateTime now = DateTime.now();
    //DateTime nextMidnight = DateTime(now.year, now.month, now.day, now.second+10);
    _pastSteps.value = _totalSteps.value;
    print('reset timer ${_totalSteps.value}, ${_currentSteps.value}, ${_pastSteps.value}');
  }

  @override
  void getCurrentStep(StepCount event){
    _totalSteps.value = event.steps;
    _currentSteps.value = _totalSteps.value - _pastSteps.value;

    // if(check==false){
    //   _pastSteps.value = event.steps;
    //   print('check ok');
    // }
    print('init ${_currentSteps.value},${_totalSteps.value}, ${_pastSteps.value}');
  }

  void onStepCountError(error) {
    step.value = 0;
  }

  void initPlatformState() {
    _stepCountStream = Pedometer.stepCountStream;
    _stepCountStream.listen(getCurrentStep).onError(onStepCountError);
  }

  @override
  List<int> getWeeklySteps(startDate, endDate){
    List<int> a = [];
    return a;
  }

}