class Region {
  final int regionId;
  final double latitude;
  final double longitude;
  final String regionName;
  final int count;

  Region({
    required this.regionId,
    required this.latitude,
    required this.longitude,
    required this.regionName,
    required this.count,
  });

  factory Region.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'regionId': var regionId,
        'latitude': var latitude,
        'longitude': var longitude,
        'regionName': var regionName,
        'count': var count,
      } =>
        Region(
          regionId: regionId,
          latitude: latitude,
          longitude: longitude,
          regionName: regionName,
          count: count,
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
