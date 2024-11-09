class AchievementCategory {
  final int categoryId;
  final String categoryName;
  final String categoryImageUrl;

  AchievementCategory({
    required this.categoryId,
    required this.categoryName,
    required this.categoryImageUrl,
  });

  factory AchievementCategory.fromJson(Map<String, dynamic> json) {
    return AchievementCategory(
      categoryId: json['categoryId'] as int,
      categoryName: json['categoryName'] as String,
      categoryImageUrl: json['categoryImageUrl'] as String,
    );
  }

  static List<AchievementCategory> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) AchievementCategory.fromJson(element),
    ];
  }
}
