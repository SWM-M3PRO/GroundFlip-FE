import 'package:flutter/cupertino.dart';

import '../../constants/colors.dart';
import 'ranking_info.dart';

class RankingListElement extends StatelessWidget {
  const RankingListElement({
    super.key,
    required this.nickname,
    this.profileImageUrl,
    required this.currentPixelCount,
    required this.rank,
    required this.isLast,
  });

  final String nickname;
  final String? profileImageUrl;
  final int currentPixelCount;
  final int rank;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: isLast
                ? BorderSide.none
                : BorderSide(
                    color: AppColors.backgroundThird, // 경계 색상
                    width: 1.0, // 경계 두께
                  ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 20),
          child: RankingInfo(
            nickname: nickname,
            profileImageUrl: profileImageUrl,
            currentPixelCount: currentPixelCount,
            rank: rank,
          ),
        ),
      ),
    );
  }
}
