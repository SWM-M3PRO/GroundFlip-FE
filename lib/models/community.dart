class Community {
  int communityRanking;
  String name;
  int communityColor;
  String backgroundImageUrl;
  int memberCount;
  int currentPixelCount;
  int accumulatePixelCount;
  int maxPixelCount;
  int maxRanking;
  String password;

  Community({
    required this.communityRanking,
    required this.name,
    required this.communityColor,
    required this.backgroundImageUrl,
    required this.memberCount,
    required this.currentPixelCount,
    required this.accumulatePixelCount,
    required this.maxPixelCount,
    required this.maxRanking,
    required this.password,
  });

  factory Community.fromJson(Map<String, dynamic> json) {
    return Community(
      communityRanking: json['communityRanking'],
      name: json['name'],
      communityColor: json['communityColor'] is String
          ? int.parse(json['communityColor'], radix: 16)
          : json['communityColor'],
      backgroundImageUrl: json['backgroundImageUrl'],
      memberCount: json['memberCount'],
      currentPixelCount: json['currentPixelCount'],
      accumulatePixelCount: json['accumulatePixelCount'],
      maxPixelCount: json['maxPixelCount'],
      maxRanking: json['maxRanking'],
      password: json['password'] ?? "",
    );
  }
}
