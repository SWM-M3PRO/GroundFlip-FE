import 'package:get/get.dart';

import '../service/ios_walking_service.dart';
import '../utils/date_utils.dart';
import '../utils/walking_service.dart';

class MyPageController extends GetxController {
  final RxInt currentStep = 0.obs;
  final RxList<int> selectedWeeklySteps = <int>[0, 0, 0, 0, 0, 0, 0].obs;
  final RxString selectedWeekInfo = "".obs;
  final RxBool isNextButtonEnabled = false.obs;
  late DateTime selectedWeekStartDate;
  late DateTime selectedWeekEndDate;
  late WalkingService walkingService;

  @override
  void onInit() {
    super.onInit();
    walkingService = IosWalkingService();
    _initializeWeeklySteps();
    _initializeCurrentStep();
  }

  void _initializeCurrentStep() async {
    currentStep.value = (await walkingService.getCurrentStep())!;
  }

  Future<void> _initializeWeeklySteps() async {
    DateTime nowDate = DateTime.now();
    selectedWeekStartDate =
        nowDate.subtract(Duration(days: nowDate.weekday - 1));
    selectedWeekEndDate =
        nowDate.add(Duration(days: DateTime.daysPerWeek - nowDate.weekday));

    _updateSelectedWeekInfo();
    _updateSelectedWeekSteps();
  }

  String getCurrentStep() {
    return currentStep.value.toString();
  }

  List<int> getWeeklySteps() {
    return selectedWeeklySteps.toList();
  }

  double getMaxStep() {
    int maxStep = selectedWeeklySteps.toList()[0];
    for (int number in selectedWeeklySteps.toList()) {
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

  String getSelectedWeekInfo() {
    return selectedWeekInfo.value;
  }

  getIsNextButtonEnabled() {
    return isNextButtonEnabled.value;
  }

  Future<void> updateCurrentStep() async {
    currentStep.value = (await walkingService.getCurrentStep())!;
  }

  _updateSelectedWeekSteps() async {
    List<int> thisWeeklyStep = await walkingService.getDailyStepsInInterval(
      selectedWeekStartDate,
      selectedWeekEndDate,
    );
    selectedWeeklySteps.assignAll(thisWeeklyStep);
  }

  void _updateSelectedWeekInfo() {
    selectedWeekInfo.value =
        "${DateUtils.formatDate(selectedWeekStartDate)} ~ ${DateUtils.formatDate(selectedWeekEndDate)}";
  }

  _updateNextButtonStatus() {
    if (DateUtils.isTodayInRange(selectedWeekStartDate, selectedWeekEndDate)) {
      isNextButtonEnabled.value = false;
    } else {
      isNextButtonEnabled.value = true;
    }
  }

  Future<void> loadPreviousWeekSteps() async {
    selectedWeekStartDate = selectedWeekStartDate.subtract(Duration(days: 7));
    selectedWeekEndDate = selectedWeekEndDate.subtract(Duration(days: 7));
    _loadWeekSteps();
  }

  Future<void> loadNextWeekSteps() async {
    selectedWeekStartDate = selectedWeekStartDate.add(Duration(days: 7));
    selectedWeekEndDate = selectedWeekEndDate.add(Duration(days: 7));
    _loadWeekSteps();
  }

  Future<void> _loadWeekSteps() async {
    _updateSelectedWeekSteps();
    _updateSelectedWeekInfo();
    _updateNextButtonStatus();
  }
}
