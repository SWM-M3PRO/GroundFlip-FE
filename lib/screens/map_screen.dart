import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';
import '../controllers/pixel_info_controller.dart';
import '../controllers/walking_controller.dart';
import '../service/location_service.dart';
import '../service/location_service.dart';
import '../widgets/map/bottom_sheet/map_bottom_sheet.dart';
import '../widgets/map/current_location_button.dart';
import '../widgets/map/mode_change_toggle.dart';
import '../widgets/map/pixel_count_info.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.find<MapController>();
    Get.put(PixelInfoController());
    Get.put(WalkingController());

    return Scaffold(
      body: Obx(() {
        if (mapController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return Stack(
            children: [
              Obx(() {
                return GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(
                      LocationService().currentLocation!.latitude!,
                      LocationService().currentLocation!.longitude!,
                    ),
                    zoom: 16.0,
                  ),
                  onCameraMove: mapController.updateCameraPosition,
                  onCameraIdle: mapController.onCameraIdle,
                  onMapCreated: (GoogleMapController ctrl) {
                    mapController.googleMapController = ctrl;
                  },
                  style: mapController.mapStyle,
                  markers: Set<Marker>.of(mapController.markers),
                  polygons: Set<Polygon>.of(mapController.pixels),
                );
              }),
              Column(
                children: [
                  SizedBox(height: 60),
                  ModeChangeToggle(),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        PixelCountInfo(count: 128),
                        CurrentLocationButton(),
                      ],
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.11),
                ],
              ),
              MapBottomSheet(),
            ],
          );
        }
      }),
    );
  }
}
