import 'package:get/get.dart';

import '../service/community_service.dart';

class CommunityMemberController extends GetxController {
  final CommunityService communityService = CommunityService();
  final RxList members = [].obs;
  final RxBool isLoading = true.obs;
  late int communityId;

  init(int communityId) async {
    this.communityId = communityId;
    await loadMembers();
    isLoading.value = false;
  }

  loadMembersWithDelay() async {
    await Future.delayed(Duration(seconds: 1));
    await loadMembers();
  }

  loadMembers() async {
    var members = await communityService.getMembers(communityId, 30);
    this.members.assignAll(members);
  }
}
