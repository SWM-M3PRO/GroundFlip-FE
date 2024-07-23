import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/individual_history_pixel_info.dart';
import '../service/pixel_service.dart';
import '../widgets/map/individual_history_pixel_info_bottom_sheet.dart';
import '../widgets/map/step_stats.dart';

class BottomSheetController extends GetxController {
  final PixelService pixelService = PixelService();
  final DraggableScrollableController draggableController =
      DraggableScrollableController();
  Widget currentBody = StepStatsBody();
  Widget currentHeader = StepStats();
  RxInt mode = 0.obs;

  void showIndividualHistoryPixelInfo(IndividualHistoryPixelInfo pixelInfo) {
    mode.value = 1;
    draggableController.animateTo(
      0.6,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    currentHeader = IndividualHistoryHeader(
      address: pixelInfo.address,
      visitCount: pixelInfo.visitCount!,
    );
    currentBody = IndividualHistoryList(
      visitList: pixelInfo.visitList ?? [],
    );
    mode.value = 1;
  }

  void changeStepStatIfMinimized() {
    if (draggableController.size <= 0.111) {
      print('Bottom Sheet is minimized');
      currentHeader = StepStats();
      currentBody = StepStatsBody();
      mode.value = 0;
    }
  }

  getBody() {
    if (mode.value == 0) {
      print("stepStat");
    } else {
      print("history");
    }
    return currentBody;
  }

  getHeader() {
    if (mode.value == 0) {
      print("stepStat");
    } else {
      print("history");
    }
    return currentHeader;
  }
}
