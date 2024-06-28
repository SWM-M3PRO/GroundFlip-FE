import 'package:dio/dio.dart';

import '../models/individual_pixel.dart';
import '../utils/dio_service.dart';

class PixelService {
  static final PixelService _instance =
      PixelService._internal();

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
}
