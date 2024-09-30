class Region {
  final int regionId;
  final double latitude;
  final double longitude;
  final String regionName;
  final int count;
  final String regionLevel;

  Region({
    required this.regionId,
    required this.latitude,
    required this.longitude,
    required this.regionName,
    required this.count,
    required this.regionLevel,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'regionId': var regionId,
        'latitude': var latitude,
        'longitude': var longitude,
        'regionName': var regionName,
        'count': var count,
        'regionLevel': var regionLevel,
      } =>
        Region(
          regionId: regionId,
          latitude: latitude,
          longitude: longitude,
          regionName: regionName,
          count: count,
          regionLevel: regionLevel,
        ),
      _ => throw const FormatException('Failed to load Region')
    };
  }

  static List<Region> listFromJson(List<dynamic> jsonList) {
    return [
      for (var element in jsonList) Region.fromJson(element),
    ];
  }
}
