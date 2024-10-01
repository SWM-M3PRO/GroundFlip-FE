import 'package:flutter/material.dart';

import '../../constants/app_colors.dart';

class PixelBarChart extends StatelessWidget {
  PixelBarChart({super.key});

  // final WalkingController walkController = Get.find<WalkingController>();

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.backgroundSecondary,
          borderRadius: BorderRadius.circular(16),
        ),
        // child: Column(
        //   children: [
        //     Padding(
        //       padding: const EdgeInsets.fromLTRB(0.0, 0, 20, 0),
        //       child: Row(
        //         mainAxisAlignment: MainAxisAlignment.start,
        //         children: [
        //           Obx(
        //             () => GestureDetector(
        //               onTap: walkController.getIsPreviousButtonEnabled()
        //                   ? () {
        //                       walkController.loadPreviousWeekSteps();
        //                     }
        //                   : null,
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   color: AppColors.backgroundSecondary,
        //                   borderRadius: BorderRadius.all(Radius.circular(16)),
        //                 ),
        //                 padding: const EdgeInsets.fromLTRB(20.0, 20, 10, 20),
        //                 child: Icon(
        //                   Icons.arrow_back_ios_new_outlined,
        //                   color: AppColors.textPrimary,
        //                   size: 20,
        //                 ),
        //               ),
        //             ),
        //           ),
        //           GestureDetector(
        //             child: Obx(
        //               () => Text(
        //                 walkController.getSelectedWeekInfo(),
        //                 style: TextStyles.fs17w600cTextPrimary,
        //               ),
        //             ),
        //           ),
        //           Obx(
        //             () => GestureDetector(
        //               onTap: walkController.getIsNextButtonEnabled()
        //                   ? () {
        //                       walkController.loadNextWeekSteps();
        //                     }
        //                   : null,
        //               child: Container(
        //                 decoration: BoxDecoration(
        //                   color: AppColors.backgroundSecondary,
        //                   borderRadius: BorderRadius.all(Radius.circular(16)),
        //                 ),
        //                 padding: const EdgeInsets.fromLTRB(10.0, 20, 20, 20),
        //                 child: Icon(
        //                   Icons.arrow_forward_ios_outlined,
        //                   color: AppColors.textPrimary,
        //                   size: 20,
        //                 ),
        //               ),
        //             ),
        //           ),
        //         ],
        //       ),
        //     ),
        //     Expanded(
        //       child: Obx(
        //         () => Padding(
        //           padding: const EdgeInsets.all(20.0),
        //           child: BarChart(
        //             BarChartData(
        //               barTouchData: getBarTouchData(),
        //               titlesData: getTitlesData(walkController.getMaxStep()),
        //               borderData: borderData,
        //               barGroups: getBarGroups(walkController.getWeeklySteps()),
        //               gridData: FlGridData(
        //                 show: true,
        //                 drawVerticalLine: false,
        //                 horizontalInterval: walkController.getMaxStep() / 4,
        //               ),
        //               alignment: BarChartAlignment.spaceAround,
        //               maxY: walkController.getMaxStep(),
        //             ),
        //           ),
        //         ),
        //       ),
        //     ),
        //   ],
        // ),
      ),
    );
  }
  //
  // BarTouchData get barTouchData => BarTouchData(
  //       enabled: false,
  //     );
  //
  // Widget getTitles(double value, TitleMeta meta) {
  //   final bottomTitles = ['월', '화', '수', '목', '금', '토', '일'];
  //   final style = TextStyles.fs14w400cTextSecondary;
  //   String text = bottomTitles[value.toInt()];
  //   return SideTitleWidget(
  //     axisSide: meta.axisSide,
  //     child: Text(text, style: style),
  //   );
  // }
  //
  // FlTitlesData getTitlesData(maxStep) => FlTitlesData(
  //       show: true,
  //       bottomTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 30,
  //           getTitlesWidget: getTitles,
  //         ),
  //       ),
  //       leftTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       topTitles: const AxisTitles(
  //         sideTitles: SideTitles(showTitles: false),
  //       ),
  //       rightTitles: AxisTitles(
  //         sideTitles: SideTitles(
  //           showTitles: true,
  //           reservedSize: 45,
  //           interval: maxStep / 4,
  //           getTitlesWidget: (value, meta) {
  //             return SideTitleWidget(
  //               axisSide: meta.axisSide,
  //               space: 5,
  //               child: Text(
  //                 NumberFormat('###,###,###').format(value.toInt()),
  //                 style: TextStyles.fs12w400cTextSecondary,
  //                 textAlign: TextAlign.center,
  //               ),
  //             );
  //           },
  //         ),
  //       ),
  //     );
  //
  // FlBorderData get borderData => FlBorderData(
  //       show: false,
  //     );
  //
  // List<BarChartGroupData> getBarGroups(steps) {
  //   List<BarChartGroupData> barChartGroupData = [];
  //   for (int i = 0; i < steps.length; i++) {
  //     barChartGroupData.add(
  //       BarChartGroupData(
  //         x: i,
  //         barRods: [
  //           BarChartRodData(
  //             width: 16,
  //             borderRadius: BorderRadius.only(
  //               topLeft: Radius.circular(6),
  //               topRight: Radius.circular(6),
  //             ),
  //             gradient: LinearGradient(
  //               colors: [AppColors.primaryGradient, AppColors.primary],
  //               begin: Alignment.bottomCenter,
  //               end: Alignment.topCenter,
  //             ),
  //             toY: steps[i].toDouble(),
  //             color: Colors.greenAccent,
  //           ),
  //         ],
  //       ),
  //     );
  //   }
  //   return barChartGroupData;
  // }
  //
  // BarTouchData getBarTouchData() {
  //   return BarTouchData(
  //     touchTooltipData: BarTouchTooltipData(
  //       getTooltipColor: (_) => AppColors.backgroundThird,
  //       tooltipHorizontalAlignment: FLHorizontalAlignment.center,
  //       tooltipMargin: -10,
  //       getTooltipItem: (group, groupIndex, rod, rodIndex) {
  //         return BarTooltipItem(
  //           (rod.toY).toInt().toString(),
  //           TextStyles.fs17w600cTextPrimary,
  //         );
  //       },
  //     ),
  //     touchCallback: (FlTouchEvent event, barTouchResponse) {
  //       if (!event.isInterestedForInteractions ||
  //           barTouchResponse == null ||
  //           barTouchResponse.spot == null) {
  //         return;
  //       }
  //     },
  //   );
  // }
}
