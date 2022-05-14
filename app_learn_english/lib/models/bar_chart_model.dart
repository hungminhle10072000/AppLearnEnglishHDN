import 'package:charts_flutter/flutter.dart' as charts;

class BarChartModel {
  String daysOfTheWeek;
  int score;
  final charts.Color color;

  BarChartModel({
    required this.daysOfTheWeek,
    required this.score,
    required this.color,
  });
}
