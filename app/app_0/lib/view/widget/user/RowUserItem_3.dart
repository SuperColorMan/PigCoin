import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';

/// -------------------------------
/// Des: 创建用户行级项3,包含了左滑的删除按钮。
/// -------------------------------
class RowUserItem_3 extends StatefulWidget {
  Map userStructure;

  RowUserItem_3(this.userStructure, {Key key}) : super(key: key);

  @override
  _RowUserItem_3State createState() {
    return _RowUserItem_3State();
  }
}

class _RowUserItem_3State extends State<RowUserItem_3> {
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
    return Slidable(
      key: Key(_userId),
      dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(), onDismissed: (actionType) {}),
      actionPane: SlidableScrollActionPane(),
      //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      child: Container(
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
                      width: 60,
                      height: 60,
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 用户名
                          Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  '${_userName}',
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              )),

                          /// 关注时间
                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Text("${_time}",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: new Color(0xffa6a7a8),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    /// 关注标记
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(right: 0),
                        child: Text(
                          "关注了你",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        //右侧按钮列表
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: false,
          onTap: () {},
        ),
      ],
    );
  }
}
