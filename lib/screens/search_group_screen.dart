import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/search_group_controller.dart';
import '../service/pixel_service.dart';

class SearchGroupScreen extends StatelessWidget {
  const SearchGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupSearchController groupSearchController =
        Get.put(GroupSearchController());

    PixelService pixelService = PixelService();

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              const SizedBox(width: 8),
              Flexible(
                flex: 1,
                child: TextField(
                  autofocus: true,
                  onSubmitted: (value) {
                    if (groupSearchController.searchController.text != '') {
                      groupSearchController.getSearchedGroup(
                        groupSearchController.searchController.text,
                      );
                    }
                  },
                  controller: groupSearchController.searchController,
                  focusNode: groupSearchController.searchFocusnode,
                  decoration: InputDecoration(
                    hintText: 'Enter keyword',
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 7,
                      horizontal: 16,
                    ),
                  ),
                ),
              ),
              IconButton(
                onPressed: () {
                  String keyword = groupSearchController.searchController.text;
                  if (keyword != '') {
                    groupSearchController.getSearchedGroup(keyword);
                  }
                },
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
              child: Obx(
                () {
                  if (groupSearchController.searchResult.isEmpty) {
                    return Center(
                      child: Text('그룹이 없습니다!'),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: groupSearchController.searchResult.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(
                            groupSearchController.searchResult[index].name,
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
