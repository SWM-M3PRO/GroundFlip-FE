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

class CommunityScreen extends StatelessWidget {
  final int groupId;
  final bool isTap;

  const CommunityScreen(
      {super.key, required this.groupId, required this.isTap});

  @override
  Widget build(BuildContext context) {
    final CommunityController groupController = Get.put(CommunityController());
    groupController.init(groupId);
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          expandedHeight: 350.0,
          floating: false,
          pinned: true,
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          leading: isTap
              ? null
              : IconButton(
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
                        groupController.name.value,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    : Align(
                        alignment: Alignment.bottomLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            groupController.name.value,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                background: CommunityImage(
                  imageUrl: groupController.imageUrl.value,
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
                  memberCount: groupController.memberCount,
                  communityColor: groupController.communityColor,
                  weeklyRanking: groupController.communityRanking,
                ),
                SizedBox(
                  height: 20,
                ),
                CommunityRecord(
                  currentPixelCount: groupController.currentPixelCount,
                  accumulatePixelCount: groupController.accumulatePixelCount,
                  maxPixelCount: groupController.maxPixelCount,
                  maxRankingCount: groupController.maxRankingCount,
                ),
                SizedBox(
                  height: 20,
                ),
                MemberList(members: groupController.members),
                SizedBox(
                  height: 20,
                ),
                CommunityActionButton(
                  isJoin: groupController.isJoin.value,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
