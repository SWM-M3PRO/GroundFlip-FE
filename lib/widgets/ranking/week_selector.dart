import 'package:flutter/material.dart';

import '../../constants/text_styles.dart';

class WeekSelector extends StatelessWidget {
  const WeekSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        child: GestureDetector(
          onTap: () {},
          child: Row(
            children: [
              Text(
                '2024년 07월 12일 ~ 19일',
                style: TextStyles.title2,
              ),
              SizedBox(
                width: 5,
              ),
              Image.asset(
                "assets/images/chevron_down.png",
                width: 20,
                height: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
