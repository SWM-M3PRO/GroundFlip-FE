abstract class WalkingService {
  Future<int> getCurrentStep();

  Future<List<int>> getDailyStepsInInterval(
    DateTime startDate,
    DateTime endDate,
  );
}
