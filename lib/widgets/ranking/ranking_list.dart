import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/ranking_controller.dart';
import '../map/bottom_sheet/no_ranker_message.dart';
import 'ranking_list_element.dart';

class RankingList extends StatelessWidget {
  RankingList({super.key});

  @override
  Widget build(BuildContext context) {
    final RankingController rankingController = Get.find<RankingController>();

    return Expanded(
      child: RefreshIndicator(
        color: AppColors.primary,
        backgroundColor: AppColors.backgroundThird,
        onRefresh: () async {
          await rankingController.updateRankingWithDelay(1);
        },
        child: ListView(
          controller: rankingController.scrollController,
          children: [
            Obx(() {
              if (rankingController.rankings.isEmpty) {
                return NoRankerMessage();
              } else {
                return Container();
              }
            }),
            Obx(() {
              return RankingSection(
                rankings: rankingController.getRankingsTop3(),
              );
            }),
            SizedBox(
              height: 20,
            ),
            Obx(() {
              return RankingSection(
                rankings: rankingController.getRankingsAll(),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class RankingSection extends StatelessWidget {
  RankingSection({
    super.key,
    required this.rankings,
  });

  final List rankings;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          for (int i = 0; i < rankings.length; i++)
            RankingListElement(
              ranking: rankings[i],
              isLast: false,
            ),
        ],
      ),
    );
  }
}
