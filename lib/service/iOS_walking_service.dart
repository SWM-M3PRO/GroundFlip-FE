import 'package:health/health.dart';

import '../utils/walking_service.dart';

class IosWalkingService implements WalkingService {
  static final IosWalkingService _instance = IosWalkingService._internal();

  IosWalkingService._internal();

  factory IosWalkingService() {
    return _instance;
  }

  Future<bool> requestAuthorization() async {
    final types = [HealthDataType.STEPS];
    bool requested = await Health().requestAuthorization(types);
    return requested;
  }

  @override
  int getCurrentStep() {
    // TODO: implement getCurrentStep
    throw UnimplementedError();
  }

  @override
  List<int> getWeeklySteps(startDate, endDate) {
    // TODO: implement getWeeklySteps
    throw UnimplementedError();
  }
}
