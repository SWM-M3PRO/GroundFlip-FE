import 'dart:async';

import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';

import '../utils/walking_service.dart';

class AndroidWalkInterface extends GetxController implements WalkingService{
  late Stream<StepCount> _stepCountStream;

  @override
  RxInt step = 0.obs;

  RxInt get steps => step;

  @override
  void getCurrentStep(StepCount event){
    step.value = event.steps;
  }

  void onStepCountError(error) {
    //print('onStepCountError: $error');
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