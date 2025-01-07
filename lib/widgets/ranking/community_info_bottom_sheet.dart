import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../models/community.dart';
import '../../screens/community_info_screen.dart';
import '../community/community_info.dart';
import '../community/community_record.dart';

class CommunityInfoBottomSheet extends StatelessWidget {
  const CommunityInfoBottomSheet({
    super.key,
    required this.community,
    required this.communityId,
  });

  final Community community;
  final int communityId;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 400,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5.0,
          left: 20.0,
          right: 20.0,
          bottom: 20.0,
        ),
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundThird,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                height: 4,
                width: 40,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Stack(
              children: [
                Positioned.fill(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0), // 이미지 둥근 모서리
                    child: Image(
                      image: CachedNetworkImageProvider(
                        community.backgroundImageUrl,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  height: 270,
                  padding: EdgeInsets.all(16.0),
                  color: Colors.black.withOpacity(0.5),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.bottomLeft,
                        child: Text(
                          community.name,
                          style: TextStyles.fs24w600cTextPrimary,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      CommunityInfo(
                        memberCount: community.memberCount.obs,
                        communityColor: community.communityColor.obs,
                        weeklyRanking: community.communityRanking.obs,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CommunityRecord(
                        currentPixelCount: community.currentPixelCount.obs,
                        accumulatePixelCount:
                            community.accumulatePixelCount.obs,
                        maxPixelCount: community.maxPixelCount.obs,
                        maxRankingCount: community.maxRanking.obs,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            InkWell(
              borderRadius: BorderRadius.all(Radius.circular(16)),
              onTap: () {
                Get.to(CommunityInfoScreen(communityId: communityId));
              },
              child: Ink(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: AppColors.primary,
                ),
                height: 60,
                width: 1000,
                child: Center(
                  child: Text(
                    "자세히 보기",
                    style: TextStyles.fs17w600cTextBlack,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
