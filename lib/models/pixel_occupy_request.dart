class PixelOccupyRequest {
  final int userId;
  final int? communityId;
  final int x;
  final int y;

  PixelOccupyRequest({
    required this.userId,
    this.communityId,
    required this.x,
    required this.y,
  });

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "communityId": communityId,
        "x": x,
        "y": y,
      };
}
