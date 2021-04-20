import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';

/// -------------------------------
/// Des: 创建用户列级项2
/// -------------------------------
class ColumnUserItem_2 extends StatefulWidget {
  Map userStructure;

  ColumnUserItem_2(this.userStructure, {Key key}) : super(key: key);

  @override
  _ColumnUserItem_2State createState() {
    return _ColumnUserItem_2State();
  }
}

class _ColumnUserItem_2State extends State<ColumnUserItem_2> {
  @override
  Widget build(BuildContext context) {
    Map userStructure = widget.userStructure;
    /// 时间
    String _time = userStructure['time'].toString();

    /// 发起关注的用户
    Map _userInfo = userStructure['userInfo'] as Map;

    /// 用户id
    String _userId = _userInfo['id'].toString();

    /// 用户名
    String _userName = _userInfo['name'].toString();

    /// 用户互动信息
    Map _tuInteractionInfo = userStructure['tuInteractionInfo'];

    /// 粉丝量
    String fansCount = "0";
    if (_tuInteractionInfo != null) {
      fansCount = _tuInteractionInfo['fansCount'];
    }
    return Card(
      elevation: 4.0, //阴影
      color: Colors.grey, //背景色
      child: new Container(
        color: Colors.white,
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        child: Column(
          children: [
            Column(
              children: [
                /// 头像
                Center(
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                        '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}',
                        fit: BoxFit.fill,
                        width: 55,
                        height: 55,
                        // color: Colors.black
                      ),
                    )),

                /// 用户名
                Container(
                  width: 90,
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "${userStructure['name']}",
                    textAlign: TextAlign.center,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),

                /// 粉丝数
                Container(
                  margin: EdgeInsets.only(left: 5, top: 10),
                  child: Row(
                    children: [
                      Text("${fansCount}个粉丝",
                          style: TextStyle(
                            fontSize: 13,
                            color: new Color(0xffa6a7a8),
                          )),
                    ],
                  ),
                ),

                /// 分隔区域
                SizedBox(
                  height: 15,
                ),

                /// 关注按钮
                Container(
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
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
