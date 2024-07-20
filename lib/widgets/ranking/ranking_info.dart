import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../constants/colors.dart';
import '../../constants/text_styles.dart';

class RankingInfo extends StatelessWidget {
  const RankingInfo({
    super.key,
    required this.nickname,
    required this.profileImageUrl,
    required this.currentPixelCount,
    required this.rank,
  });

  final String nickname;
  final String? profileImageUrl;
  final int currentPixelCount;
  final int rank;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ClipOval(
          child: profileImageUrl != null
              ? Image.network(
                  profileImageUrl!,
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
              Text(nickname, style: TextStyles.title1),
              Text(
                '${NumberFormat('###,###,###').format(currentPixelCount)}px',
                style: TextStyles.body1,
              ),
            ],
          ),
        ),
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: AppColors.backgroundThird,
            borderRadius: BorderRadius.all(Radius.circular(22)),
          ),
          child: Center(
            child: Text(rank.toString(), style: TextStyles.rank),
          ),
        ),
      ],
    );
  }
}
