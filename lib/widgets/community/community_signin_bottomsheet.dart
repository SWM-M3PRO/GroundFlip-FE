import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import 'community_list.dart';

class CommunitySignInBottomSheet extends StatelessWidget {
  const CommunitySignInBottomSheet({
    super.key,
    required this.communityName,
    required this.communityImageUrl,
  });

  final String communityName;
  final String communityImageUrl;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      //width: 600,
      height: 600,
      child: Padding(
        padding:
            const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
        child: Column(
          children: [
            Text(
              '그룹에 가입하시겠습니까?',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Text(
              '함께 걷다보면 더 알아가고 싶은 사람들입니다',
              style: TextStyle(color: AppColors.textFifth, fontSize: 20),
            ),
            SizedBox(height: 5),
            Image.asset(
              'assets/images/shake_hand.png',
              width: 250,
              height: 250,
            ),
            SizedBox(height: 5),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: AppColors.boxColorForth),
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: [
                      checkFileExtension(communityImageUrl) == 'svg'
                          ? SvgPicture.network(
                              communityImageUrl,
                              width: 38,
                            )
                          : Image(
                              image:
                                  CachedNetworkImageProvider(communityImageUrl),
                              width: 40,
                            ),
                      SizedBox(width: 15),
                      Text(
                        '${communityName}',
                        style: TextStyle(
                          fontSize: 20,
                          color: AppColors.textPrimary,
                          fontWeight: FontWeight.w400,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {
                      Get.back();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.boxColorForth),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text('취소',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: AppColors.textPrimary,
                                  fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  InkWell(
                    borderRadius: BorderRadius.circular(16),
                    onTap: () {

                    },
                    child: Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(16),
                          color: AppColors.boxColorForth,
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(10),
                        child: Center(
                          child: Text('가입 신청',
                            style: TextStyle(
                                fontSize: 20,
                                color: AppColors.textThird,
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )
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
