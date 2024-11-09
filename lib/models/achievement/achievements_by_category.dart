import 'achievement_element.dart';

class AchievementsByCategory {
  final int categoryId;
  final String categoryName;
  final String categoryImageUrl;
  final String categoryDescription;
  final List<AchievementElement> achievements;

  AchievementsByCategory({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImageUrl,
    required this.categoryDescription,
    required this.achievements,
  });

  factory AchievementsByCategory.fromJson(Map<String, dynamic> json) {
    return AchievementsByCategory(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      categoryImageUrl: json['categoryImageUrl'] as String,
      categoryDescription: json['categoryDescription'] as String,
      achievements: AchievementElement.listFromJson(
        json['achievements'] as List<dynamic>,
      ),
    );
  }
}
