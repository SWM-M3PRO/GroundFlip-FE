import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../enums/pixel_mode.dart';
import '../models/community_mode_pixel_info.dart';
import '../models/individual_history_pixel_info.dart';
import '../models/individual_mode_pixel_info.dart';
import '../service/pixel_service.dart';
import '../widgets/map/bottom_sheet/individual_history_list.dart';
import '../widgets/map/bottom_sheet/pixel_info_header.dart';
import '../widgets/map/bottom_sheet/step_stats.dart';
import '../widgets/map/bottom_sheet/visited_user_list.dart';
import 'map_controller.dart';

class BottomSheetController extends GetxController {
  final PixelService pixelService = PixelService();
  final DraggableScrollableController draggableController =
      DraggableScrollableController();

  Widget currentBody = StepStatsBody();
  Widget currentHeader = StepStats();
  RxInt mode = 0.obs;
  RxBool changeVar = true.obs;
  double size = 1.1;

  void showIndividualHistoryPixelInfo(
    IndividualHistoryPixelInfo pixelInfo,
    int pixelId,
  ) {
    mode.value = 1;
    changeVar.value = changeVar.value ? false : true;
    draggableController.animateTo(
      0.6,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    currentHeader = PixelInfoHeader(
      pixelId: pixelId,
      address: pixelInfo.address,
      visitCount: pixelInfo.visitCount!,
      mode: PixelMode.individualHistory,
    );
    currentBody = IndividualHistoryList(
      visitList: pixelInfo.visitList ?? [],
    );
    mode.value = 1;
  }

  void showIndividualModePixelInfo(
    IndividualModePixelInfo pixelInfo,
    int pixelId,
  ) {
    mode.value = 2;
    changeVar.value = changeVar.value ? false : true;
    draggableController.animateTo(
      0.6,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    currentHeader = PixelInfoHeader(
      pixelId: pixelId,
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

  void showCommunityModePixelInfo(
    CommunityModePixelInfo pixelInfo,
    int pixelId,
  ) {
    mode.value = 2;
    changeVar.value = changeVar.value ? false : true;
    draggableController.animateTo(
      0.6,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
    currentHeader = PixelInfoHeader(
      pixelId: pixelId,
      address: pixelInfo.address,
      visitCount: pixelInfo.visitCount!,
      mode: PixelMode.individualMode,
    );
    currentBody = VisitedUserList(
      pixelOwnerUser: pixelInfo.pixelOwnerCommunity!,
      visitList: pixelInfo.visitList ?? [],
    );
    mode.value = 2;
  }

  minimize() {
    currentHeader = StepStats();
    currentBody = StepStatsBody();
    mode.value = 0;
    draggableController.animateTo(
      0.1,
      duration: Duration(milliseconds: 200),
      curve: Curves.easeInOut,
    );
  }

  void changeStepStatIfMinimized() {
    if (draggableController.size <= 0.111 && size > draggableController.size) {
      currentHeader = StepStats();
      currentBody = StepStatsBody();
      mode.value = 0;

      Get.find<MapController>().changePixelToNormalState();
      Get.find<MapController>().isBottomSheetShowUp = false;
    }
    size = draggableController.size;
  }

  getBody() {
    if (mode.value == 0 && changeVar.value) {
      // changeVar.value = changeVar.value ? false : true;
    }
    return currentBody;
  }

  getHeader() {
    if (mode.value == 0 && changeVar.value) {
      // changeVar.value = changeVar.value ? false : true;
    }
    return currentHeader;
  }
}
