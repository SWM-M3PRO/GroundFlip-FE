class AchievementElement {
  final int achievementId;
  final String achievementName;
  final String badgeImageUrl;
  final DateTime? obtainedDate;
  final int categoryId;

  AchievementElement({
    required this.achievementId,
    required this.achievementName,
    required this.badgeImageUrl,
    required this.obtainedDate,
    required this.categoryId,
  });

  factory AchievementElement.fromJson(Map<String, dynamic> json) {
    return AchievementElement(
      achievementId: json['achievementId'] as int,
      achievementName: json['achievementName'] as String,
      badgeImageUrl: json['badgeImageUrl'] as String,
      obtainedDate: json['obtainedDate'] != null
          ? DateTime.parse(json['obtainedDate'] as String)
          : null,
      categoryId: json['categoryId'] as int,
    );
  }

  static List<AchievementElement> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) AchievementElement.fromJson(element),
    ];
  }
}
