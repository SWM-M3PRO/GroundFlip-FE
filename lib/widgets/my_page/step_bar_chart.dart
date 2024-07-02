import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/walking_controller.dart';

class StepBarChart extends StatelessWidget {
  StepBarChart({super.key});

  final WalkingController walkController = Get.find<WalkingController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () async {
                  await walkController.loadPreviousWeekSteps();
                },
                icon: Icon(Icons.arrow_back_ios_new_outlined),
              ),
              Obx(() => Text(walkController.getSelectedWeekInfo())),
              Obx(
                () => IconButton(
                  onPressed: walkController.getIsNextButtonEnabled()
                      ? () {
                          walkController.loadNextWeekSteps();
                        }
                      : null,
                  icon: Icon(Icons.arrow_forward_ios_outlined),
                ),
              ),
            ],
          ),
          AspectRatio(
            aspectRatio: 1.6,
            child: Obx(
              () => BarChart(
                BarChartData(
                  barTouchData: getBarTouchData(),
                  titlesData: getTitlesData(walkController.getMaxStep()),
                  borderData: borderData,
                  barGroups: getBarGroups(walkController.getWeeklySteps()),
                  gridData: FlGridData(
                    show: true,
                    drawVerticalLine: false,
                    horizontalInterval: walkController.getMaxStep() / 4,
                  ),
                  alignment: BarChartAlignment.spaceAround,
                  maxY: walkController.getMaxStep(),
                ),
              ),
            ),
          ),
        ],
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

  FlTitlesData getTitlesData(maxStep) => FlTitlesData(
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
            reservedSize: 40,
            interval: maxStep / 4,
            getTitlesWidget: (value, meta) {
              return SideTitleWidget(
                axisSide: meta.axisSide,
                space: 5,
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

  List<BarChartGroupData> getBarGroups(steps) {
    List<BarChartGroupData> barChartGroupData = [];
    for (int i = 0; i < steps.length; i++) {
      barChartGroupData.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: steps[i].toDouble(),
              color: Colors.greenAccent,
            ),
          ],
        ),
      );
    }
    return barChartGroupData;
  }

  BarTouchData getBarTouchData() {
    return BarTouchData(
      touchTooltipData: BarTouchTooltipData(
        getTooltipColor: (_) => Colors.blueGrey,
        tooltipHorizontalAlignment: FLHorizontalAlignment.center,
        tooltipMargin: -10,
        getTooltipItem: (group, groupIndex, rod, rodIndex) {
          return BarTooltipItem(
            (rod.toY - 1).toInt().toString(),
            const TextStyle(
              color: Colors.white, //widget.touchedBarColor,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          );
        },
      ),
      touchCallback: (FlTouchEvent event, barTouchResponse) {
        if (!event.isInterestedForInteractions ||
            barTouchResponse == null ||
            barTouchResponse.spot == null) {
          return;
        }
      },
    );
  }
}
