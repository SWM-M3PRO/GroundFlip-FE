import 'achievement_element.dart';

class UserAchievements {
  final int achievementCount;
  final List<AchievementElement> recentAchievements;

  UserAchievements({
    required this.achievementCount,
    required this.recentAchievements,
  });

  factory UserAchievements.fromJson(Map<String, dynamic> json) {
    return UserAchievements(
      achievementCount: json['achievementCount'] as int,
      recentAchievements: AchievementElement.listFromJson(
        json['recentAchievements'] as List<dynamic>,
      ),
    );
  }
}
