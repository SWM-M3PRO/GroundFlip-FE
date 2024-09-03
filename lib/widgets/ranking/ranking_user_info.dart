import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';
import '../../constants/text_styles.dart';

class RankingUserInfo extends StatelessWidget {
  const RankingUserInfo({
    super.key,
    required this.nickname,
    required this.profileImageUrl,
    required this.communityName,
  });

  final String nickname;
  final String? profileImageUrl;
  final String? communityName;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      child: Ink(
        decoration: const BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.all(Radius.circular(16)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              ClipOval(
                child: profileImageUrl != null
                    ? Image(
                        image: CachedNetworkImageProvider(profileImageUrl!),
                        width: 44,
                        height: 44,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        'assets/images/default_profile_image.png',
                        width: 44,
                        height: 44,
                      ),
              ),
              SizedBox(
                width: 30,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    nickname,
                    style: TextStyles.fs20w600cTextPrimary,
                  ),
                  if (communityName != null)
                    Text(
                      communityName!,
                      style: TextStyles.fs14w400cTextSecondary,
                    ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
