import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/community_member_controller.dart';
import '../widgets/community/member/member_list.dart';

class CommunityMemberScreen extends StatelessWidget {
  final String communityName;
  final int communityId;

  CommunityMemberScreen({
    super.key,
    required this.communityName,
    required this.communityId,
  });

  @override
  Widget build(BuildContext context) {
    final CommunityMemberController communityMemberController =
        Get.put(CommunityMemberController());
    communityMemberController.init(communityId);
    List members = communityMemberController.members;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: Text(
          communityName,
          style: TextStyles.fs20w700cTextPrimary,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          color: AppColors.buttonColor,
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: Obx(() {
        if (communityMemberController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else {
          return RefreshIndicator(
            color: AppColors.primary,
            backgroundColor: AppColors.backgroundThird,
            onRefresh: () async {
              await communityMemberController.loadMembersWithDelay();
            },
            child: ListView(
              children: [
                for (int i = 0; i < members.length; i++)
                  MemberListElement(
                    ranking: members[i],
                    isLast: i == members.length - 1 ? true : false,
                  ),
              ],
            ),
          );
        }
      }),
    );
  }
}
