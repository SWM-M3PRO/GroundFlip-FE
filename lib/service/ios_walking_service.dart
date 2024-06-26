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
  Future<int?> getCurrentStep() async {
    final now = DateTime.now();
    final startTime = DateTime(now.year, now.month, now.day);
    int? steps = await Health().getTotalStepsInInterval(startTime, now);
    return steps;
  }

  @override
  Future<List<int>> getDailyStepsInInterval(
    DateTime startDate,
    DateTime endDate,
  ) async {
    List<int> dailySteps = [];

    for (DateTime date = startDate;
        date.isBefore(endDate) || date.isAtSameMomentAs(endDate);
        date = date.add(const Duration(days: 1))) {
      DateTime startOfDay = DateTime(date.year, date.month, date.day, 0, 0, 0);
      DateTime endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);
      int dailyStep =
          await Health().getTotalStepsInInterval(startOfDay, endOfDay) ?? 0;
      dailySteps.add(dailyStep);
    }

    return dailySteps;
  }
}
