import 'package:flutter/material.dart';


class SearchedGroup {
  Widget searchedGroup(String groupName){
    return Container(
      height: 50,
      color: Colors.white70,
      child: Center(
        child: Text(groupName),
      ),
    );
  }
}

