import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../../constants/app_colors.dart';
import '../../controllers/community_controller.dart';
import '../../controllers/my_page_controller.dart';
import '../../service/community_service.dart';
import 'signin_complete_bottomsheet.dart';

class CommunitySignInBottomSheet extends StatelessWidget {
  CommunitySignInBottomSheet({
    super.key,
    required this.communityName,
    required this.communityImageUrl,
    required this.communityId,
  });

  final String communityName;
  final String communityImageUrl;
  final int communityId;

  final CommunityService communityService = CommunityService();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        SizedBox(
          child: Padding(
            padding:
                const EdgeInsets.only(top: 40, left: 20, right: 20, bottom: 20),
            child: Column(
              children: [
                Text(
                  '그룹에 가입하시겠습니까?',
                  style: TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                SizedBox(height: 20),
                Image.asset(
                  'assets/images/shake_hand.png',
                  width: 100,
                  height: 100,
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: AppColors.boxColorForth,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10),
                      child: Row(
                        children: [
                          checkFileExtension(communityImageUrl) == 'svg'
                              ? SvgPicture.network(
                                  communityImageUrl,
                                  width: 35,
                                )
                              : Image(
                                  image: CachedNetworkImageProvider(
                                    communityImageUrl,
                                  ),
                                  width: 35,
                                ),
                          SizedBox(width: 15),
                          Text(
                            communityName,
                            style: TextStyle(
                              fontSize: 17,
                              color: AppColors.textPrimary,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            Get.back();
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.boxColorForth,
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Center(
                                child: Text(
                                  '취소',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: AppColors.textPrimary,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 15),
                      Expanded(
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () async {
                            int? response;
                            response = await communityService
                                .signInCommunity(communityId);
                            if (response == 200) {
                              MyPageController myPageController =
                                  Get.find<MyPageController>();
                              CommunityController communityController =
                                  Get.find<CommunityController>();
                              await myPageController.updateUserInfo();
                              await communityController.updateCommunityInfo();
                              Get.back();
                              Get.bottomSheet(
                                SignInCompleteBottomSheet(),
                                backgroundColor: AppColors.backgroundSecondary,
                                enterBottomSheetDuration:
                                    Duration(milliseconds: 100),
                                exitBottomSheetDuration:
                                    Duration(milliseconds: 100),
                                isScrollControlled: true,
                              );
                            }
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(16),
                              color: AppColors.primary,
                            ),
                            child: Padding(
                              padding: EdgeInsets.symmetric(vertical: 15),
                              child: Center(
                                child: Text(
                                  '가입 신청',
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: AppColors.textThird,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
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
