import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import '../models/achievement/achievement_element.dart';
import '../models/achievement/user_achievements.dart';
import '../service/achievement_service.dart';
import '../utils/user_manager.dart';

class AchievementController extends GetxController {
  final AchievementService achievementService = AchievementService();

  final RxList<AchievementElement> achievementElements =
      <AchievementElement>[].obs;
  final RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await updateAchievementInfo();
  }

  updateAchievementInfo() async {
    UserAchievements userAchievements =
        await achievementService.getUserAchievements(UserManager().userId!, 3);
    achievementElements.assignAll(userAchievements.recentAchievements);
    isLoading.value = false;
  }
}
