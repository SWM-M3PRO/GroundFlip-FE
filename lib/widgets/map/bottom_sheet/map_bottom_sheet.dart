import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/bottom_sheet_controller.dart';

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var bottomSheetController = Get.find<BottomSheetController>();

    return NotificationListener(
      onNotification: (DraggableScrollableNotification notification) {
        bottomSheetController.changeStepStatIfMinimized();
        return true;
      },
      child: DraggableScrollableSheet(
        controller: bottomSheetController.draggableController,
        snap: true,
        initialChildSize: 0.11,
        minChildSize: 0.11,
        maxChildSize: 0.6,
        builder: (BuildContext context, scrollController) {
          return Container(
            clipBehavior: Clip.hardEdge,
            decoration: BoxDecoration(
              color: AppColors.backgroundSecondary,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(32),
                topRight: Radius.circular(32),
              ),
            ),
            child: CustomScrollView(
              controller: scrollController,
              slivers: [
                SliverToBoxAdapter(
                  child: Center(
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.backgroundThird,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                      ),
                      height: 4,
                      width: 40,
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Obx(
                    () => Container(
                      padding: EdgeInsets.symmetric(horizontal: 20.0),
                      child: bottomSheetController.getHeader(),
                    ),
                  ),
                ),
                Obx(() {
                  print("rereender");
                  return bottomSheetController.getBody();
                }),
              ],
            ),
          );
        },
      ),
    );
  }
}
