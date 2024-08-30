import 'package:health/health.dart';
import 'package:pedometer/pedometer.dart';

import '../utils/walking_service.dart';

class IosWalkingService implements WalkingService {
  static final IosWalkingService _instance = IosWalkingService._internal();
  static const _walking = 'walking';
  static const _stopped = 'stopped';
  static const _unknown = 'unknown';
  String pedestrianStatus = _stopped;
  late Stream<PedestrianStatus> _pedestrianStatusStream;

  IosWalkingService._internal();

  factory IosWalkingService() {
    return _instance;
  }

  init() {
    _pedestrianStatusStream = Pedometer.pedestrianStatusStream;
    _pedestrianStatusStream.listen((PedestrianStatus event) {
      String status = event.status;
      pedestrianStatus = status;
    });
  }

  Future<bool> requestAuthorization() async {
    final types = [HealthDataType.STEPS];
    bool requested = await Health().requestAuthorization(types);
    return requested;
  }

  @override
  Future<int> getCurrentStep() async {
    final now = DateTime.now();
    final startTime = DateTime(now.year, now.month, now.day, 0, 0, 0);
    final endTime = DateTime(now.year, now.month, now.day, 23, 59, 59);
    int? steps = await Health().getTotalStepsInInterval(startTime, endTime);
    if (steps == null) {
      return await Health().getTotalStepsInInterval(startTime, endTime) ?? 0;
    } else {
      return steps;
    }
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

  @override
  isWalking() {
    if (pedestrianStatus == _unknown) {
      return false;
    } else {
      return pedestrianStatus == _walking;
    }
  }
}
