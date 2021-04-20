import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:charts_flutter/flutter.dart' as charts;

/// -------------------------------
/// Des: 圆饼图
/// -------------------------------
class PieChart extends StatefulWidget {
  List<PieSales> dataList;
  String unit;
  PieChart(this.dataList, {Key key,this.unit="件"}) : super(key: key);

  @override
  _PieChartState createState() {
    return _PieChartState();
  }
}

class _PieChartState extends State<PieChart> {
  Widget _simplePie() {
    var random = Random();

    var data = widget.dataList;

    var seriesList = [
      charts.Series<PieSales, int>(
        domainFn: (PieSales sales, _) => sales.value,
        measureFn: (PieSales sales, _) => sales.value,
        data: data,
        labelAccessorFn: (PieSales row, _) =>
            '${row.title}: ${row.value}${widget.unit}',
      )
    ];

    return charts.PieChart(seriesList,
        animate: true,
        defaultRenderer: new charts.ArcRendererConfig(arcRendererDecorators: [
          new charts.ArcLabelDecorator(
              labelPosition: charts.ArcLabelPosition.outside)
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return _simplePie();
  }
}

class PieSales {
  final int value;
  final String title;

  PieSales(this.value, {this.title,});
}
