import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../constants/app_colors.dart';
import '../../screens/community_info_screen.dart';

class CommunityList extends StatelessWidget {
  const CommunityList(
      {super.key,
      required this.imageUrl,
      required this.communityName,
      required this.isSearched,
      required this.communityId});

  final String imageUrl;
  final String communityName;
  final int communityId;
  final int isSearched;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: InkWell(
        onTap: () {
          Get.to(
            () => CommunityInfoScreen(groupId: communityId),
          );
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
                Row(
                  children: [
                    Text(
                      '${formatNumber(1122)}px',
                      style: TextStyle(color: AppColors.primary),
                    ),
                    Text(
                      'ㆍ',
                      style: TextStyle(color: AppColors.textForth),
                    ),
                    Text(
                      '누적 ${formatNumber(2222)}px',
                      style: TextStyle(color: AppColors.textForth),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
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
      case 1:
        return Image.asset(
          'assets/images/1st_place_medal.png',
          width: 40,
        );
      case 2:
        return Image.asset(
          'assets/images/2nd_place_medal.png',
          width: 40,
        );
      case 3:
        return Image.asset(
          'assets/images/3rd_place_medal.png',
          width: 40,
        );
      default:
        return Container();
    }
  }
}
