import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

import 'ShopIndexHomePage.dart';

/// -------------------------------
/// Des: 商城首页框架
/// -------------------------------

class ShopIndexPage extends StatefulWidget {

  /// 分类列表
  List<Widget> commodityClassifyList = [];

  /// 分类页数组
  List<Widget> commodityClassifyPageList = [];

  ShopIndexPage(this.commodityClassifyList,this.commodityClassifyPageList,{Key key, this.title}) : super(key: key);

  final String title;

  @override
  _ShopIndexPageState createState() => _ShopIndexPageState();
}

class _ShopIndexPageState extends State<ShopIndexPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  void initState() {}

  @override
  Widget build(BuildContext context) {
    /// ------------------- 更多功能按钮 start -------------------
    List<Widget> _moreBtnList = [
      /// 购物车
      GestureDetector(
        onTap: () {
          SmartDialog.dismiss();
          GlobalRouteTable.goShoppingCartPage(context, () {});
        },
        child: Container(
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.shopping_cart_outlined),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("购物车"),
              ),
            ],
          ),
        ),
      ),

      /// 订单
      GestureDetector(
        onTap: () {
          SmartDialog.dismiss();
          GlobalRouteTable.goUserOrderFormPage(context, () {});
        },
        child: Container(
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.assignment_outlined),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("订单"),
              ),
            ],
          ),
        ),
      ),

      /// 地址管理
      Container(
        decoration: new BoxDecoration(
          //背景
          color: Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.location_on),
            Container(
              margin: EdgeInsets.only(top: 10),
              child: Text("地址管理"),
            ),
          ],
        ),
      ),

      /// 分类
      GestureDetector(
        onTap: () {
          /// 关闭弹窗
          SmartDialog.dismiss();
          GlobalRouteTable.goCommodityClassifyPage(context, () {},
              defaultIndex: 1);
        },
        child: Container(
          decoration: new BoxDecoration(
            //背景
            color: Colors.white,
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.apps),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("分类"),
              ),
            ],
          ),
        ),
      ),
    ];

    /// ------------------- 更多功能按钮 end -------------------

    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: Container(
          margin: EdgeInsets.only(bottom: 30, right: 10),
          width: 58,
          height: 58,
          padding: EdgeInsets.all(5),
          child: FloatingActionButton(
            heroTag: "3",
            backgroundColor: Colors.transparent,
            child: Container(
              child: Stack(
                children: [
                  /// 毛玻璃蒙层
                  ClipRect(
                      child: Center(
                    child: Opacity(
                      //透明控件
                      opacity: 0.5,
                      child: Container(
                        // 容器组件
                        width: 50.0,
                        height: 50.0,
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.all(Radius.circular(558.0)),
                            color: Colors.black), //盒子装饰器，进行装饰，设置颜色为灰色
                      ),
                    ),
                  )),

                  /// 按钮icon
                  Center(
                    child: Icon(
                      Icons.shopping_cart_outlined,
                      size: 25,
                    ),
                  ),
                ],
              ),
            ),
            onPressed: () {
              /// 前往购物车
              SmartDialog.dismiss();
              GlobalRouteTable.goShoppingCartPage(context, () {});
            },
          )),
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          leading: GestureDetector(
            onTap: () {
              GlobalRouteTable.goUserOrderFormPage(context, () {});
            },
            child: Container(
              alignment: Alignment.centerRight,
              padding: EdgeInsets.only(top: 8, right: 6),
              child: Column(
                children: [
                  Image.asset(
                    GlobalFilePath.TITLE_LOGO_10,
                    width: 20,
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 3),
                    child: Text(
                      '订单',
                      style: TextStyle(color: Colors.black, fontSize: 13),
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget>[
            /// 分类
            GestureDetector(
              onTap: () {
                GlobalRouteTable.goCommodityClassifyPage(context, () {},
                    defaultIndex: 1);
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 6, right: 20),
                child: Column(
                  children: [
                    Image.asset(
                      GlobalFilePath.TITLE_LOGO_9,
                      width: 20,
                      height: 20,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 5,
                      ),
                      child: Text(
                        '分类',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// 更多
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                /// 菜单弹窗
                SmartDialog.show(
                    alignmentTemp: Alignment.topCenter,
                    widget: Container(
                      decoration: new BoxDecoration(
                        //背景
                        color: Color(GlobalColor.MAX_SHALLOW_GRAY),
//                        color: Colors.yellow,
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      padding: EdgeInsets.only(left: 15, right: 15, top: 50),
                      width: double.infinity,
                      height: 218,
//                      color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          /// 标题区域
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(top: 16, bottom: 16),
                            width: double.infinity,
                            child: Text(
                              "更多功能",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 16),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          /// 选项区域
                          Expanded(
                            child: GridView.builder(
                                padding: EdgeInsets.only(top: 0),
                                physics: NeverScrollableScrollPhysics(),
                                //禁止滑动
                                gridDelegate:
                                    SliverGridDelegateWithFixedCrossAxisCount(
                                        //横轴元素个数
                                        crossAxisCount: 4,
                                        //纵轴间距
                                        mainAxisSpacing: 15.0,
                                        //横轴间距
                                        crossAxisSpacing: 15.0,
                                        //子组件宽高长度比例
                                        childAspectRatio: 1.0),
                                itemCount: _moreBtnList.length,
                                itemBuilder: (BuildContext context, int index) {
                                  //Widget Function(BuildContext context, int index)
                                  return _moreBtnList[index];
                                }),
                          ),
                        ],
                      ),
                    ));
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 6, right: 15),
                child: Column(
                  children: [
                    Image.asset(
                      GlobalFilePath.TITLE_LOGO_12,
                      width: 21,
                      height: 21,
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: 4,
                      ),
                      child: Text(
                        '更多',
                        style: TextStyle(color: Colors.black, fontSize: 13),
                      ),
                    ),
                  ],
                ),
              ),
            ),
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
        preferredSize: Size.fromHeight(50),
      ),
      body: ShopIndexHomePage(widget.commodityClassifyList,widget.commodityClassifyPageList,),
    );
  }
}

//选项卡
class AppBarTabsItem extends StatelessWidget {
  const AppBarTabsItem({Key key, this.text, this.onTap, this.active})
      : super(key: key);

  final String text;
  final GestureTapCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        children: [
          Container(
            // color: Colors.pink,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  // 如果不用透明色，就会出现文字偏移现象
                  // 因为border没有的情况下容器里只有文字的元素，所以高度会比有border的元素少一点
                  color: this.active ? _theme.primaryColor : Colors.transparent,
                ),
              ),
            ),
            child: Text(
              this.text,
              style: TextStyle(
                color: this.active ? Colors.black : _theme.disabledColor,
                fontSize: _theme.textTheme.bodyText1.fontSize + 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
