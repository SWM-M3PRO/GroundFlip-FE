import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/ranking_controller.dart';
import 'ranking_info.dart';

class MyRankingInfo extends StatelessWidget {
  const MyRankingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();

    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Color.lerp(
            AppColors.backgroundSecondary,
            AppColors.background,
            rankingController.t.value,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: EdgeInsets.all(rankingController.myRankingInfoPadding.value),
          child: Column(
            children: [
              RankingInfo(
                ranking: rankingController.getMyRanking(),
              ),
              SizedBox(height: rankingController.myRankingInfoPadding.value),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                height: rankingController.myRankingInfoHeight.value,
                decoration: BoxDecoration(
                  color: AppColors.secondary,
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text('3px 더 먹으면 순위 상승!',
                        style: TextStyles.fs14w500cPrimary),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
