import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../../controllers/walking_controller.dart';

class StepStats extends StatelessWidget {
  const StepStats({super.key});

  @override
  Widget build(BuildContext context) {
    var walkController = Get.find<WalkingController>();
    return Obx(
      () => Column(
        children: [
          Text(
            '${NumberFormat('###,###,###').format(walkController.getCurrentStep())} 걸음',
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 7, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.black,
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Text(
              '${NumberFormat('###,###,###').format(walkController.getCurrentCalorie())} kcal · ${NumberFormat('###,###,###').format(walkController.getCurrentTravelDistance())}km',
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}

class MapBottomSheet extends StatelessWidget {
  const MapBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    var walkController = Get.find<WalkingController>();
    return DraggableScrollableSheet(
      controller: walkController.draggableController,
      snap: true,
      initialChildSize: 0.11,
      minChildSize: 0.11,
      maxChildSize: 0.6,
      builder: (BuildContext context, scrollController) {
        return Container(
          clipBehavior: Clip.hardEdge,
          decoration: BoxDecoration(
            color: AppColors.backgroundSecondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: CustomScrollView(
            controller: scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Center(
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.backgroundThird,
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                    ),
                    height: 4,
                    width: 40,
                    margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Obx(
                      () => Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            walkController.getCurrentStep(),
                            style: TextStyles.fs24w900cTextPrimary,
                          ),
                          Text(
                            ' 걸음',
                            style: TextStyles.fs17w400cTextSecondary,
                          ),
                          Spacer(),
                          Text(
                            '${walkController.getCurrentCalorie()} kcal · ${walkController.getCurrentTravelDistance()}km',
                            style: TextStyles.fs17w400cTextSecondary,
                          ),
                        ],
                      ),
                    )),
              ),
              SliverList.list(
                children: const [
                  ListTile(title: Text('Jane Doe')),
                  ListTile(title: Text('Jack Reacher')),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
