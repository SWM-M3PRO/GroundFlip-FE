import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';
import '../../../controllers/ranking_controller.dart';
import '../../../models/ranking.dart';
import '../../../screens/community_member_screen.dart';
import '../../ranking/ranking_info.dart';

class MemberList extends StatelessWidget {
  final String communityName;
  final int communityId;
  final List members;

  const MemberList({
    super.key,
    required this.members,
    required this.communityName,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.backgroundSecondary,
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 20, 20, 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "멤버",
                  style: TextStyles.fs24w900cTextPrimary,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(
                      CommunityMemberScreen(
                        communityName: communityName,
                        communityId: communityId,
                      ),
                    );
                  },
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "더보기",
                        style: TextStyles.fs14w600cTextSecondary,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.textSecondary,
                        size: 10,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (members.isEmpty)
            Column(
              children: [
                Center(
                  child: Text(
                    '가입한 유저가 없네요',
                    style: TextStyles.fs20w700cTextPrimary,
                  ),
                ),
                Text(
                  '그룹에 가입하여 첫번째 유저가 되어보세요!',
                  style: TextStyles.fs17w400cTextSecondary,
                ),
                SizedBox(
                  height: 20,
                ),
                Image.asset(
                  'assets/images/crying.png',
                  width: 120,
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
          for (int i = 0; i < members.length; i++)
            MemberListElement(
              ranking: members[i],
              isLast: i == members.length - 1 ? true : false,
            ),
        ],
      ),
    );
  }
}

class MemberListElement extends StatelessWidget {
  const MemberListElement({
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
        Rank(rank: ranking.rank, size: 44),
      ],
    );
  }
}
