import 'package:get/get.dart';

import '../service/ios_walking_service.dart';
import '../utils/walking_service.dart';

class MyPageController extends GetxController {
  final RxInt currentStep = 0.obs;
  final RxList<int> weeklySteps = <int>[].obs;
  late DateTime selectedWeekStartDate;
  late DateTime selectedWeekEndDate;
  late WalkingService walkingService;

  @override
  void onInit() {
    super.onInit();
    walkingService = IosWalkingService();
    _initializeCurrentStep();
    _initializeWeeklyStep();
  }

  void _initializeCurrentStep() async {
    currentStep.value = (await walkingService.getCurrentStep())!;
  }

  Future<void> _initializeWeeklyStep() async {
    DateTime nowDate = DateTime.now();
    selectedWeekStartDate =
        nowDate.subtract(Duration(days: nowDate.weekday - 1));
    selectedWeekEndDate =
        nowDate.add(Duration(days: DateTime.daysPerWeek - nowDate.weekday));
    int daysUntilSunday = DateTime.daysPerWeek - nowDate.weekday;
    final thisWeeklyStep = await walkingService.getDailyStepsInInterval(
      selectedWeekStartDate,
      nowDate,
    );
    for (int i = 0; i < daysUntilSunday; i++) {
      thisWeeklyStep.add(0);
    }
    weeklySteps.assignAll(thisWeeklyStep);
  }

  updateStep() async {
    currentStep.value = (await walkingService.getCurrentStep())!;
  }

  String getCurrentStep() {
    return currentStep.value.toString();
  }

  List<int> getWeeklyStep() {
    return weeklySteps.toList();
  }

  double getMaxStep() {
    int maxStep = weeklySteps.toList()[0];
    for (int number in weeklySteps.toList()) {
      if (number > maxStep) {
        maxStep = number;
      }
    }
    return (maxStep / 100).ceil() * 100;
  }

  String getInterval() {
    return "${_formatDate(selectedWeekStartDate)} ~ ${_formatDate(selectedWeekEndDate)}";
  }

  String _formatDate(DateTime date) {
    String year = date.year.toString().padLeft(4, '0');
    String month = date.month.toString().padLeft(2, '0');
    String day = date.day.toString().padLeft(2, '0');

    return '$year.$month.$day';
  }
}
