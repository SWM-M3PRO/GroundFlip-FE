import 'dart:async';

import '../utils/walking_service.dart';

class AndroidWalkingService implements WalkingService {
  @override
  Future<int?> getCurrentStep() {
    // TODO: implement getCurrentStep
    throw UnimplementedError();
  }

  @override
  Future<List<int>> getDailyStepsInInterval(DateTime startDate, DateTime endDate) {
    // TODO: implement getDailyStepsInInterval
    throw UnimplementedError();
  }

  @override
  List<int> getWeeklySteps(startDate, endDate) {
    // TODO: implement getWeeklySteps
    throw UnimplementedError();
  }
  
}