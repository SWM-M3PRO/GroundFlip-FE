class Achievement {
  final int achievementId;
  final String achievementName;
  final String badgeImageUrl;
  final DateTime? obtainedDate;
  final int categoryId;
  final int currentValue;
  final int completionGoal;
  final String achievementDetail;
  final int? reward;
  final bool isRewardReceived;

  Achievement({
    required this.achievementId,
    required this.achievementName,
    required this.badgeImageUrl,
    required this.obtainedDate,
    required this.categoryId,
    required this.currentValue,
    required this.completionGoal,
    required this.achievementDetail,
    required this.reward,
    required this.isRewardReceived,
  });

  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      achievementId: json['achievementId'] as int,
      achievementName: json['achievementName'] as String,
      badgeImageUrl: json['badgeImageUrl'] as String,
      obtainedDate: json['obtainedDate'] != null
          ? DateTime.parse(json['obtainedDate'] as String)
          : null,
      categoryId: json['categoryId'] as int,
      currentValue: json['currentValue'] as int,
      completionGoal: json['completionGoal'] as int,
      achievementDetail: json['achievementDetail'] as String,
      reward: json['reward'] as int,
      isRewardReceived: json['isRewardReceived'] as bool,
    );
  }
}
