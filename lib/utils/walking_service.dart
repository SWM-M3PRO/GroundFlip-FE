import 'package:get/get.dart';
import 'package:pedometer/pedometer.dart';

abstract class WalkingService {
  late RxInt step;

  void getCurrentStep(StepCount event);

  List<int> getWeeklySteps(startDate, endDate);
}
