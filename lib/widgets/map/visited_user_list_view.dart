import 'package:flutter/material.dart';

import '../../models/individual_mode_pixel_info.dart';

class VisitedUserListView extends StatelessWidget {
  final List<VisitList> visitList;

  VisitedUserListView({super.key, required this.visitList});

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
                child: Row(
                  children: [
                    ClipOval(
                      child: visitList[index].profileImageUrl != null
                          ? Image.network(
                              visitList[index].profileImageUrl!,
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/images/default_profile_image.png',
                              width: 50,
                              height: 50,
                            ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      visitList[index].nickname!,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
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
