import 'package:flutter/cupertino.dart';

import 'achievement_list_element.dart';

class AchievementGrid extends StatelessWidget {
  final List<AchievementListElement> achievements;

  const AchievementGrid({super.key, required this.achievements});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
        childAspectRatio: 0.8,
      ),
      itemCount: achievements.length,
      itemBuilder: (context, index) {
        return achievements[index];
      },
    );
  }
}
