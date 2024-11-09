import 'package:get/get.dart';

import '../models/achievement/achievement.dart';
import '../models/achievement/achievement_category.dart';
import '../models/achievement/achievement_element.dart';
import '../models/achievement/achievements_by_category.dart';
import '../models/achievement/user_achievements.dart';
import '../screens/achievement_info_screen.dart';
import '../screens/category_achievement_list_screen.dart';
import '../screens/my_achievement_screen.dart';
import '../service/achievement_service.dart';
import '../utils/user_manager.dart';

class AchievementController extends GetxController {
  final AchievementService achievementService = AchievementService();

  final RxList<AchievementElement> achievementElements =
      <AchievementElement>[].obs;
  final RxList<AchievementCategory> achievementCategories =
      <AchievementCategory>[].obs;
  final RxBool isLoading = true.obs;

  @override
  Future<void> onInit() async {
    super.onInit();
    await updateAchievementInfo();
  }

  updateAchievementInfo() async {
    UserAchievements userAchievements =
        await achievementService.getUserAchievements(UserManager().userId!, 3);
    List<AchievementCategory> categories =
        await achievementService.getCategories();
    achievementElements.assignAll(userAchievements.recentAchievements);
    achievementCategories.assignAll(categories);
    isLoading.value = false;
  }

  moveToMyAchievementScreen() async {
    UserAchievements userAchievements = await achievementService
        .getUserAchievements(UserManager().userId!, null);
    Get.to(
      MyAchievementScreen(achievements: userAchievements.recentAchievements),
    );
  }

  moveToAchievementInfoScreen(int achievementId) async {
    Achievement achievement = await achievementService.getAchievementInfo(
      UserManager().userId!,
      achievementId,
    );
    Get.to(AchievementInfoScreen(achievement: achievement));
  }

  moveToCategoryAchievementListScreen(int categoryId) async {
    AchievementsByCategory achievementsByCategory = await achievementService
        .getAchievementsByCategory(UserManager().userId!, categoryId);
    Get.to(
      CategoryAchievementListScreen(
        achievementsByCategory: achievementsByCategory,
      ),
    );
  }
}
