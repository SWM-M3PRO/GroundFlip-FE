import 'package:get/get.dart';

import '../service/community_service.dart';

class CommunityMemberController extends GetxController {
  final CommunityService communityService = CommunityService();
  final RxList members = [].obs;
  final RxBool isLoading = true.obs;
  late int communityId;

  init(int communityId) async {
    this.communityId = communityId;
    loadMembers();
    isLoading.value = false;
  }

  loadMembers() async {
    var members = await communityService.getMembers(communityId);
    this.members.assignAll(members);
  }
}
