import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/chart/PieChart.dart';


/// -------------------------------
/// Des: 圆饼图表组件
/// -------------------------------
class PieChartWidget extends StatefulWidget {

  /// 数据列表
  List dataList;

  /// 标题图标
  Image titleIcon;

  /// 标题名称
  String title;

  PieChartWidget(this.dataList,{Key key,this.titleIcon,this.title="圆饼图表"}) : super(key: key);

  @override
  _PieChartWidgetState createState() {
    return _PieChartWidgetState();
  }
}

class _PieChartWidgetState extends State<PieChartWidget> {

  @override
  Widget build(BuildContext context) {
    Widget pirChart= Container(
      /// 下边框
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 5,
                  color: Color(GlobalColor.MAX_SHALLOW_GRAY)))),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Row(
                  children: [
                    SizedBox(
                      width: 15,
                    ),
                    widget.titleIcon!=null?widget.titleIcon:Container(),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        "${widget.title}",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 200,
            child: PieChart(widget.dataList),
          ),
        ],
      ),
    );
    return pirChart;
  }
}