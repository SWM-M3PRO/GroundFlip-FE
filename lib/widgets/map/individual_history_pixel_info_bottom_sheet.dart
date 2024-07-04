import 'package:flutter/material.dart';

import '../../models/individual_history_pixel_info.dart';
import 'individual_visit_history_list_view.dart';

class IndividualHistoryPixelInfoBottomSheet extends StatelessWidget {
  const IndividualHistoryPixelInfoBottomSheet(
      {super.key, required this.pixelInfo});

  final IndividualHistoryPixelInfo pixelInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: Color(0xFF374957),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: SizedBox(
        height: 400,
        width: 380,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(30, 20, 30, 0),
          child: Column(
            children: [
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${pixelInfo.address ?? '대한민국'} ${pixelInfo.addressNumber ?? 'n'}번째 픽셀',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(
                  '${pixelInfo.visitCount}번 방문했어요!',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              IndividualVisitHistoryListView(visitList: pixelInfo.visitList!),
            ],
          ),
        ),
      ),
    );
  }
}
