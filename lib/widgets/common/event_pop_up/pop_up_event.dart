import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';
import '../../../models/event.dart';
import '../../../utils/secure_storage.dart';
import 'event_image.dart';

class EventPopUp extends StatelessWidget {
  final List<Event> events;

  const EventPopUp({super.key, required this.events});

  @override
  Widget build(BuildContext context) {
    final PageController pageController = PageController();
    int currentPage = 0;

    return StatefulBuilder(
      builder: (BuildContext context, StateSetter setState) {
        return Container(
          decoration: BoxDecoration(),
          height: 380,
          child: Column(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                  child: PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        currentPage = index;
                      });
                    },
                    children: [
                      for (int i = 0; i < events.length; i++)
                        EventImage(
                          eventId: events[i].eventId,
                          imageUrl: events[i].eventImageUrl,
                          announcementId: events[i].announcementId,
                        ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () async {
                        await SecureStorage().secureStorage.write(
                              key: "hidePopupUntil",
                              value: DateTime.now().toString().split(" ")[0],
                            );
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        overlayColor: Colors.grey.withOpacity(0.2),
                      ),
                      child: Text(
                        '오늘 하루 보지 않기',
                        style: TextStyles.fs14w500cTextSecondary,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${currentPage + 1} / ${events.length}",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: TextButton.styleFrom(
                        overlayColor: Colors.grey.withOpacity(0.2),
                      ),
                      child: Text(
                        '닫기',
                        style: TextStyles.fs14w500cTextSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
        );
      },
    );
  }
}
