class Ranking {
  int userId;
  String nickname;
  String? profileImageUrl;
  int? rank;
  int? currentPixelCount;

  Ranking({
    required this.userId,
    required this.nickname,
    this.profileImageUrl,
    required this.rank,
    required this.currentPixelCount,
  });

  factory Ranking.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': var userId,
        'nickname': var nickname,
        'profileImageUrl': var profileImageUrl,
        'rank': var rank,
        'currentPixelCount': var currentPixelCount,
      } =>
        Ranking(
          userId: userId,
          nickname: nickname,
          profileImageUrl: profileImageUrl,
          rank: rank,
          currentPixelCount: currentPixelCount,
        ),
      _ => throw const FormatException('Failed to load Ranking')
    };
  }

  static List<Ranking> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) Ranking.fromJson(element),
    ];
  }
}
