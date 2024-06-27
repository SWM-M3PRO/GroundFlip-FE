import 'package:flutter/material.dart';

import '../widgets/searched_group.dart';

class SearchGroupScreen extends StatelessWidget {
  const SearchGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width: 8),
            Flexible(
              flex: 1,
              child: TextField(
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 7,
                    horizontal: 16,
                  ),
                ),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                SearchedGroup('홍익대학교'),
                SearchedGroup('홍익대학교 세종캠'),
                SearchedGroup('홍익대학교 부속고등학교'),
              ],
            ),
          )
        ],
      ),
    );
  }
}
