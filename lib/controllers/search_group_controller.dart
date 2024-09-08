import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/community_service.dart';

class GroupSearchController extends GetxController {
  RxList<dynamic> searchResult = <dynamic>[].obs;
  FocusNode searchFocusnode = FocusNode();
  TextEditingController searchController = TextEditingController();

  CommunityService communityService = CommunityService();

  @override
  void onInit() {
    super.onInit();
    searchFocusnode.addListener(() {
      if (searchFocusnode.hasFocus) {
        searchController.selection = TextSelection(
          baseOffset: 0,
          extentOffset: searchController.text.length,
        );
      }
    });
  }

  @override
  void onClose() {
    searchFocusnode.dispose();
    super.onClose();
  }

  void getSearchedGroup(keyword) async {
    List<dynamic> getInstance =
        await communityService.getSearchCommunities(searchKeyword: keyword);
    searchResult.assignAll(getInstance);
  }
}
