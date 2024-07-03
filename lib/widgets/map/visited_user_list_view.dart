import 'package:flutter/material.dart';

class VisitedUserListView extends StatelessWidget {
  final List<String> test = ['김민욱', '뿌직형', '구민', '나루토', '사스케'];

  VisitedUserListView({super.key});

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
            itemCount: 5,
            itemBuilder: (context, int index) {
              return Padding(
                padding: const EdgeInsets.all(5.0),
                child: Row(
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/profile_image.png',
                        width: 50,
                        height: 50,
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      test[index].toString(),
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
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
