/// ----------------------------------
/// des: 爆款商品页面
/// ----------------------------------
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

class HotCommodityPage extends StatefulWidget {
  HotCommodityPage({Key key}) : super(key: key);

  @override
  _HotCommodityPageState createState() => _HotCommodityPageState();
}

//页面状态配置,用于动态修改页面数据,页面事件等。
class _HotCommodityPageState extends State<HotCommodityPage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(Icons.arrow_back_ios,color: Color(GlobalColor.SHALLOW_GRAY),),
        ),
        actions: <Widget>[
        ],
        title: Container(
          child: TextField(
            onTap: () {},
            onChanged: (String str) {},

            /// 设置字体
            style: TextStyle(),

            /// 设置输入框样式
            decoration: InputDecoration(
              hintText: '请输入搜索关键词',

              /// 边框
              // border: OutlineInputBorder(
              //   borderSide: BorderSide(width: 10, color: Colors.red),
              //   borderRadius: BorderRadius.all(
              //     /// 里面的数值尽可能大才是左右半圆形，否则就是普通的圆角形
              //     Radius.circular(50),
              //   ),
              // ),
              // border: InputBorder.none, //去掉输入框的边框,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(35),
                borderSide: BorderSide.none,
              ),
              // fillColor: Theme.of(context).disabledColor,
              // fillColor: Colors.grey[200],
              // 是否使用填充色
              filled: true,

              ///设置内容内边距
              // contentPadding: EdgeInsets.only(
              //   top: 0,
              //   bottom: 0,
              // ),
              contentPadding: const EdgeInsets.symmetric(vertical: 4.0),

              /// 前缀图标
              prefixIcon: Icon(Icons.search),
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          ],
        ),
      ),
    );
  }
}