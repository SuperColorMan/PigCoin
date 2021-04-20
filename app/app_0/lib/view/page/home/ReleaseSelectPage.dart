import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// ---------------------------------------
/// des: 内容发布选择页
///---------------------------------------
class ReleaseSelectPage extends StatefulWidget {
  ReleaseSelectPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ReleaseSelectPageState createState() => _ReleaseSelectPageState();
}

//页面状态配置,用于动态修改页面数据,页面事件等。
class _ReleaseSelectPageState extends State<ReleaseSelectPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
          ],
        ),
      ),
      /// 浮动按钮代替中间导航按钮
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          margin: EdgeInsets.only(left: 0, top: 35, right: 0, bottom: 0),
          width: 66,
          height: 66,
          padding: EdgeInsets.all(5),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(50), color: Colors.white),
          child: FloatingActionButton(
            heroTag: "2",
            backgroundColor: Color(GlobalColor.APP_THEME_COLOR),
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                gradient: LinearGradient(
                  //渐变位置
                    begin: Alignment.topRight, //右上
                    end: Alignment.bottomLeft, //左下
                    stops: [
                      0.0,
                      1.0
                    ], //[渐变起始点, 渐变结束点]
                    //渐变颜色[始点颜色, 结束颜色]
                    colors: [
                      Color(GlobalColor.APP_THEME_COLOR),
                      Color(GlobalColor.APP_THEME_COLOR_IS_STATUS)
                    ]),
              ),
              child: Center(
                child: Icon(
                  Icons.close,
                  size: 30,
                ),
              ),
            ),
            onPressed: () {
              /// 关闭页面
              Navigator.pop(context);
            },
          )),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}