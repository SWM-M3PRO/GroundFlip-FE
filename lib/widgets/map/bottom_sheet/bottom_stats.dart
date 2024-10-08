import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';
import '../../../controllers/map_controller.dart';
import '../../../enums/pixel_mode.dart';

class BottomStats extends StatelessWidget {
  const BottomStats({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Obx(() {
              return Image.asset(
                mapController.currentPixelMode.value ==
                        PixelMode.individualHistory
                    ? "assets/images/accumulate_pixel_icon.png"
                    : "assets/images/current_pixel_icon.png",
                width: 40,
              );
            }),
            SizedBox(
              width: 10,
            ),
            Obx(() {
              return Text(
                NumberFormat('###,###,###')
                    .format(mapController.getPixelCount()),
                style: TextStyles.fs28w700cTextPrimary,
              );
            }),
          ],
        ),
        Row(
          children: [
            Text(
              '백그라운드 모드 ',
              style: TextStyles.fs17w400cTextSecondary,
            ),
            Obx(
              () => Switch(
                value: mapController.isBackgroundEnabled.value,
                onChanged: mapController.changeBackgroundMode,
                activeColor: AppColors.primary,
                inactiveThumbColor: AppColors.boxColorSecond,
                inactiveTrackColor: AppColors.backgroundThird,
                trackOutlineColor: WidgetStateProperty.resolveWith(
                  (final Set<WidgetState> states) {
                    if (states.contains(WidgetState.selected)) {
                      return null;
                    }
                    return AppColors.backgroundThird;
                  },
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

// Todo: 추후에 대시보드 등의 형식으로 변경 필요
class BottomStatsBody extends StatelessWidget {
  const BottomStatsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          // TextButton(
          //   onPressed: () {
          //     Get.find<MapController>().startExplore();
          //     Get.to(ExploreModeScreen());
          //   },
          //   style: TextButton.styleFrom(
          //     backgroundColor: AppColors.backgroundThird,
          //   ),
          //   child: Padding(
          //     padding: const EdgeInsets.symmetric(horizontal: 20.0),
          //     child: Text(
          //       '점령 모드',
          //       style: TextStyle(
          //         fontSize: 20,
          //         color: AppColors.primary,
          //         fontWeight: FontWeight.w700,
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
