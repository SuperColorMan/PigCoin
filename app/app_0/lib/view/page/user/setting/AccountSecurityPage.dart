import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccountSecurityPage extends StatefulWidget {
  AccountSecurityPage({Key key}) : super(key: key);

  @override
  _AccountSecurityPageState createState() => _AccountSecurityPageState();
}

class _AccountSecurityPageState extends State<AccountSecurityPage>
    with TickerProviderStateMixin {
  bool flag = false;

  //构建页
  Widget _buildPage() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return new Column(
              children: [
                /// 设置区域
                Container(
                  margin: EdgeInsets.only(top: 10),
                  color: Colors.white,
                  padding: EdgeInsets.only(left: 20, right: 20),
                  child: Column(
                    children: [
                      /// 修改密码
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("修改密码", style: TextStyle(fontSize: 15)),
                            Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      ),

                      /// 注销账号
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("注销账号", style: TextStyle(fontSize: 15)),
                            Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      ),

                      /// 登录设备管理
                      Container(
                        padding: EdgeInsets.only(top: 20, bottom: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("登录设备管理", style: TextStyle(fontSize: 15)),
                            Icon(Icons.chevron_right_outlined),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
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
        backgroundColor: Colors.white,
        appBar: PreferredSize(
            child: AppBar(
              title: Text(
                '账号与安全',
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
        body: _buildPage());
  }
}
