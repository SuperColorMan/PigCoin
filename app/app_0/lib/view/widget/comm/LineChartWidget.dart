import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/chart/LineChart.dart';

import 'GroupButtons.dart';

/// -------------------------------
/// Des: 直线图表组件
/// -------------------------------
class LineChartWidget extends StatefulWidget {
  /// 数据列表
  List dataList;

  /// 按钮列表
  List<Widget> buttonList;

  /// 按钮选中句柄列表
  List<bool> clickList;

  /// 点击回调
  Function callBack;

  /// 标题图标
  Image titleIcon;

  /// 标题名称
  String title;

  LineChartWidget(this.dataList, this.buttonList, this.clickList,
      {Key key, this.callBack, this.titleIcon, this.title = "折线图"})
      : super(key: key);

  @override
  _LineChartWidgetState createState() {
    return _LineChartWidgetState();
  }
}

class _LineChartWidgetState extends State<LineChartWidget> {
  @override
  Widget build(BuildContext context) {
    Widget _lineChart = Container(
      /// 下边框
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border(
              bottom: BorderSide(
                  width: 5, color: Color(GlobalColor.MAX_SHALLOW_GRAY)))),
      padding: EdgeInsets.only(top: 15, bottom: 15),
      width: double.infinity,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    widget.titleIcon != null ? widget.titleIcon : Container(),
                    Container(
                      padding: EdgeInsets.only(left: 5),
                      child: Text(
                        widget.title,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 38,
                  child: GroupButtons(
                    widget.buttonList,
                    widget.clickList,
                    callBack: (index) {
                      setState(() {
                        widget.callBack(index);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.only(left: 35, right: 35),
            margin: EdgeInsets.only(top: 10),
            width: double.infinity,
            height: 200,
            child: LineChart(widget.dataList),
          ),
        ],
      ),
    );
    return _lineChart;
  }
}
