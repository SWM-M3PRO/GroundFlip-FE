import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/ranking_controller.dart';
import '../widgets/ranking/my_ranking_info.dart';
import '../widgets/ranking/ranking_list.dart';
import '../widgets/ranking/week_selector.dart';

class RankingScreen extends StatelessWidget {
  const RankingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          child: Column(
            children: [
              WeekSelector(),
              MyRankingInfo(),
              SizedBox(
                height: 20,
              ),
              RankingList(),
            ],
          ),
        ),
        Obx(() {
          if (rankingController.isLoading.value) {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          } else {
            return SizedBox();
          }
        }),
      ],
    );
  }
}
