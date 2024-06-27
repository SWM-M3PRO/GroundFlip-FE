import 'package:flutter/material.dart';

Widget SearchedGroup(String searchedGroupName) {
  return Container(
    height: 50,
    color: Colors.white70,
    child: Center(
      child: Text('${searchedGroupName}'),
    ),
  );
}
