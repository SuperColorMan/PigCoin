import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';

/// -------------------------------
/// Des: 创建用户行级项1
/// -------------------------------
class RowUserItem_1 extends StatefulWidget {
  Map userStructure;

  RowUserItem_1(this.userStructure, {Key key}) : super(key: key);

  @override
  _RowUserItem_1State createState() {
    return _RowUserItem_1State();
  }
}

class _RowUserItem_1State extends State<RowUserItem_1> {
  @override
  Widget build(BuildContext context) {
    Map userStructure = widget.userStructure;

    /// 时间
    String _time = userStructure['time'].toString();

    /// 发起关注的用户
    Map _userInfo = userStructure['userInfo'] as Map;

    /// 用户id
    String _userId = userStructure['id'].toString();

    /// 用户名
    String _userName = userStructure['name'].toString();
    return Container(
      padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          /// 头像
          Expanded(
              flex: 2,
              child: Center(
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}',
                    fit: BoxFit.fill,
                    width: 70,
                    height: 70,
                    // color: Colors.black
                  ),
                ),
              )),

          ///用户信息
          Expanded(
              flex: 8,
              child: Column(
                children: [
                  ///用户名
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 0),
                      child: Text(
                        userStructure['name'],
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      )),
                  SizedBox(
                    height: 2,
                  ),

                  /// 用户简介
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 0),
                      child: Text(
                        "我是彩色侠我是彩色侠我是彩色侠我是彩色侠我是彩色侠我是彩色侠我是彩色侠我是彩色侠我是彩色侠我是彩色侠我是彩色侠我是彩色侠",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 13,
                        ),
                      )),
                  SizedBox(
                    height: 2,
                  ),

                  /// 粉丝量
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Text("粉丝: 1234567890",
                            style: TextStyle(
                              fontSize: 13,
                              color: new Color(0xffa6a7a8),
                            )),
                      ],
                    ),
                  ),
                ],
              )),

          /// 关注按钮
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Center(
                  child: FlatButton(
                    height: 30,
                    splashColor: Colors.black87,
                    child: Text(
                      '关注',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    onPressed: () {
                      /// 执行关注
                    },
                    color: Color(GlobalColor.APP_THEME_COLOR),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
