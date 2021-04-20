/// ----------------------------------
/// des: 用户商品页
/// ----------------------------------
import 'package:flutter/material.dart';

class UserCommodityPage extends StatefulWidget {
  /// 页面标题
  String pageTitle;

  UserCommodityPage({Key key, this.pageTitle}) : super(key: key);

  @override
  _UserCommodityPageState createState() => _UserCommodityPageState();
}

//页面状态配置,用于动态修改页面数据,页面事件等。
class _UserCommodityPageState extends State<UserCommodityPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.pageTitle != null ? widget.pageTitle : '用户商品',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
//        automaticallyImplyLeading: false,
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
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[],
        ),
      ),
    );
  }
}
