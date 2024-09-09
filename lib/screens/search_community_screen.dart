import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../controllers/search_community_controller.dart';
import '../widgets/community/community_list.dart';

class SearchCommunityScreen extends StatelessWidget {
  const SearchCommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final SearchCommunityController searchCommunityController =
        Get.put(SearchCommunityController());

    const double betweenLine = 15;

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
                            vertical: 10,
                            horizontal: 5,
                          ),
                          child: TextField(
                            controller:
                                searchCommunityController.textEditingController,
                            autofocus: false,
                            focusNode: searchCommunityController.searchFocusNode,
                            onChanged: searchCommunityController.updateKeyword,
                            onSubmitted: searchCommunityController.updateKeyword,
                            decoration: InputDecoration(
                              hintText: '그룹을 검색해주세요',
                              hintStyle: TextStyle(
                                color: AppColors.textPrimary,
                                fontSize: 11,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                vertical: 11,
                                horizontal: 7,
                              ),
                            ),
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
                              searchCommunityController.textEditingController.text;
                          if (keyword.isNotEmpty) {
                            searchCommunityController.getSearchedGroup(keyword);
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
            Obx(
              () => Expanded(
                child: searchCommunityController.searchKeyword.value == ""
                   ? Container()
                    : Obx(() {
                        if (searchCommunityController.searchResult.isEmpty) {
                          return Center(
                            child: Text(
                              '그룹이 없습니다!',
                              style: TextStyle(color: AppColors.textPrimary),
                            ),
                          );
                        } else {
                          return ListView.builder(
                            itemCount:
                                searchCommunityController.searchResult.length,
                            itemBuilder: (context, index) {
                              searchCommunityController.updateCommunityInfo(
                                searchCommunityController.searchResult[index],
                              );

                              return Column(
                                children: [
                                  ListTile(
                                    title: CommunityList(
                                      imageUrl:
                                          searchCommunityController.imageUrl.value,
                                      communityName: searchCommunityController
                                          .communityName.value,
                                      communityId: searchCommunityController
                                          .communityId.value,
                                      isSearched: 0,
                                    ),
                                  ),
                                  if (index <
                                      searchCommunityController
                                              .searchResult.length -
                                          1)
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 25,
                                      ),
                                      child: Divider(
                                        thickness: 1, // 선의 두께
                                        color: AppColors.subLineColor,
                                        height: 1, // 선의 색상
                                      ),
                                    ),
                                ],
                              );
                            },
                          );
                        }
                      }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String checkFileExtension(String url) {
    Uri uri = Uri.parse(url);
    String path = uri.path;

    if (path.contains('.')) {
      return path.split('.').last;
    } else {
      return '';
    }
  }
}
