import 'package:get/get.dart';

import '../service/community_service.dart';

class CommunityMemberController extends GetxController {
  final CommunityService communityService = CommunityService();
  final RxList members = [].obs;
  final RxBool isLoading = true.obs;

  init(int communityId) async {
    print(1);
    var members = await communityService.getMembers(communityId);
    this.members.assignAll(members);
    isLoading.value = false;
  }

  reloadMembers() {}
}
