import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enums/pixel_mode.dart';
import '../models/individual_history_pixel_info.dart';
import '../models/individual_mode_pixel_info.dart';
import '../service/pixel_service.dart';
import '../widgets/map/bottom_sheet/individual_history_list.dart';
import '../widgets/map/bottom_sheet/pixel_info_header.dart';
import '../widgets/map/bottom_sheet/step_stats.dart';
import '../widgets/map/bottom_sheet/visited_user_list.dart';

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
    currentHeader = PixelInfoHeader(
      address: pixelInfo.address,
      visitCount: pixelInfo.visitCount!,
      mode: PixelMode.individualHistory,
    );
    currentBody = IndividualHistoryList(
      visitList: pixelInfo.visitList ?? [],
    );
    mode.value = 1;
  }

  void showIndividualModePixelInfo(IndividualModePixelInfo pixelInfo) {
    mode.value = 2;
    draggableController.animateTo(
      0.6,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
    currentHeader = PixelInfoHeader(
      address: pixelInfo.address,
      visitCount: pixelInfo.visitCount!,
      mode: PixelMode.individualMode,
    );
    currentBody = VisitedUserList(
      pixelOwnerUser: pixelInfo.pixelOwnerUser!,
      visitList: pixelInfo.visitList ?? [],
    );
    mode.value = 2;
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
