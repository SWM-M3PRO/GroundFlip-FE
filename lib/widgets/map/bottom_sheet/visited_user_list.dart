import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';
import '../../../models/individual_mode_pixel_info.dart';

class VisitedUserList extends StatelessWidget {
  final PixelOwnerUser pixelOwnerUser;
  final List<VisitList> visitList;

  const VisitedUserList(
      {super.key, required this.visitList, required this.pixelOwnerUser});

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        SizedBox(height: 10),
        OwnerInfo(
          pixelOwnerUser: pixelOwnerUser,
        ),
        if (visitList.length == 0) NoVisitedUserMessage(),
        for (int i = 0; i < visitList.length; i++)
          VisitedUserListElement(
            visitedUser: visitList[i],
          ),
      ],
    );
  }
}

class OwnerInfo extends StatelessWidget {
  const OwnerInfo({
    super.key,
    required this.pixelOwnerUser,
  });

  final PixelOwnerUser pixelOwnerUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundThird,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        padding: EdgeInsets.all(20),
        child: Row(
          children: [
            ClipOval(
              child: pixelOwnerUser.profileImageUrl != null
                  ? Image.network(
                      pixelOwnerUser.profileImageUrl!,
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
                  Text(
                    pixelOwnerUser.nickname ?? "알 수 없음",
                    style: TextStyles.fs17w600cTextPrimary,
                  ),
                  Row(
                    children: [
                      Text(
                        '${NumberFormat('###,###,###').format(pixelOwnerUser.currentPixelCount)}px',
                        style: TextStyles.fs14w500cPrimary,
                      ),
                      Text(
                        ' · 누적 ${NumberFormat('###,###,###').format(pixelOwnerUser.accumulatePixelCount)}px',
                        style: TextStyles.fs14w500cTextSecondary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Image.asset(
              'assets/images/current_pixel_icon.png',
              width: 44,
              height: 44,
            ),
          ],
        ),
      ),
    );
  }
}

class VisitedUserListElement extends StatelessWidget {
  const VisitedUserListElement({
    super.key,
    required this.visitedUser,
  });

  final VisitList visitedUser;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40.0),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.backgroundThird,
              width: 0.5,
            ),
          ),
        ),
        child: Row(
          children: [
            ClipOval(
              child: visitedUser.profileImageUrl != null
                  ? Image.network(
                      visitedUser.profileImageUrl!,
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
              child: Text(
                visitedUser.nickname ?? "알 수 없음",
                style: TextStyles.fs17w600cTextPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NoVisitedUserMessage extends StatelessWidget {
  const NoVisitedUserMessage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        padding: const EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: AppColors.backgroundThird,
            borderRadius: BorderRadius.all(Radius.circular(16))),
        child: Center(
          child: Column(
            children: [
              Text(
                "오늘 방문한 사람이 없습니다.",
                style: TextStyles.fs20w700cTextPrimary,
              ),
              Text(
                "걸어서 픽셀을 차지 해보세요!",
                style: TextStyles.fs17w700cPrimary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
