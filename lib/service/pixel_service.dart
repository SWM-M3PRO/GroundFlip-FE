import 'package:dio/dio.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:intl/intl.dart';

import '../models/community_mode_pixel.dart';
import '../models/community_mode_pixel_info.dart';
import '../models/individual_history_pixel.dart';
import '../models/individual_history_pixel_info.dart';
import '../models/individual_mode_pixel.dart';
import '../models/individual_mode_pixel_info.dart';
import '../models/pixel_occupy_request.dart';
import '../models/region.dart';
import '../models/user_step_response.dart';
import '../utils/dio_service.dart';
import '../utils/user_manager.dart';

class PixelService {
  static final PixelService _instance = PixelService._internal();
  static const double latitudePerPixel = 0.000724;
  static const double longitudePerPixel = 0.000909;
  static const double upperLeftLatitude = 38.240675;
  static const double upperLeftLongitude = 125.905952;

  final Dio dio = DioService().getDio();

  PixelService._internal();

  factory PixelService() {
    return _instance;
  }

  Future<List<IndividualModePixel>> getIndividualModePixels({
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

    return IndividualModePixel.listFromJson(response.data['data']);
  }

  Future<List<Region>> getIndividualModeClusteredPixels({
    required double currentLatitude,
    required double currentLongitude,
    int radius = 1000,
  }) async {
    var response = await dio.get(
      '/pixels/individual-mode/clustered',
      queryParameters: {
        'current-latitude': currentLatitude,
        'current-longitude': currentLongitude,
        'radius': radius,
      },
    );

    return Region.listFromJson(response.data['data']);
  }

  Future<List<IndividualHistoryPixel>> getIndividualHistoryPixels({
    required double currentLatitude,
    required double currentLongitude,
    required int userId,
    int radius = 1000,
    String? lookUpDate,
  }) async {
    var response = await dio.get(
      '/pixels/individual-history',
      queryParameters: {
        'current-latitude': currentLatitude,
        'current-longitude': currentLongitude,
        'radius': radius,
        'user-id': userId,
        'lookup-date': lookUpDate,
      },
    );

    return IndividualHistoryPixel.listFromJson(response.data['data']);
  }

  Future<List<Region>> getIndividualHistoryClusteredPixels({
    required double currentLatitude,
    required double currentLongitude,
    required int userId,
    int radius = 1000,
  }) async {
    var response = await dio.get(
      '/pixels/individual-history/clustered',
      queryParameters: {
        'current-latitude': currentLatitude,
        'current-longitude': currentLongitude,
        'user-id': userId,
        'radius': radius,
      },
    );

    return Region.listFromJson(response.data['data']);
  }

  Future<List<CommunityModePixel>> getCommunityModePixels({
    required double currentLatitude,
    required double currentLongitude,
    int radius = 1000,
  }) async {
    var response = await dio.get(
      '/pixels/community-mode',
      queryParameters: {
        'current-latitude': currentLatitude,
        'current-longitude': currentLongitude,
        'radius': radius,
      },
    );

    return CommunityModePixel.listFromJson(response.data['data']);
  }

  Future<List<Region>> getCommunityModeClusteredPixels({
    required double currentLatitude,
    required double currentLongitude,
    int radius = 1000,
  }) async {
    var response = await dio.get(
      '/pixels/community-mode/clustered',
      queryParameters: {
        'current-latitude': currentLatitude,
        'current-longitude': currentLongitude,
        'radius': radius,
      },
    );

    return Region.listFromJson(response.data['data']);
  }

  Future<IndividualModePixelInfo> getIndividualModePixelInfo({
    required int pixelId,
  }) async {
    var response = await dio.get(
      '/pixels/individual-mode/$pixelId',
    );

    return IndividualModePixelInfo.fromJson(response.data['data']);
  }

  Future<CommunityModePixelInfo> getCommunityModePixelInfo({
    required int pixelId,
  }) async {
    var response = await dio.get(
      '/pixels/community-mode/$pixelId',
    );

    return CommunityModePixelInfo.fromJson(response.data['data']);
  }

  Future<IndividualHistoryPixelInfo> getIndividualHistoryPixelInfo({
    required int pixelId,
    required int userId,
  }) async {
    var response = await dio.get(
      '/pixels/individual-history/$pixelId',
      queryParameters: {
        'user-id': userId,
      },
    );

    return IndividualHistoryPixelInfo.fromJson(response.data['data']);
  }

  Future<void> occupyPixel({
    required int userId,
    required double currentLatitude,
    required double currentLongitude,
    int? communityId,
  }) async {
    Map<String, int> relativeCoordinate = computeRelativeCoordinateByCoordinate(
      currentLatitude,
      currentLongitude,
    );
    PixelOccupyRequest pixelRequest = PixelOccupyRequest(
      userId: userId,
      x: relativeCoordinate['x']!,
      y: relativeCoordinate['y']!,
      communityId: communityId,
    );
    await dio.post('/pixels', data: pixelRequest.toJson());

    FirebaseAnalytics.instance.logEvent(
      name: "occupyPixel",
      parameters: {
        "x": relativeCoordinate['x']!,
        "y": relativeCoordinate['y']!,
      },
    );
  }

  Map<String, int> computeRelativeCoordinateByCoordinate(
    double latitude,
    double longitude,
  ) {
    int x = ((upperLeftLatitude - latitude) / latitudePerPixel).floor();
    int y = ((longitude - upperLeftLongitude) / longitudePerPixel).floor();
    return {'x': x, 'y': y};
  }

  Future<List<int>> getDailyPixelsInInterval(
    DateTime startDate,
    DateTime endDate,
  ) async {
    int? userId = UserManager().getUserId();
    var response = await dio.get(
      '/pixels/count/daily/$userId',
      queryParameters: {
        "start-date": DateFormat('yyyy-MM-dd').format(startDate),
        "end-date": DateFormat('yyyy-MM-dd').format(endDate),
      },
    );
    List<int>? result =
        DailyPixel.fromJson(response.data['data']).dailyPixelCounts ?? [];
    if (result.isEmpty) {
      return [0, 0, 0, 0, 0, 0, 0];
    } else {
      return result;
    }
  }
}
