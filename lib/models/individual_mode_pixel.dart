class IndividualModePixel {
  final int pixelId;
  final double latitude;
  final double longitude;
  final int userId;
  final int x;
  final int y;

  IndividualModePixel({
      required this.pixelId,
      required this.latitude,
      required this.longitude,
      required this.userId,
      required this.x,
      required this.y,
  });

  factory IndividualModePixel.fromJson(Map<String, dynamic> json) {
      return switch (json) {
        {
          'pixelId' : var pixelId,
          'latitude' : var latitude,
          'longitude' : var longitude,
          'userId' : var userId,
          'x' : var x,
          'y' : var y,
      } =>
            IndividualModePixel(
                pixelId: pixelId,
                latitude: latitude,
                longitude: longitude,
                userId: userId,
                x: x,
                y: y,),
      _ => throw const FormatException('Failed to load Pixel')
      };
  }

  static List<IndividualModePixel> listFromJson(List<dynamic> jsonList) {
    return [
      for(var element in jsonList)
        IndividualModePixel.fromJson(element),
    ];
  }
}
