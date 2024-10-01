import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../controllers/map_controller.dart';
import '../../../screens/explore_mode_screen.dart';

class BottomStats extends StatelessWidget {
  const BottomStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [],
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
          TextButton(
            onPressed: () {
              Get.find<MapController>().startExplore();
              Get.to(ExploreModeScreen());
            },
            style: TextButton.styleFrom(
              backgroundColor: AppColors.backgroundThird,
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                '점령 모드',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
