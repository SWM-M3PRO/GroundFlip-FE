import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

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
        Rank(rank: ranking.rank, size: 30),
        SizedBox(width: 10),
        ClipOval(
          child: ranking.profileImageUrl != null
              ? Image(
                  image: CachedNetworkImageProvider(ranking.profileImageUrl!),
                  width: 30,
                  height: 30,
                  fit: BoxFit.cover,
                )
              : Image.asset(
                  'assets/images/default_profile_image.png',
                  width: 30,
                  height: 30,
                ),
        ),
        SizedBox(width: 10),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                ranking.name ?? "알수없음",
                style: TextStyles.fs17w600cTextPrimary,
              ),
              Spacer(),
              if (ranking.currentPixelCount != null)
                Text(
                  '${NumberFormat('###,###,###').format(ranking.currentPixelCount)}px',
                  style: TextStyles.fs17w700cPrimary,
                ),
            ],
          ),
        ),
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
  final int? rank;
  final double size;

  const Rank({super.key, required this.rank, required this.size});

  @override
  Widget build(BuildContext context) {
    if (rank == null) {
      return SizedBox(
        width: size,
        height: size,
        child: Center(
          child: Text('?', style: TextStyles.fs20w800cTextPrimary),
        ),
      );
    } else if (rank! <= 3 && rank! >= 1) {
      return Image.asset(
        medalImages[rank! - 1],
        width: size,
        height: size,
      );
    } else {
      Widget rankText;
      if (rank! > 9999) {
        rankText =
            Text(rank.toString(), style: TextStyles.fs12w800cTextPrimary);
      } else if (rank! > 999) {
        rankText =
            Text(rank.toString(), style: TextStyles.fs16w700cTextPrimary);
      } else {
        rankText =
            Text(rank.toString(), style: TextStyles.fs20w800cTextPrimary);
      }
      return SizedBox(
        width: size,
        height: size,
        child: Center(
          child: rankText,
        ),
      );
    }
  }
}

class RankingInfoMy extends StatelessWidget {
  const RankingInfoMy({
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
              ? Image(
                  image: CachedNetworkImageProvider(ranking.profileImageUrl!),
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
              Text(
                ranking.name ?? "알수없음",
                style: TextStyles.fs17w600cTextPrimary,
              ),
              if (ranking.currentPixelCount != null)
                Text(
                  '${NumberFormat('###,###,###').format(ranking.currentPixelCount)}px',
                  style: TextStyles.fs14w500cPrimary,
                ),
            ],
          ),
        ),
        MyRank(rank: ranking.rank),
      ],
    );
  }
}

class MyRank extends StatelessWidget {
  static List<String> medalImages = [
    "assets/images/1st_place_medal.png",
    "assets/images/2nd_place_medal.png",
    "assets/images/3rd_place_medal.png",
  ];
  final int? rank;

  const MyRank({super.key, required this.rank});

  @override
  Widget build(BuildContext context) {
    if (rank == null) {
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Color(0x80333333),
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
        child: Center(
          child: Text('?', style: TextStyles.fs20w800cTextPrimary),
        ),
      );
    } else if (rank! <= 3 && rank! >= 1) {
      return Image.asset(
        medalImages[rank! - 1],
        width: 44,
        height: 44,
      );
    } else {
      Widget rankText;
      if (rank! > 9999) {
        rankText =
            Text(rank.toString(), style: TextStyles.fs12w800cTextPrimary);
      } else if (rank! > 999) {
        rankText =
            Text(rank.toString(), style: TextStyles.fs16w700cTextPrimary);
      } else {
        rankText =
            Text(rank.toString(), style: TextStyles.fs20w800cTextPrimary);
      }
      return Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Color(0x80333333),
          borderRadius: BorderRadius.all(Radius.circular(22)),
        ),
        child: Center(
          child: rankText,
        ),
      );
    }
  }
}
