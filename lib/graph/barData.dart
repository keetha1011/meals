import 'package:project02_hackloop/graph/indivisualBar.dart';

class BarData {
  final int d0;
  final int d1;
  final int d2;
  final int d3;
  final int d4;
  final int d5;
  final int d6;

  BarData({
    required this.d0,
    required this.d1,
    required this.d2,
    required this.d3,
    required this.d4,
    required this.d5,
    required this.d6,
  });

  List<indivisualBar> barData = [];

  void initializeBarData() {
    barData = [
      indivisualBar(x: 0, y: d0.toDouble()),
      indivisualBar(x: 1, y: d1.toDouble()),
      indivisualBar(x: 2, y: d2.toDouble()),
      indivisualBar(x: 3, y: d3.toDouble()),
      indivisualBar(x: 4, y: d4.toDouble()),
      indivisualBar(x: 5, y: d5.toDouble()),
      indivisualBar(x: 6, y: d6.toDouble()),
    ];
  }
}
