import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';

class WelComePage extends StatefulWidget {
  @override
  _WelComePageState createState() => _WelComePageState();
}

class _WelComePageState extends State<WelComePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    FlutterAppBadger.isAppBadgeSupported().then((value){
      if(value){
        /// 新消息提示
        FlutterAppBadger.updateBadgeCount(999);
      }
    });
    Future.delayed(Duration(milliseconds: 1000)).whenComplete(() {
      //前往主页面
      GlobalRouteTable.goHomePage(context, 0);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Container(
        color: Colors.white,
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              child: Image.asset(GlobalFilePath.APP_WELCOME_MAIN_IMG),
            ),
            Positioned(
              bottom: 80,
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10),
                      ),
                      child: Image.asset(
                        GlobalFilePath.APP_LOGO,
                        fit: BoxFit.fill,
                        width: 60,
                        height: 60,
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(left: 20),
                      child: Image.asset(
                        GlobalFilePath.APP_TITLE,
                        fit: BoxFit.fill,
                        width: 138,
                        height: 60,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
