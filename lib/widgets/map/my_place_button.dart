import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/map_controller.dart';
import '../../screens/my_place_screen.dart';
import 'my_place_button_icon.dart';

class MyPlaceButton extends StatelessWidget {
  MyPlaceButton({super.key});

  @override
  Widget build(BuildContext context) {
    MapController mapController = Get.find<MapController>();

    return Obx(() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              mapController.myPlaceButtonVisible.value =
                  !mapController.myPlaceButtonVisible.value;
            },
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.backgroundSecondary,
              ),
              child: Icon(
                Icons.star,
                size: 20,
                color: AppColors.buttonColor,
              ),
            ),
          ),
          SizedBox(height: 10),
          AnimatedContainer(
            duration: Duration(milliseconds: 500),
            curve: Curves.easeInOut,
            height: mapController.myPlaceButtonVisible.value ? 210 : 0,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  MyPlaceButtonIcon(
                    icon: Icons.home,
                    place: 'HOME',
                  ),

                  MyPlaceButtonIcon(
                    icon: Icons.work,
                    place: 'COMPANY',
                  ),

                  MyPlaceButtonIcon(
                    icon: Icons.flag,
                    place: 'ELSE',
                  ),

                  GestureDetector(
                    onTap: () {
                      Get.to(()=>MyPlaceScreen());
                    },
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: AppColors.backgroundSecondary,
                      ),
                      child: Icon(
                        Icons.add,
                        size: 20,
                        color: AppColors.buttonColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    });
  }
}
