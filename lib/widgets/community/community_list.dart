import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../controllers/search_community_controller.dart';
import '../../screens/community_info_screen.dart';

class CommunityList extends StatelessWidget {
  CommunityList({
    super.key,
    required this.imageUrl,
    required this.communityName,
    required this.isSearched,
    required this.communityId,
    required this.password,
  });

  final String imageUrl;
  final String communityName;
  final String password;
  final int communityId;
  final int isSearched;

  SearchCommunityController searchCommunityController =
      Get.find<SearchCommunityController>();

  @override
  Widget build(BuildContext context) {
    searchCommunityController.inputPassword.value = "";

    return ListTile(
      title: InkWell(
        onTap: () {
          searchCommunityController.checkPassword.value = true;
          if (password != "") {
            Get.dialog(
              AlertDialog(
                title: Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Column(
                      children: [
                        Text(
                          '비밀번호',
                          style: TextStyle(
                            color: AppColors.textPrimary,
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        TextField(
                          obscureText: true,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                          autofocus: true,
                          onChanged: (text) {
                            searchCommunityController.inputPassword.value =
                                text;
                            print(
                                searchCommunityController.inputPassword.value);
                          },
                          cursorColor: AppColors.textPrimary,
                          decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.boxColorSecond)),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors.textPrimary))),
                        ),
                        SizedBox(height: 8),
                        Obx(
                          () => searchCommunityController.checkPassword.value ==
                                  false
                              ? Text(
                                  '비밀번호가 맞지 않습니다',
                                  style: TextStyle(
                                      fontSize: 10, color: AppColors.accent),
                                )
                              : Container(),
                        ),
                      ],
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    child: Text(
                      '확인',
                      style: TextStyle(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      overlayColor: AppColors.primary,
                    ),
                    onPressed: () async {
                      if (searchCommunityController.inputPassword.value ==
                          password) {
                        searchCommunityController.checkPassword.value = true;
                        Get.to(
                          () => CommunityInfoScreen(communityId: communityId),
                        );
                      } else {
                        print(
                            '4444 ${searchCommunityController.checkPassword.value}');
                        searchCommunityController.checkPassword.value = false;
                      }
                    },
                  ),
                ],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                backgroundColor: AppColors.boxColor,
              ),
            );
          } else {
            Get.to(
              () => CommunityInfoScreen(communityId: communityId),
            );
          }
        },
        child: Row(
          children: [
            checkFileExtension(imageUrl) == 'svg'
                ? SvgPicture.network(
                    imageUrl,
                    width: 38,
                  )
                : Image(
                    image: CachedNetworkImageProvider(imageUrl),
                    width: 40,
                  ),
            SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  communityName,
                  style: TextStyle(
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
            Spacer(),
            password != ""
                ? Icon(
                    Icons.lock,
                    size: 20,
                  )
                : Container(),
            SizedBox(width: 5),
            selectIcon(isSearched),
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

  Widget selectIcon(int number) {
    switch (number) {
      case 0:
        return Icon(
          Icons.arrow_forward_ios,
          color: AppColors.textPrimary,
          size: 20,
        );
      default:
        return Container();
    }
  }
}
