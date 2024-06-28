import 'package:dio/dio.dart';

import '../models/individual_pixel.dart';
import '../models/pixel_request.dart';
import '../utils/dio_service.dart';

class PixelService {
  static final PixelService _instance = PixelService._internal();
  static const double latitudePerPixel = 0.000724;
  static const double longitudePerPixel = 0.000909;
  static const double upperLeftLatitude = 37.666508;
  static const double upperLeftLongitude = 126.85411700000002;

  final Dio dio = DioService().getDio();

  PixelService._internal();

  factory PixelService() {
    return _instance;
  }

  Future<List<IndividualPixel>> getIndividualPixels({
    required double currentLatitude,
    required double currentLongitude,
    int radius = 1000,
  }) async {
    var response = await dio.get(
      '/pixels/individual-mode',
      queryParameters: {
        'current-latitude': currentLatitude,
        'current-longitude': currentLongitude,
        'radius': radius,
      },
    );

    return IndividualPixel.listFromJson(response.data['data']);
  }

  Future<void> occupyPixel({
    required int userId,
    required double currentLatitude,
    required double currentLongitude,
    int? communityId,
  }) async {
    Map<String, int> relativeCoordinate =
        _computeRelativeCoordinateByCoordinate(
            currentLatitude, currentLongitude,);
    PixelRequest pixelRequest = PixelRequest(
        userId: userId,
        x: relativeCoordinate['x']!,
        y: relativeCoordinate['y']!,
        communityId: communityId,);
    await dio.post('/pixels', data: pixelRequest.toJson());
  }

  Map<String, int> _computeRelativeCoordinateByCoordinate(
      double latitude, double longitude,) {
    int x = ((upperLeftLatitude - latitude) / latitudePerPixel).floor();
    int y = ((longitude - upperLeftLongitude) / longitudePerPixel).floor();
    return {'x': x, 'y': y};
  }
}
