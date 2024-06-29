import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../service/search_group_service.dart';

class GroupSearchController extends GetxController {
  RxList<dynamic> searchResult = <dynamic>[].obs;
  FocusNode searchFocusnode = FocusNode();
  TextEditingController searchController = TextEditingController();

  SearchGroupService searchGroupService = SearchGroupService();

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
    searchFocusnode.dispose();
    super.onClose();
  }

  void getSearchedGroup(keyword) async {
    List<dynamic> getInstance =
        await searchGroupService.getSearchGroups(searchKeyword: keyword);
    searchResult.assignAll(getInstance);
  }
}
