import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// -------------------------------
/// Des: 折线图
/// -------------------------------
class LineChart extends StatefulWidget {

  List<Linesales> saleCommoditySumDataList;

  LineChart(this.saleCommoditySumDataList,{Key key}) : super(key: key);

  @override
  _LineChartState createState() {
    return _LineChartState();
  }
}

class _LineChartState extends State<LineChart> {
  Widget getLine() {
    var random = Random();

    List<Linesales> dataLine = widget.saleCommoditySumDataList;

    var seriesLine = [
      charts.Series<Linesales, int>(
        data: dataLine,
        domainFn: (Linesales lines, _) => lines.day,
        measureFn: (Linesales lines, _) => lines.sale,
        id: "Lines",
      )
    ];
    //是TimeSeriesChart，而不是LineChart,因为x轴是DataTime类
//    Widget line = charts.TimeSeriesChart(seriesLine);
    Widget line = charts.LineChart(seriesLine);
    return line;
  }

  @override
  Widget build(BuildContext context) {
    return getLine();
  }
}

class Linesales {
  int day;
  int sale;
  Linesales(this.day, this.sale);
}
