import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/group_controller.dart';
import '../widgets/group/group_action_button.dart';
import '../widgets/group/group_image.dart';
import '../widgets/group/group_info.dart';
import '../widgets/group/group_record.dart';
import '../widgets/group/member/member_list.dart';

class GroupScreen extends StatelessWidget {
  final int groupId;
  final bool isTap;

  const GroupScreen({super.key, required this.groupId, required this.isTap});

  @override
  Widget build(BuildContext context) {
    final GroupController groupController = Get.put(GroupController());
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
                        groupController.groupName.value,
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
                            groupController.groupName.value,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                background: GroupImage(
                  imageUrl: groupController.groupImageUrl.value,
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
                GroupInfo(
                  memberCount: groupController.memberCount,
                  groupColor: groupController.groupColor,
                  weeklyRanking: groupController.weeklyRanking,
                ),
                SizedBox(
                  height: 20,
                ),
                GroupRecord(
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
                GroupActionButton(
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
