import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:project02_hackloop/graph/barData.dart';
import 'package:project02_hackloop/utils/color.dart';
import 'package:project02_hackloop/utils/time.dart';

class MyBar extends StatelessWidget {
  final List<int> thisWeek;
  const MyBar({super.key, required this.thisWeek});

  @override
  Widget build(BuildContext context) {
    BarData mydata = BarData(
      d0: thisWeek[0],
      d1: thisWeek[1],
      d2: thisWeek[2],
      d3: thisWeek[3],
      d4: thisWeek[4],
      d5: thisWeek[5],
      d6: thisWeek[6]
    );
    mydata.initializeBarData();

    return BarChart(
      BarChartData(
        maxY: 150,
        minY: 50,
        gridData: FlGridData(
          drawVerticalLine: false,
          drawHorizontalLine: true,
          getDrawingHorizontalLine: (value) => FlLine(
            color: toColor("bb1009"), // set the color of the horizontal lines to white
            strokeWidth: 1,
          )
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          show: true,
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getLeft, reservedSize: 34,)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: getBottom, reservedSize: 50)),
        ),
        barGroups: mydata.barData
          .map((e) => BarChartGroupData(
            x: e.x,
            barRods: [BarChartRodData(
              toY: e.y.toDouble(), // convert integer to double
              color: toColor("d4d4d4"),
              width: 10,
              borderRadius: BorderRadius.circular(2),
              )]
          )
        ).toList()
      )
    );
  }
}

Widget getBottom(double value, TitleMeta meta){
  var style1 = TextStyle(
    color: toColor("d4d4d4"),
    fontWeight: FontWeight.bold,
    fontSize: 16
  );

  Widget text;
  String a0,a1,a2,a3,a4,a5,a6;
  a0 = pastDate(7).toString();
  a1 = pastDate(6).toString();
  a2 = pastDate(5).toString();
  a3 = pastDate(4).toString();
  a4 = pastDate(3).toString();
  a5 = pastDate(2).toString();
  a6 = pastDate(1).toString();
  switch (value.toInt()){
    case 0:
      text = Text(a0,style: style1,);
      break;
    case 1:
      text = Text(a1,style: style1,);
      break;
    case 2:
      text = Text(a2,style: style1,);
      break;
    case 3:
      text = Text(a3,style: style1,);
      break;
    case 4:
      text = Text(a4,style: style1,);
      break;
    case 5:
      text = Text(a5,style: style1,);
      break;
    case 6:
      text = Text(a6,style: style1,);
      break;
    default:
      text = Text("", style: style1,);
      break;
  }
  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}

Widget getLeft(double value, TitleMeta meta){
  var style1 = TextStyle(
    color: toColor("d4d4d4"),
    fontSize: 14
  );

  Widget text;
  text = Text(value.toInt().toString(),style: style1,);

  return SideTitleWidget(child: text, axisSide: meta.axisSide);
}