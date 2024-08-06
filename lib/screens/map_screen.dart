import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/app_colors.dart';
import '../controllers/map_controller.dart';
import '../controllers/pixel_info_controller.dart';
import '../controllers/walking_controller.dart';
import '../enums/pixel_mode.dart';
import '../service/location_service.dart';
import '../widgets/map/bottom_sheet/map_bottom_sheet.dart';
import '../widgets/map/current_location_button.dart';
import '../widgets/map/filter_button.dart';
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
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else {
          return Stack(
            children: [
              Obx(() {
                return Listener(
                  onPointerDown: (e) {
                    mapController.isCameraTrackingUser = false.obs;
                  },
                  child: GoogleMap(
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
                    myLocationEnabled: true,
                    style: mapController.mapStyle,
                    markers: Set<Marker>.of(mapController.markers),
                    polygons: Set<Polygon>.of(mapController.pixels),
                  ),
                );
              }),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    SizedBox(height: 60),
                    ModeChangeToggle(),
                    SizedBox(
                      height: 10,
                    ),
                    Obx(() {
                      if (mapController.currentPixelMode.value ==
                          PixelMode.individualHistory) {
                        return Align(
                            alignment: Alignment.topRight,
                            child: FilterButton(),);
                      } else {
                        return Container();
                      }
                    }),
                    Spacer(),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
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
              ),
              MapBottomSheet(),
            ],
          );
        }
      }),
    );
  }
}
