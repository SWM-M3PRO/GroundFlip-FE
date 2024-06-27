import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
            ElevatedButton(onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder:(context)=> SearchGroupScreen()),
              );
            }, child: const Text('그룹검색'))],
        ),
      ],
    );
  }
}
