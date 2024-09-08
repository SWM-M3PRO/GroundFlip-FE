import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../controllers/search_group_controller.dart';
import '../widgets/community/community_list.dart';
import 'community_info_screen.dart';
import 'community_screen.dart';

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
              child: groupSearchController.searchController.text.isEmpty
                  ? Padding(
                      padding: const EdgeInsets.all(15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '상위 랭킹 그룹',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w500,
                                color: AppColors.textPrimary),
                          ),
                          SizedBox(height: 10),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16)),
                              color: AppColors.boxColor,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                              child: Column(
                                children: [
                                  CommunityList(
                                    imageUrl:
                                        'https://ground-flip-s3.s3.ap-northeast-2.amazonaws.com/university_logo/ads+%EC%9D%B4%EB%AF%B8%EC%A7%802.png',
                                    communityName: '1등 그룹',
                                    isSearched: 1,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: AppColors.subLineColor,
                                  ),
                                  CommunityList(
                                    imageUrl:
                                    'https://ground-flip-s3.s3.ap-northeast-2.amazonaws.com/university_logo/ads+%EC%9D%B4%EB%AF%B8%EC%A7%802.png',
                                    communityName: '2등 그룹',
                                    isSearched: 2,
                                  ),
                                  Divider(
                                    thickness: 1,
                                    color: AppColors.subLineColor,
                                  ),
                                  CommunityList(
                                    imageUrl:
                                    'https://ground-flip-s3.s3.ap-northeast-2.amazonaws.com/university_logo/ads+%EC%9D%B4%EB%AF%B8%EC%A7%802.png',
                                    communityName: '2등 그룹',
                                    isSearched: 3,
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  : groupSearchController.searchResult.isEmpty
                      ? Center(
                          child: Text(
                            '그룹이 없습니다!',
                            style: TextStyle(color: AppColors.textPrimary),
                          ),
                        )
                      : ListView.builder(
                          itemCount: groupSearchController.searchResult.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              title: InkWell(
                                onTap: () {
                                  Get.to(
                                    () => CommunityInfoScreen(
                                        groupId: groupSearchController
                                            .searchResult[index].id),
                                  );
                                },
                                child: CommunityList(
                                  imageUrl: groupSearchController
                                      .searchResult[index].backgroundImageUrl,
                                  communityName: groupSearchController
                                      .searchResult[index].name,
                                  isSearched: 0,
                                ),
                              ),
                            );
                          },
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

  String formatNumber(int number) {
    final formatter = NumberFormat('#,###');
    return formatter.format(number);
  }
}
