import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/community_info_controller.dart';
import '../widgets/community/community_action_button.dart';
import '../widgets/community/community_image.dart';
import '../widgets/community/community_info.dart';
import '../widgets/community/community_record.dart';
import '../widgets/community/member/member_list.dart';

class CommunityInfoScreen extends StatelessWidget {
  final int groupId;

  const CommunityInfoScreen({
    super.key,
    required this.groupId,
  });

  @override
  Widget build(BuildContext context) {
    final CommunityInfoController communityInfoController =
        Get.put(CommunityInfoController());
    communityInfoController.init(groupId);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        if (communityInfoController.isLoading.value) {
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
                leading: IconButton(
                  icon: Icon(Icons.arrow_back_ios),
                  onPressed: () {
                    Get.back();
                  },
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
                              communityInfoController.name.value,
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
                                  communityInfoController.name.value,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                              ),
                            ),
                      background: CommunityImage(
                        imageUrl: communityInfoController.imageUrl.value,
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
                        memberCount: communityInfoController.memberCount,
                        communityColor: communityInfoController.communityColor,
                        weeklyRanking: communityInfoController.communityRanking,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      CommunityRecord(
                        currentPixelCount:
                            communityInfoController.currentPixelCount,
                        accumulatePixelCount:
                            communityInfoController.accumulatePixelCount,
                        maxPixelCount: communityInfoController.maxPixelCount,
                        maxRankingCount: communityInfoController.maxRanking,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      MemberList(members: communityInfoController.members),
                      SizedBox(
                        height: 20,
                      ),
                      SignUpCommunityButton(
                        onTap: communityInfoController.signUpCommunity,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
