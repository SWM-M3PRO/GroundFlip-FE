
import 'package:location/location.dart';

class LocationService {
  static final LocationService _instance = LocationService._internal();
  final Location location = Location();
  LocationData? currentLocation;

  LocationService._internal();

  factory LocationService() {
    return _instance;
  }

  initCurrentLocation() async {
    currentLocation = await location.getLocation();
  }

  initBackgroundLocation() {
    location.enableBackgroundMode(enable: true);
    location.changeNotificationOptions(
      title: '땅 따먹기 중!',
      subtitle: '백그라운드 작동 중입니다.',
      iconName: 'drawable/ground_flip_app_icon',
    );
  }
}
