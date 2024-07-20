class Ranking {
  int? userId;
  String? nickname;
  String? profileImageUrl;
  int? rank;
  int? currentPixelCount;

  Ranking({
    this.userId,
    this.nickname,
    this.profileImageUrl,
    this.rank,
    this.currentPixelCount,
  });

  Ranking.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    nickname = json['nickname'];
    profileImageUrl = json['profileImageUrl'];
    rank = json['rank'];
    currentPixelCount = json['currentPixelCount'];
  }
}
