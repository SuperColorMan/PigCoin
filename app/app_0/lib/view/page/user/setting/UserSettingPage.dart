import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';

class UserSettingPage extends StatefulWidget {
  UserSettingPage({Key key}) : super(key: key);

  @override
  _UserSettingPageState createState() => _UserSettingPageState();
}

class _UserSettingPageState extends State<UserSettingPage>
    with TickerProviderStateMixin {
  bool flag = false;

  //获取内容List
  Widget _getList() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return new Column(
              children: [
                /// 设置区域
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      /// 账号与安全
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          GlobalRouteTable.goUserAccountSecurityPage(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("账号与安全", style: TextStyle(fontSize: 15)),
                              Icon(Icons.chevron_right_outlined),
                            ],
                          ),
                        ),
                      ),

                      /// 通知设置
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          GlobalRouteTable.goUserMessageSettingPage(context);
                        },
                        child: Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("通知设置", style: TextStyle(fontSize: 15)),
                              Icon(Icons.chevron_right_outlined),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 设置区域
                Container(
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      /// 用户协议
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("用户协议", style: TextStyle(fontSize: 15)),
                            Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      ),

                      /// 隐私政策
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("隐私协议", style: TextStyle(fontSize: 15)),
                            Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      ),

                      /// 社区公约
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("社区公约", style: TextStyle(fontSize: 15)),
                            Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// 退出登录
                GestureDetector(
                  onTap: () {
                    /// 删除登录用户id
                    GlobalLocalCache.delLoginUserId();

                    /// 删除登录用户信息
                    GlobalLocalCache.delLoginUserInfo();

                    /// 回到用户页
                    GlobalRouteTable.goHomePage(context, 4);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10),
                    color: Colors.white,
                    width: double.infinity,
                    padding: EdgeInsets.only(
                        left: 20, right: 20, top: 20, bottom: 20),
                    child: Center(
                      child: Text(
                        "退出登录",
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                  ),
                )
              ],
            );
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff9fafb),
        appBar: PreferredSize(
            child: AppBar(
              title: Text(
                '设置',
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
            preferredSize: Size.fromHeight(50)),
        body: _getList());
  }
}
