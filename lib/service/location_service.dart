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
}
