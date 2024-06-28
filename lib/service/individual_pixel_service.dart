import 'package:dio/dio.dart';

import '../models/individual_pixel.dart';
import '../utils/dio_service.dart';

class IndividualPixelService {
  static final IndividualPixelService _instance =
      IndividualPixelService._internal();

  final Dio dio = DioService().getDio();

  IndividualPixelService._internal();

  factory IndividualPixelService() {
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
