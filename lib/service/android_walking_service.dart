import 'dart:async';

import '../utils/walking_service.dart';

class AndroidWalkingService implements WalkingService {
  @override
  Future<int?> getCurrentStep() {

    throw UnimplementedError();
  }

  @override
  Future<List<int>> getDailyStepsInInterval(DateTime startDate, DateTime endDate) {

    throw UnimplementedError();
  }

  @override
  List<int> getWeeklySteps(startDate, endDate) {

    throw UnimplementedError();
  }
  
}