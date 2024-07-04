import 'package:flutter/material.dart';

class IndividualVisitHistoryListView extends StatelessWidget {
  const IndividualVisitHistoryListView({super.key, required this.visitList});

  final List<DateTime> visitList;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF8B8B8B),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20),
            topLeft: Radius.circular(20),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
          child: ListView.builder(
            itemCount: visitList.length,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  "${visitList[index].year}년 ${visitList[index].month}월 ${visitList[index].day}일",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              );
            },
            shrinkWrap: true,
          ),
        ),
      ),
    );
  }
}
