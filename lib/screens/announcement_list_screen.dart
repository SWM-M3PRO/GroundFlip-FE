import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/announcement_controller.dart';
import '../widgets/common/app_bar.dart';

class AnnouncementListScreen extends StatelessWidget {
  AnnouncementListScreen({super.key});

  final AnnouncementController controller = Get.put(AnnouncementController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        title: AppBarTitle(
          title: '공지사항',
        ),
        leadingWidth: 40,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: () {
              Get.back();
            },
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25.0),
                  child: ListView.builder(
                    controller: controller.scrollController,
                    itemCount: controller.items.length + 1,
                    itemBuilder: (context, index) {
                      if (index < controller.items.length) {
                        return controller.items[index];
                      } else {
                        return Center(
                          child: controller.isLoading.value
                              ? CircularProgressIndicator()
                              : SizedBox.shrink(),
                        );
                      }
                    },
                  ),
                )),
          ),
        ],
      ),
    );
  }
}
