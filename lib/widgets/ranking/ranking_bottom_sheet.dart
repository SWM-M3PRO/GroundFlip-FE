import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../my_page/pixel_dash_board_widget.dart';
import 'ranking_user_info.dart';


class RankingBottomSheet extends StatelessWidget {
  const RankingBottomSheet({
    super.key,
    required this.userId,
    required this.nickname,
    required this.profileImageUrl,
    required this.currentPixelCount,
    required this.accumulatePixelCount,
  });

  final int userId;
  final String nickname;
  final String? profileImageUrl;
  final int currentPixelCount;
  final int accumulatePixelCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 600,
      height: 250,
      child: Padding(
        // padding: const EdgeInsets.all(10.0),
        padding: const EdgeInsets.only(top: 5.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Column(
          children: [
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.backgroundThird,
                  borderRadius:
                  const BorderRadius.all(Radius.circular(10)),
                ),
                height: 4,
                width: 40,
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            RankingUserInfo(
              nickname: nickname,
              profileImageUrl: profileImageUrl,
              communityName: null,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                PixelDashBoardWidget(
                  textValue: "현재 px",
                  iconImageUrl: "assets/images/current_pixel_icon.png",
                  countValue: currentPixelCount.obs,
                ),
                SizedBox(
                  width: 20,
                ),
                PixelDashBoardWidget(
                  textValue: "누적 px",
                  iconImageUrl: "assets/images/accumulate_pixel_icon.png",
                  countValue: accumulatePixelCount.obs,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
