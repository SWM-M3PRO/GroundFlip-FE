import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../constants/app_colors.dart';
import '../controllers/my_place_controller.dart';
import '../service/location_service.dart';
import '../widgets/map/current_location_button.dart';

class MyPlaceScreen extends StatelessWidget {
  MyPlaceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MyPlaceController myPlaceController = Get.put(MyPlaceController());
    const double mapPinHeight = 60;
    const double mapPinWidth = mapPinHeight * 0.85;

    final PreferredSizeWidget appBar = AppBar(
      leading: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios,
          color: AppColors.buttonColor,
        ),
      ),
      backgroundColor: AppColors.background,
      title: Text(
        '내 장소 등록',
        style: TextStyle(
          color: AppColors.textPrimary,
        ),
      ),
    );
    final Widget mapPinImage = Image.asset(
      'assets/images/green_map_pin.png',
      height: mapPinHeight,
      width: mapPinWidth,
    );

    final double appBarHeight = appBar.preferredSize.height;

    return Scaffold(
      appBar: appBar,
      body: Obx(() {
        if (myPlaceController.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primary,
            ),
          );
        } else {
          return Stack(
            clipBehavior: Clip.hardEdge,
            children: [
              Obx(
                () {
                  return GoogleMap(
                    mapType: MapType.normal,
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        LocationService().currentLocation!.latitude!,
                        LocationService().currentLocation!.longitude!,
                      ),
                      zoom: 16.0,
                    ),
                    onMapCreated: (GoogleMapController ctrl) {
                      myPlaceController.googleMapController = ctrl;
                    },
                    myLocationEnabled: false,
                    zoomControlsEnabled: false,
                    style: myPlaceController.mapStyle,
                    markers: Set<Marker>.of(myPlaceController.markers),
                    onCameraIdle: () async {
                      final GoogleMapController? controller =
                          myPlaceController.googleMapController;
                      LatLng center = LatLng(
                        LocationService().currentLocation!.latitude!,
                        LocationService().currentLocation!.longitude!,
                      );
                      if (controller != null) {
                        LatLngBounds visibleRegion =
                            await controller.getVisibleRegion();
                        center = LatLng(
                          (visibleRegion.northeast.latitude +
                                  visibleRegion.southwest.latitude) /
                              2,
                          (visibleRegion.northeast.longitude +
                                  visibleRegion.southwest.longitude) /
                              2,
                        );
                      }
                      myPlaceController.updateCoordinate(center);
                    },
                  );
                },
              ),
              Positioned(
                top: (MediaQuery.of(context).size.height - appBarHeight) / 2 -
                    (mapPinHeight - 2),
                left:
                    (MediaQuery.of(context).size.width / 2) - (mapPinWidth / 2),
                child: mapPinImage,
              ),
              Positioned(
                bottom: 15,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 10.0),
                      child: CurrentLocationButton(
                        checkController: "myPlace",
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: GestureDetector(
                        onTap: () {
                          myPlaceController.openMyPlaceBottomSheet();
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width - 20,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: AppColors.primary,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: Center(
                              child: Text(
                                '등록',
                                style: TextStyle(
                                  color: AppColors.textBlack,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
