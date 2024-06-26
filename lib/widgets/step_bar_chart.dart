import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StepBarChart extends StatelessWidget {
  const StepBarChart({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
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

  // 제목
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
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 2000,
          ),
        ),
      );

  FlBorderData get borderData => FlBorderData(
        show: false,
      );

  List<BarChartGroupData> get barGroups {
    List<BarChartGroupData> barChartGroupData = [];
    List<int> steps = [2900, 3600, 4500, 3289, 7012, 0, 0];
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
