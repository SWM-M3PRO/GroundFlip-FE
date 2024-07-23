import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class IndividualHistoryHeader extends StatelessWidget {
  const IndividualHistoryHeader(
      {super.key, required this.address, required this.visitCount});

  final String? address;
  final int visitCount;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          address ?? "대한민국",
          style: TextStyles.fs24w900cTextPrimary,
        ),
        Spacer(),
        Text(
          "$visitCount번째 방문",
          style: TextStyles.fs17w400cTextSecondary,
        ),
      ],
    );
  }
}

class IndividualHistoryList extends StatelessWidget {
  const IndividualHistoryList({super.key, required this.visitList});

  final List<DateTime> visitList;

  @override
  Widget build(BuildContext context) {
    return SliverList.list(
      children: [
        SizedBox(height: 10),
        for (int i = 0; i < visitList.length; i++)
          IndividualHistoryListElement(
            historyDate: visitList[i],
          ),
      ],
    );
  }
}

class IndividualHistoryListElement extends StatelessWidget {
  IndividualHistoryListElement({super.key, required this.historyDate});

  final DateTime historyDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 5, 20, 5),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: AppColors.backgroundThird,
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
        child: Row(
          children: [
            Icon(
              Icons.access_time_filled,
              size: 16,
            ),
            SizedBox(
              width: 20,
            ),
            Text(
              '${historyDate.year}년 ${historyDate.month}월 ${historyDate.day}일',
              style: TextStyles.fs17w400cTextPrimary,
            )
          ],
        ),
      ),
    );
  }
}
