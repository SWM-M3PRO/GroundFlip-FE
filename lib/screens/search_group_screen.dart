import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../controllers/search_group_controller.dart';

class SearchGroupScreen extends StatelessWidget {
  const SearchGroupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroupSearchController groupSearchController =
        Get.put(GroupSearchController());

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppBar(
          backgroundColor: AppColors.background,
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: AppColors.buttonColor,
            ),
          ),
          title: Row(
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.7,
                  height: 45,
                  // 적당한 높이 설정
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: AppColors.boxColor,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 5),
                          child: TextField(
                            controller: groupSearchController.searchController,
                            autofocus: false,
                            focusNode: groupSearchController.searchFocusnode,
                            onChanged: (value) {
                              if (groupSearchController
                                  .searchController.text.isNotEmpty) {
                                groupSearchController.getSearchedGroup(
                                  groupSearchController.searchController.text,
                                );
                              }
                            },
                            decoration: InputDecoration(
                                hintText: '그룹을 검색해주세요',
                                hintStyle: TextStyle(
                                  color: AppColors.textPrimary,
                                  fontSize: 11,
                                ),
                                border: InputBorder.none,
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 11)),
                            style: TextStyle(
                              fontSize: 17.0,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          String keyword =
                              groupSearchController.searchController.text;
                          if (keyword.isNotEmpty) {
                            groupSearchController.getSearchedGroup(keyword);
                          }
                        },
                        icon: Icon(
                          Icons.search,
                          color: AppColors.buttonColor,
                          size: 20,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: [
            Expanded(
              child: Obx(() {
                if (groupSearchController.searchResult.isEmpty ||
                    groupSearchController.searchResult.isEmpty) {
                  return Center(
                    child: Text(
                      '그룹이 없습니다!',
                      style: TextStyle(color: AppColors.textPrimary),
                    ),
                  );
                } else {
                  return ListView.builder(
                    itemCount: groupSearchController.searchResult.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Container(
                          child: Row(
                            children: [
                              Image(
                                image: CachedNetworkImageProvider(
                                  groupSearchController
                                      .searchResult[index].backgroundImageUrl,
                                ),
                                width: 44,
                                height: 44,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(width: 8),
                              Text(
                                groupSearchController.searchResult[index].name,
                                style: TextStyle(
                                  color: AppColors.textPrimary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
              }),
            ),
          ],
        ),
      ),
    );
  }
}
