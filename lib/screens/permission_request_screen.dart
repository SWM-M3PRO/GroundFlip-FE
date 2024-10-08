import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/app_colors.dart';
import '../constants/text_styles.dart';
import '../controllers/permission_request_controller.dart';
import '../widgets/permission/permission_element.dart';
import '../widgets/permission/permission_grant_button.dart';

class PermissionRequestScreen extends StatelessWidget {
  const PermissionRequestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Get.put(PermissionRequestController());

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Container(
        color: AppColors.background,
        child: Column(
          children: [
            Expanded(
              child: Column(
                children: [
                  SizedBox(
                    height: 90.0,
                  ),
                  Row(
                    children: [
                      SizedBox(
                        width: 20.0,
                      ),
                      Text(
                        '서비스 사용을 위해 \n'
                        '아래의 권한이 필요합니다.',
                        style: TextStyles.fs28w700cTextPrimary,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  PermissionElement(
                    iconPath:
                        'assets/images/permission/location_permission_icon.png',
                    permissionName: '위치 정보',
                    permissionDescription: '지도에서 위치를 표시하기 위해 필요해요!',
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  PermissionElement(
                    iconPath:
                        'assets/images/permission/activity_recognition_icon.png',
                    permissionName: '신체 활동',
                    permissionDescription: '걸음 수를 가져오기 위해 필요해요!',
                  ),
                  SizedBox(
                    height: 16.0,
                  ),
                  if (Platform.isAndroid) ...[
                    PermissionElement(
                      iconPath:
                          'assets/images/permission/notification_icon.png',
                      permissionName: '알림',
                      permissionDescription:
                          '공지사항, 앱 내의 활동에 대한 알림을 수신하고 걸음 수를 알림창에 표시하기 위해 필요해요!',
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                    PermissionElement(
                      iconPath: 'assets/images/permission/battery_icon.png',
                      permissionName: '배터리 최적화 예외',
                      permissionDescription:
                          '백그라운드에서 만보기와 땅따먹기 기능을 제공하기 위해 필요해요!',
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                  if (Platform.isIOS) ...[
                    PermissionElement(
                      iconPath:
                          'assets/images/permission/notification_icon.png',
                      permissionName: '알림',
                      permissionDescription:
                          '공지사항, 앱 내의 활동에 대한 알림을 수신하기 위해 필요해요!',
                    ),
                    SizedBox(
                      height: 16.0,
                    ),
                  ],
                ],
              ),
            ),
            PermissionGrantButton(),
          ],
        ),
      ),
    );
  }
}
