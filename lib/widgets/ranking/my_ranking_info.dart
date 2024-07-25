import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ground_flip/widgets/ranking/ranking_info.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/ranking_controller.dart';

class MyRankingInfo extends StatelessWidget {
  const MyRankingInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();

    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              AppColors.secondary,
              AppColors.primary,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          // padding: EdgeInsets.all(rankingController.myRankingInfoPadding.value),
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              RankingInfoMy(
                ranking: rankingController.getMyRanking(),
              ),
              SizedBox(height: rankingController.myRankingInfoPadding.value),
              Container(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 16.0),
                height: rankingController.myRankingInfoHeight.value,
                decoration: BoxDecoration(
                  color: Color(0x80333333),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      '오늘 하루도 파이팅!',
                      style: TextStyles.fs14w800cTextPrimary,
                    ),
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
