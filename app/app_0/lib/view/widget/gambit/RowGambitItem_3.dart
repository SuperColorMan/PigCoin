import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';
import 'package:xhd_app/view/widget/card/ContentCard_1.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';

/// -------------------------------
/// Des: 创建话题行级项3,下方带推荐内容
/// -------------------------------
class RowGambitItem_3 extends StatefulWidget {
  Map gambitStruct;

  RowGambitItem_3(this.gambitStruct, {Key key}) : super(key: key);

  @override
  _RowGambitItem_3State createState() {
    return _RowGambitItem_3State();
  }
}

class _RowGambitItem_3State extends State<RowGambitItem_3> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GlobalRouteTable.goGambitHomePage(context, widget.gambitStruct);
      },
      child: Container(
        /// 下边框
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 1, color: Color(GlobalColor.MAX_SHALLOW_GRAY)))),
        padding: EdgeInsets.only(left: 10, right: 10, top: 15, bottom: 15),
        child: Column(
          children: [
            /// 话题信息
            Row(
              children: [
                Container(
                  child: CachedNetworkImage(
                    imageUrl:
                        '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=4&${GlobalDateUtil.getCurrentTimestamp()}',
                    fit: BoxFit.fill,
                    width: 55,
                    height: 55,
                    // color: Colors.black
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 10),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          widget.gambitStruct['name'],
                          textAlign: TextAlign.left,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 10, top: 5),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          '内容数: ${widget.gambitStruct['contentCount']}',
                          style:
                              TextStyle(color: Color(GlobalColor.SHALLOW_GRAY)),
                        ),
                      ),
                    ],
                  ),
                ),
                GestureDetector(
                  child: Container(
                    width: 60,
                    height: 30,
                    child: CommWidgetBuilder.gradientButton("关注", fontSize: 14),
                  ),
                ),
              ],
            ),

            /// 推荐内容
            Container(
              width: double.infinity,
              margin: EdgeInsets.only(top: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
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
      ),
    );
  }
}
