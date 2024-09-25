import '../enums/ranking_kind.dart';

class Ranking {
  int id;
  String? name;
  String? profileImageUrl;
  int? rank;
  int? currentPixelCount;
  RankingKind kind;

  Ranking({
    required this.id,
    this.name,
    this.profileImageUrl,
    required this.rank,
    required this.currentPixelCount,
    required this.kind,
  });

  factory Ranking.fromJsonUser(Map<String, dynamic> json) {
    return switch (json) {
      {
        'userId': var userId,
        'nickname': var nickname,
        'profileImageUrl': var profileImageUrl,
        'rank': var rank,
        'currentPixelCount': var currentPixelCount,
      } =>
        Ranking(
          id: userId,
          name: nickname,
          profileImageUrl: profileImageUrl,
          rank: rank,
          currentPixelCount: currentPixelCount,
          kind: RankingKind.user,
        ),
      _ => throw const FormatException('Failed to load Ranking')
    };
  }

  factory Ranking.fromJsonCommunity(Map<String, dynamic> json) {
    return switch (json) {
      {
        'communityId': var communityId,
        'name': var name,
        'profileImageUrl': var profileImageUrl,
        'rank': var rank,
        'currentPixelCount': var currentPixelCount,
      } =>
        Ranking(
          id: communityId,
          name: name,
          profileImageUrl: profileImageUrl,
          rank: rank,
          currentPixelCount: currentPixelCount,
          kind: RankingKind.community,
        ),
      _ => throw const FormatException('Failed to load Ranking')
    };
  }

  static List<Ranking> listFromJsonUser(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) Ranking.fromJsonUser(element),
    ];
  }

  static List<Ranking> listFromJsonCommunity(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) Ranking.fromJsonCommunity(element),
    ];
  }
}
