import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/ranking_controller.dart';
import '../../models/ranking.dart';
import 'ranking_info.dart';

class RankingListElement extends StatelessWidget {
  const RankingListElement({
    super.key,
    required this.isLast,
    required this.ranking,
  });

  final Ranking ranking;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.find<RankingController>().openRankingBottomSheet(ranking);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
        child: Container(
          decoration: BoxDecoration(
            border: Border(
              bottom: isLast
                  ? BorderSide.none
                  : BorderSide(
                      color: AppColors.backgroundThird,
                      width: 1.0,
                    ),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 16),
            child: RankingInfo(
              ranking: ranking,
            ),
          ),
        ),
      ),
    );
  }
}
