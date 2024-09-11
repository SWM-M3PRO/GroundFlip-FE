class CommunityModePixel {
  final int pixelId;
  final double latitude;
  final double longitude;
  final int communityId;
  final int communityColor;
  final int x;
  final int y;

  CommunityModePixel({
    required this.pixelId,
    required this.latitude,
    required this.longitude,
    required this.communityId,
    required this.communityColor,
    required this.x,
    required this.y,
  });

  factory CommunityModePixel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'pixelId': var pixelId,
        'latitude': var latitude,
        'longitude': var longitude,
        'communityId': var userId,
        'communityColor': var communityColor,
        'x': var x,
        'y': var y,
      } =>
        CommunityModePixel(
          pixelId: pixelId,
          latitude: latitude,
          longitude: longitude,
          communityId: userId,
          communityColor: communityColor is String
              ? int.parse(communityColor, radix: 16)
              : communityColor,
          x: x,
          y: y,
        ),
      _ => throw const FormatException('Failed to load Pixel')
    };
  }

  static List<CommunityModePixel> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) CommunityModePixel.fromJson(element),
    ];
  }
}
