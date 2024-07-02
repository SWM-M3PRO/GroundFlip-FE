class IndividualHistoryPixel {
  final int pixelId;
  final double latitude;
  final double longitude;
  final int x;
  final int y;

  IndividualHistoryPixel({
    required this.pixelId,
    required this.latitude,
    required this.longitude,
    required this.x,
    required this.y,
  });

  factory IndividualHistoryPixel.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
      'pixelId' : var pixelId,
      'latitude' : var latitude,
      'longitude' : var longitude,
      'x' : var x,
      'y' : var y,
      } =>
          IndividualHistoryPixel(
            pixelId: pixelId,
            latitude: latitude,
            longitude: longitude,
            x: x,
            y: y,),
      _ => throw const FormatException('Failed to load Pixel')
    };
  }

  static List<IndividualHistoryPixel> listFromJson(List<dynamic> jsonList) {
    return [
      for(var element in jsonList)
        IndividualHistoryPixel.fromJson(element),
    ];
  }
}