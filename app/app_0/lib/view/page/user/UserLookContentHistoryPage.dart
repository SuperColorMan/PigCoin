/// ----------------------------------
/// des: 用户查看内容历史页
/// ----------------------------------
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/widget/comm/GlobalContentList.dart';

class UserLookContentHistoryPage extends StatefulWidget {
  /// 指定用户id
  String userId;

  UserLookContentHistoryPage(this.userId, {Key key}) : super(key: key);

  @override
  _UserLookContentHistoryPageState createState() =>
      _UserLookContentHistoryPageState();
}

class _UserLookContentHistoryPageState
    extends State<UserLookContentHistoryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text(
          '查看历史',
          style: TextStyle(color: Colors.black87),
        ),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black87,
              ),
              iconSize: 28,
            ),
            margin: EdgeInsets.only(left: 15),
          ),
        ),
      ),
      body: GlobalContentList(
          GlobalConst.NET_API_CALL.getLookContentHistoryByUserId,
          {"userId": widget.userId}),
    );
  }
}
