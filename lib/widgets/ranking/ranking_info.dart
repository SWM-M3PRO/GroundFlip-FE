import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../models/ranking.dart';

class RankingInfo extends StatelessWidget {
  const RankingInfo({
    super.key,
    required this.ranking,
  });

  final Ranking ranking;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: ranking.profileImageUrl != null
              ? Image.network(
                  ranking.profileImageUrl!,
                  cacheWidth: 100,
                  width: 44,
                  height: 44,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/default_profile_image.png',
                  width: 44,
                  height: 44,
                ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(ranking.nickname, style: TextStyles.fs17w600cTextPrimary),
              Text(
                '${NumberFormat('###,###,###').format(ranking.currentPixelCount)}px',
                style: TextStyles.fs14w500cPrimary,
              ),
            ],
          ),
        ),
        Rank(rank: ranking.rank),
      ],
    );
  }
}

class Rank extends StatelessWidget {
  static List<String> medalImages = [
    "assets/images/1st_place_medal.png",
    "assets/images/2nd_place_medal.png",
    "assets/images/3rd_place_medal.png",
  ];
  final int rank;

  const Rank({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    if (rank <= 3 && rank >= 1) {
      return Image.asset(
        medalImages[rank - 1],
        width: 44,
        height: 44,
      );
    } else {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.backgroundThird,
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
        child: Center(
          child: Text(rank.toString(), style: TextStyles.fs20w800cTextPrimary),
        ),
      );
    }
  }
}
