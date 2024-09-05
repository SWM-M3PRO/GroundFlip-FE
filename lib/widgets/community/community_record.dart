import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class CommunityRecord extends StatelessWidget {
  final RxInt currentPixelCount;
  final RxInt accumulatePixelCount;
  final RxInt maxPixelCount;
  final RxInt maxRankingCount;

  const CommunityRecord({
    super.key,
    required this.currentPixelCount,
    required this.accumulatePixelCount,
    required this.maxPixelCount,
    required this.maxRankingCount,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            CommunityRecordElement(
              title: "현재 px",
              content: currentPixelCount.value,
              iconImageUrl: "assets/images/current_pixel_icon.png",
            ),
            SizedBox(
              width: 10,
            ),
            CommunityRecordElement(
              title: "누적 px",
              content: accumulatePixelCount.value,
              iconImageUrl: "assets/images/accumulate_pixel_icon.png",
            ),
          ],
        ),
        SizedBox(
          height: 20,
        ),
        Row(
          children: [
            CommunityRecordElement(
              title: "하루 최대 px",
              content: maxPixelCount.value,
              iconImageUrl: "assets/images/max_pixel_icon.png",
            ),
            SizedBox(
              width: 10,
            ),
            CommunityRecordElement(
              title: "최고 랭킹",
              content: maxRankingCount.value,
              iconImageUrl: "assets/images/max_ranking_icon.png",
            ),
          ],
        ),
      ],
    );
  }
}

class CommunityRecordElement extends StatelessWidget {
  final String title;
  final int content;
  final String iconImageUrl;

  const CommunityRecordElement({
    super.key,
    required this.title,
    required this.content,
    required this.iconImageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      title,
                      style: TextStyles.fs14w400cTextSecondary,
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      NumberFormat('###,###,###').format(content),
                      style: TextStyles.fs20w700cTextPrimary,
                    ),
                  ),
                ],
              ),
              Image.asset(
                iconImageUrl,
                width: 48,
                height: 48,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
