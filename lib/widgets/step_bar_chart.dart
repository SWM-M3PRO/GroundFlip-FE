import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/my_page_controller.dart';

class StepBarChart extends StatelessWidget {
  StepBarChart({super.key});

  final MyPageController walkController = Get.find<MyPageController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: AspectRatio(
        aspectRatio: 1.6,
        child: BarChart(
          BarChartData(
            barTouchData: barTouchData,
            titlesData: titlesData,
            borderData: borderData,
            barGroups: barGroups,
            gridData: const FlGridData(
              show: true,
              drawVerticalLine: false,
              horizontalInterval: 2000,
            ),
            alignment: BarChartAlignment.spaceAround,
            maxY: 8000,
            // backgroundColor: Colors.grey,
          ),
        ),
      ),
    );
  }

  BarTouchData get barTouchData => BarTouchData(
        enabled: false,
      );

  Widget getTitles(double value, TitleMeta meta) {
    final bottomTitles = ['월', '화', '수', '목', '금', '토', '일'];
    final style = TextStyle(
      color: Colors.grey,
      fontWeight: FontWeight.bold,
      fontSize: 14,
    );
    String text = bottomTitles[value.toInt()];
    return SideTitleWidget(
      axisSide: meta.axisSide,
      space: 4,
      child: Text(text, style: style),
    );
  }

  FlTitlesData get titlesData => FlTitlesData(
        show: true,
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            getTitlesWidget: getTitles,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        rightTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 2000,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 4,
                child: Text(
                  value.toInt().toString(),
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups {
    List<BarChartGroupData> barChartGroupData = [];
    List<int> steps = walkController.getWeeklyStep();
    for (int i = 0; i < steps.length; i++) {
      barChartGroupData.add(BarChartGroupData(
        x: i,
        barRods: [
          BarChartRodData(
            toY: steps[i].toDouble(),
            color: Colors.greenAccent,
          )
        ],
      ));
    }
    return barChartGroupData;
  }
}
