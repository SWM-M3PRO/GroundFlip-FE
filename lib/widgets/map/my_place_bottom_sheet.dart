
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/my_place_controller.dart';
import '../../service/my_place_service.dart';
import 'place_change_button.dart';

// ignore: must_be_immutable
class MyPlaceBottomSheet extends StatelessWidget {
  MyPlaceBottomSheet({
    super.key,
  });

  final MyPlaceService myPlaceService = MyPlaceService();
  final MyPlaceController myPlaceController = Get.find<MyPlaceController>();
  final box = GetStorage();

  int selectedNumber = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 250,
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    "즐겨찾기 장소 등록",
                    style: TextStyles.fs20w700cTextPrimary,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.backgroundThird,
                    shape: CircleBorder(),
                    minimumSize: Size(36, 36),
                    padding: EdgeInsets.all(0),
                    iconColor: AppColors.textPrimary,
                  ),
                  child: Icon(Icons.close),
                ),
              ],
            ),
            SizedBox(
              height: 5,
            ),
            SizedBox(
              height: 20,
            ),
            PlaceChangeButton(),
            Spacer(),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: InkWell(
                borderRadius: BorderRadius.circular(16),
                onTap: () async{
                  await myPlaceService.putMyPlaceInfo(
                      myPlaceController.myPlaceName.value,
                      myPlaceController.selectedLatitude.value,
                      myPlaceController.selectedLongitude.value,);

                  await myPlaceController.writeLocalStorage(
                      myPlaceController.myPlaceName.value,
                      myPlaceController.selectedLatitude.value,
                      myPlaceController.selectedLongitude.value,);

                  Get.back();
                  Get.back();
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.primary,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Center(
                      child: Text(
                        '장소등록',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.textPrimary,
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
    );
  }
}
