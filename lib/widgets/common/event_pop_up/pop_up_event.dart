import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/text_styles.dart';
import 'event_image.dart';

class EventPopUp extends StatelessWidget {
  const EventPopUp({super.key});

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
                      EventImage(
                        imageUrl:
                            "https://ground-flip-prod-storage.s3.ap-northeast-2.amazonaws.com/event/%E1%84%92%E1%85%A1%E1%86%AB%E1%84%80%E1%85%A1%E1%86%BC%E1%84%8B%E1%85%B5%E1%84%87%E1%85%A6%E1%86%AB%E1%84%90%E1%85%B32.png",
                        eventId: 1,
                      ),
                      EventImage(
                        imageUrl:
                            "https://s3.ap-northeast-2.amazonaws.com/ground-flip-prod-storage/static/66ade0ab-833f-43d0-811a-7c228dcbebec.jpg",
                        eventId: 1,
                      ),
                      EventImage(
                        imageUrl:
                            "https://ground-flip-prod-storage-resized.s3.ap-northeast-2.amazonaws.com/resized-static/da05e0cc-6831-45c6-aeee-2597c5a04d07%23%23%23626.jpg",
                        eventId: 1,
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
                      onPressed: () {},
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
                        "${currentPage + 1} / 3", // 현재 페이지 (1부터 시작)와 전체 페이지 수
                        style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textSecondary),
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
