import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'search_group_screen.dart';

class GroupScreen extends StatelessWidget {
  const GroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Get.to(() => SearchGroupScreen());
              },
              child: const Text('그룹검색'),
            ),
          ],
        ),
      ],
    );
  }
}
