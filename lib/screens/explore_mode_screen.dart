import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/map_controller.dart';
import '../controllers/walking_controller.dart';

class ExploreModeScreen extends StatelessWidget {
  ExploreModeScreen({super.key});

  final MapController mapController = Get.find<MapController>();
  final WalkingController walkingController = Get.find<WalkingController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: AppBar(
          backgroundColor: Colors.black,
        ),
      ),
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Column(
            //       children: [
            //         Text(
            //           '5.6',
            //           style: TextStyle(
            //             color: AppColors.textPrimary,
            //             fontSize: 30,
            //             fontWeight: FontWeight.w800,
            //           ),
            //         ),
            //         Text(
            //           '속도',
            //           style: TextStyle(
            //             color: AppColors.textSecondary,
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ],
            //     ),
            //     Column(
            //       children: [
            //         Obx(
            //           () => Text(
            //             walkingController.currentStep.toString(),
            //             style: TextStyle(
            //               color: AppColors.textPrimary,
            //               fontSize: 30,
            //               fontWeight: FontWeight.w800,
            //             ),
            //           ),
            //         ),
            //         Text(
            //           '걸음수',
            //           style: TextStyle(
            //             color: AppColors.textSecondary,
            //             fontSize: 20,
            //             fontWeight: FontWeight.w500,
            //           ),
            //         ),
            //       ],
            //     ),
            //   ],
            // ),
            SizedBox(
              height: 100,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  children: [
                    Image.asset(
                      "assets/images/current_pixel_icon.png",
                      width: 60,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Obx(
                      () => Text(
                        mapController.currentPixelCount.toString(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 60,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '현재',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '픽셀',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Image.asset(
                      "assets/images/accumulate_pixel_icon.png",
                      width: 60,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Obx(
                      () => Text(
                        mapController.accumulatePixelCount.toString(),
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 60,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '누적',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          '픽셀',
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(
                      () => Text(
                        walkingController.currentStep.toString(),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      '걸음',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Obx(
                      () => Text(
                        mapController.speed.value.toStringAsFixed(1),
                        style: TextStyle(
                          color: AppColors.textPrimary,
                          fontSize: 35,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'km/h',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Obx(
              () => Text(
                formatTime(mapController.elapsedSeconds.value),
                style: TextStyle(
                  color: AppColors.textPrimary,
                  fontSize: 50,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  onTap: () {
                    mapController.stopExplore();
                    Get.back();
                  },
                  child: Ink(
                    // height: ,
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: AppColors.backgroundSecondary,
                        borderRadius: BorderRadius.all(Radius.circular(50))),
                    child: Icon(
                      Icons.pause,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }

  String formatTime(int seconds) {
    final int hours = seconds ~/ 3600;
    final int minutes = seconds ~/ 60;
    final int remainingSeconds = seconds % 60;
    return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
