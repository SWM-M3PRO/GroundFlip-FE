abstract class WalkingService {

  Future<int?> getCurrentStep();

  List<int> getWeeklySteps(startDate, endDate);

  Future<List<int>> getDailyStepsInInterval(
    DateTime startDate,
    DateTime endDate,
  );
}
