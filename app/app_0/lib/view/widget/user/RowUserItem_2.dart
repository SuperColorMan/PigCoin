import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';

/// -------------------------------
/// Des: 创建用户行级项2
/// -------------------------------
class RowUserItem_2 extends StatefulWidget {
  Map userStructure;

  RowUserItem_2(this.userStructure, {Key key}) : super(key: key);

  @override
  _RowUserItem_2State createState() {
    return _RowUserItem_2State();
  }
}

class _RowUserItem_2State extends State<RowUserItem_2> {
  @override
  Widget build(BuildContext context) {
    Map userStructure = widget.userStructure;
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
                    width: 58,
                    height: 58,
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
                        _userName,
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
        ],
      ),
    );
  }
}
