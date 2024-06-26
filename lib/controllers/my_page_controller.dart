import 'package:get/get.dart';

import '../service/ios_walking_service.dart';
import '../utils/walking_service.dart';

class MyPageController extends GetxController {
  final RxInt currentStep = 0.obs;
  final RxList<int> weeklySteps = <int>[0, 0, 0, 0, 0, 0, 0].obs;
  final RxString selectedWeek = "".obs;
  final RxBool isNextButtonEnabled = false.obs;
  late DateTime selectedWeekStartDate;
  late DateTime selectedWeekEndDate;
  late WalkingService walkingService;

  @override
  void onInit() {
    super.onInit();
    walkingService = IosWalkingService();
    _initializeWeeklyStep();
    _initializeCurrentStep();
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

    selectedWeek.value = getInterval();
    final thisWeeklyStep = await walkingService.getDailyStepsInInterval(
      selectedWeekStartDate,
      selectedWeekEndDate,
    );

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
    if (maxStep == 0) {
      return 10000;
    } else {
      return (maxStep / 100).ceil() * 100;
    }
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

  String getSelectedWeek() {
    return selectedWeek.value;
  }

  Future<void> loadPreviousWeekSteps() async {
    selectedWeekStartDate = selectedWeekStartDate.subtract(Duration(days: 7));
    selectedWeekEndDate = selectedWeekEndDate.subtract(Duration(days: 7));
    List<int> selectedWeekSteps = await walkingService.getDailyStepsInInterval(
        selectedWeekStartDate, selectedWeekEndDate);
    weeklySteps.assignAll(selectedWeekSteps);
    selectedWeek.value = getInterval();
    updateNextButtonStatus();
  }

  Future<void> loadNextWeekSteps() async {
    selectedWeekStartDate = selectedWeekStartDate.add(Duration(days: 7));
    selectedWeekEndDate = selectedWeekEndDate.add(Duration(days: 7));
    List<int> selectedWeekSteps = await walkingService.getDailyStepsInInterval(
        selectedWeekStartDate, selectedWeekEndDate);
    weeklySteps.assignAll(selectedWeekSteps);
    selectedWeek.value = getInterval();
    updateNextButtonStatus();
  }

  updateNextButtonStatus() {
    if (isTodayInRange(selectedWeekStartDate, selectedWeekEndDate)) {
      isNextButtonEnabled.value = false;
    } else {
      isNextButtonEnabled.value = true;
    }
  }

  bool isTodayInRange(DateTime startDate, DateTime endDate) {
    DateTime today = DateTime.now();
    DateTime todayOnly = DateTime(today.year, today.month, today.day);
    DateTime startDateOnly =
        DateTime(startDate.year, startDate.month, startDate.day);
    DateTime endDateOnly = DateTime(endDate.year, endDate.month, endDate.day);

    return (todayOnly.isAfter(startDateOnly) &&
            todayOnly.isBefore(endDateOnly)) ||
        todayOnly.isAtSameMomentAs(startDateOnly) ||
        todayOnly.isAtSameMomentAs(endDateOnly);
  }

  getIsNextButtonEnabled() {
    return isNextButtonEnabled.value;
  }
}
