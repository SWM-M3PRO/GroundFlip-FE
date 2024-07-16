import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../controllers/map_controller.dart';
import '../controllers/pixel_info_controller.dart';
import '../controllers/walking_controller.dart';
import '../widgets/map/mode_change_button.dart';
import '../widgets/map/step_stats.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController mapController = Get.put(MapController());
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
              GoogleMap(
                mapType: MapType.normal,
                myLocationButtonEnabled: true,
                myLocationEnabled: true,
                initialCameraPosition: CameraPosition(
                  target: LatLng(
                    mapController.currentLocation.latitude!,
                    mapController.currentLocation.longitude!,
                  ),
                  zoom: 16.0,
                ),
                onCameraMove: mapController.updateCameraPosition,
                onCameraIdle: mapController.onCameraIdle,
                onMapCreated: (GoogleMapController ctrl) {
                  mapController.completer.complete(ctrl);
                },
                style: mapController.mapStyle,
                markers: Set<Marker>.of(mapController.markers),
                polygons: Set<Polygon>.of(mapController.pixels),
              ),
              Column(
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 65.0),
                  ),
                  ModeChangeButton(),
                  const Padding(
                    padding: EdgeInsets.only(bottom: 32),
                    child: StepStats(),
                  ),
                ],
              ),
            ],
          );
        }
      }),
    );
  }
}
