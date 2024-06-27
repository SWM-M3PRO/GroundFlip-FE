import 'package:flutter/material.dart';

import '../widgets/searched_group.dart';

class SearchGroupScreen extends StatelessWidget {
  const SearchGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    SearchedGroup searchedGroup = SearchedGroup();

    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const SizedBox(width: 8),
            const Flexible(
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
              icon: const Icon(
                Icons.search,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                searchedGroup.searchedGroup('홍익대학교'),
                searchedGroup.searchedGroup('홍익대학교 세종캠'),
                searchedGroup.searchedGroup('홍익대학교 부속고등학교'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
