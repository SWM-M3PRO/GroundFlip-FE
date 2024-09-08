import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';

import '../constants/app_colors.dart';
import '../controllers/search_group_controller.dart';
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
                        title: InkWell(
                          onTap: () {
                            Get.to(() => CommunityInfoScreen(
                                groupId: groupSearchController
                                    .searchResult[index].id));
                          },
                          child: Container(
                            child: Row(
                              children: [
                                checkFileExtension(groupSearchController
                                            .searchResult[index]
                                            .backgroundImageUrl) ==
                                        'svg'
                                    ? SvgPicture.network(
                                        groupSearchController
                                            .searchResult[index]
                                            .backgroundImageUrl,
                                        width: 38,
                                      )
                                    : Image(
                                        image: CachedNetworkImageProvider(
                                            groupSearchController
                                                .searchResult[index]
                                                .backgroundImageUrl),
                                        width: 38,
                                      ),
                                SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      groupSearchController
                                          .searchResult[index].name,
                                      style: TextStyle(
                                        color: AppColors.textPrimary,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          '${formatNumber(1122)}px',
                                          style: TextStyle(
                                              color: AppColors.primary),
                                        ),
                                        Text(
                                          'ㆍ',
                                          style: TextStyle(
                                              color: AppColors.textForth),
                                        ),
                                        Text(
                                          '누적 ${formatNumber(2222)}px',
                                          style: TextStyle(
                                              color: AppColors.textForth),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Icon(
                                  Icons.arrow_forward_ios,
                                  color: AppColors.textPrimary,
                                  size: 20,
                                ),
                              ],
                            ),
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
