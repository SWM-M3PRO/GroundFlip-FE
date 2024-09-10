import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/community_controller.dart';
import '../widgets/community/community_action_button.dart';
import '../widgets/community/community_image.dart';
import '../widgets/community/community_info.dart';
import '../widgets/community/community_record.dart';
import '../widgets/community/member/member_list.dart';
import 'no_community_screen.dart';

class CommunityScreen extends StatelessWidget {
  const CommunityScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final CommunityController communityController =
        Get.put(CommunityController());
    communityController.init();

    return Obx(() {
      if (!communityController.isJoin.value) {
        return NoCommunityScreen();
      } else {
        if (communityController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else {
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 350.0,
                floating: false,
                pinned: true,
                iconTheme: IconThemeData(
                  color: Colors.white,
                ),
                actions: [
                  IconButton(
                    icon: SvgPicture.asset(
                      'assets/images/share_icon.svg',
                      width: 20,
                    ),
                    onPressed: () {},
                  ),
                ],
                backgroundColor: AppColors.background,
                flexibleSpace: LayoutBuilder(
                  builder: (BuildContext context, BoxConstraints constraints) {
                    var top = constraints.biggest.height;
                    return FlexibleSpaceBar(
                      title: top <= 120
                          ? Text(
                              communityController.name.value,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10.0,
                                ),
                                child: Text(
                                  communityController.name.value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                      background: CommunityImage(
                        imageUrl: communityController.imageUrl.value,
                      ),
                      collapseMode: CollapseMode.parallax,
                    );
                  },
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    children: [
                      CommunityInfo(
                        memberCount: communityController.memberCount,
                        communityColor: communityController.communityColor,
                        weeklyRanking: communityController.communityRanking,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CommunityRecord(
                        currentPixelCount:
                            communityController.currentPixelCount,
                        accumulatePixelCount:
                            communityController.accumulatePixelCount,
                        maxPixelCount: communityController.maxPixelCount,
                        maxRankingCount: communityController.maxRanking,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MemberList(
                        members: communityController.members,
                        communityName: communityController.name.value,
                        communityId: communityController.communityId.value,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      QuitCommunityButton(
                        onTap: communityController.quitCommunity,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }
    });
  }
}
