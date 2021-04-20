import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/card/ContentCard_1.dart';

/// -------------------------------
/// Des: 构建搜索主页榜单区域结构
/// -------------------------------
class SearchHomeLevelArea extends StatefulWidget {
  String title;
  String titleLogo;
  List contentList;

  SearchHomeLevelArea(this.title, this.titleLogo, this.contentList, {Key key})
      : super(key: key);

  @override
  _SearchHomeLevelAreaState createState() {
    return _SearchHomeLevelAreaState();
  }
}

class _SearchHomeLevelAreaState extends State<SearchHomeLevelArea> {
  @override
  Widget build(BuildContext context) {
    /// 内容卡片列表
    List _contentCardList = List();
    for (Map m in widget.contentList) {
      _contentCardList.add(ContentCard_1(m));
    }
    return Container(
      child: Column(
        children: [
          /// 标题
          Container(
            alignment: Alignment.center,
            margin: EdgeInsets.only(top: 20),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    /// 标题图标
                    Container(
                      margin: EdgeInsets.only(right: 10),
                      alignment: Alignment.center,
                      width: 30,
                      height: 30,
                      child: Image.asset(
                        widget.titleLogo,
                        fit: BoxFit.fill,
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Text(
                      "${widget.title}",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    /// 前往榜单详情页
                    GlobalRouteTable.goSearchLevelListPage(context);
                  },
                  child: Row(
                    children: [
                      Text(
                        "完整榜单",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(GlobalColor.SHALLOW_GRAY),
                        ),
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 15,
                        color: Color(GlobalColor.SHALLOW_GRAY),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          /// 榜单前10内容
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 10, right: 10),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                /// 内容卡片
                ContentCard_1(Map()),
                ContentCard_1(Map()),
                ContentCard_1(Map()),
                ContentCard_1(Map()),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}
