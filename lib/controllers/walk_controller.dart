import 'dart:io';

import 'package:get/get.dart';

import '../service/ios_walking_service.dart';
import '../utils/walking_service.dart';

class WalkController extends GetxController {
  final RxInt currentStep = 0.obs;
  late WalkingService walkingService;

  @override
  void onInit() {
    super.onInit();
    if (Platform.isIOS) {
      walkingService = IosWalkingService();
    }
    _initializeCurrentStep();
  }

  void _initializeCurrentStep() async {
    currentStep.value = (await walkingService.getCurrentStep())!;
  }

  updateStep() async {
    currentStep.value = (await walkingService.getCurrentStep())!;
  }

  String getCurrentStep() {
    return currentStep.value.toString();
  }

  getSteps() {}
}
