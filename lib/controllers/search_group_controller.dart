import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/community_service.dart';

class GroupSearchController extends GetxController {
  RxList<dynamic> searchResult = <dynamic>[].obs;
  FocusNode searchFocusNode = FocusNode();
  late final TextEditingController textEditingController;

  RxString searchKeyword = "".obs;
  RxString imageUrl = "".obs;
  RxString communityName = "".obs;
  RxInt communityId = 0.obs;

  CommunityService communityService = CommunityService();

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController(text: searchKeyword.value);
    searchFocusNode.addListener(
      () {
        if (searchFocusNode.hasFocus) {
          textEditingController.selection = TextSelection(
            baseOffset: 0,
            extentOffset: textEditingController.text.length,
          );
        }
      },
    );
  }

  @override
  Future<void> onClose() async {
    await textDispose();
    super.onClose();
  }

  Future<void> textDispose() async {
    textEditingController.dispose();
    searchFocusNode.dispose();
  }

  void getSearchedGroup(keyword) async {
    List<dynamic> getInstance =
        await communityService.getSearchCommunities(searchKeyword: keyword);
    searchResult.assignAll(getInstance);
  }

  void updateKeyword(String value) {
    print('1111 ${value}');
    searchKeyword.value = value;
    if (textEditingController.text.isNotEmpty) {
      getSearchedGroup(value);
    }else{
      searchResult.clear();
    }
  }

  void updateCommunityInfo(dynamic communityInfo){
    imageUrl.value = communityInfo.backgroundImageUrl;
    communityName.value = communityInfo.name;
    communityId.value = communityInfo.id;
  }
}
