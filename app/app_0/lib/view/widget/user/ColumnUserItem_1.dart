import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';

/// -------------------------------
/// Des: 创建用户列级项1
/// -------------------------------
class ColumnUserItem_1 extends StatefulWidget {
  Map userStructure;

  ColumnUserItem_1(this.userStructure, {Key key}) : super(key: key);

  @override
  _ColumnUserItem_1State createState() {
    return _ColumnUserItem_1State();
  }
}

class _ColumnUserItem_1State extends State<ColumnUserItem_1> {
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
        child: Column(
          children: [
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
            Container(
              width: 80,
              margin: EdgeInsets.only(top: 10),
              child: Text(
                userStructure['name'],
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
          ],
        ));
  }
}
