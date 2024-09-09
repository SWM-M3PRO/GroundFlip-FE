import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';
import '../ranking/ranking_type_toggle_button.dart';

class MapAppBar extends StatelessWidget {
  const MapAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class RankingAppBar extends StatelessWidget {
  static String rankingGuideUrl =
      'https://autumn-blouse-355.notion.site/b90c1f81e247499ab244137634b066bc?pvs=4';

  const RankingAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      title: RankingTypeToggleButton(),
    );
  }
}

class GroupAppBar extends StatelessWidget {
  const GroupAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

class MyPageAppBar extends StatelessWidget {
  const MyPageAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.background,
      title: AppBarTitle(title: "마이 페이지"),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Get.toNamed('/setting');
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.backgroundThird,
            shape: CircleBorder(),
            minimumSize: Size(36, 36),
            padding: EdgeInsets.all(0),
            iconColor: AppColors.textPrimary,
          ),
          child: const Icon(Icons.settings),
        ),
      ],
    );
  }
}

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        title,
        style: TextStyles.fs20w700cTextPrimary,
      ),
    );
  }
}
