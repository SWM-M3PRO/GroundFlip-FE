import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class GroupRecord extends StatelessWidget {
  final int currentPixelCount;
  final int accumulatePixelCount;
  final int maxPixelCount;
  final int maxRankingCount;

  const GroupRecord({
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
            GroupRecordElement(
              title: "현재 px",
              content: currentPixelCount,
              iconImageUrl: "assets/images/current_pixel_icon.png",
            ),
            SizedBox(
              width: 10,
            ),
            GroupRecordElement(
              title: "누적 px",
              content: accumulatePixelCount,
              iconImageUrl: "assets/images/accumulate_pixel_icon.png",
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            GroupRecordElement(
              title: "하루 최대 px",
              content: maxPixelCount,
              iconImageUrl: "assets/images/max_pixel_icon.png",
            ),
            SizedBox(
              width: 10,
            ),
            GroupRecordElement(
              title: "최고 랭킹",
              content: maxRankingCount,
              iconImageUrl: "assets/images/max_ranking_icon.png",
            ),
          ],
        ),
      ],
    );
  }
}

class GroupRecordElement extends StatelessWidget {
  final String title;
  final int content;
  final String iconImageUrl;

  const GroupRecordElement(
      {super.key,
      required this.title,
      required this.content,
      required this.iconImageUrl});

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
