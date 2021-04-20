import 'package:badges/badges.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bubble/bubble_widget.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:vibration/vibration.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/page/home/hometabpage/index/IndexPage.dart';
import 'package:xhd_app/view/page/shop/index/ShopIndexPage.dart';
import 'package:xhd_app/view/page/shop/index/childpage/ShopIndexHomePage_Child.dart';
import 'package:xhd_app/view/page/shop/index/childpage/ShopIndexHomePage_Recommend.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';

import 'hometabpage/message/MessagePage.dart';
import 'hometabpage/mypage/MyPage.dart';

/// ----------------------------------
/// des : 主页
/// ----------------------------------
class HomePage extends StatefulWidget {
  int _tabIndex = 1;

  //通过构造方法传值
  HomePage(this._tabIndex);

  //主要是负责创建state
  @override
  HomePageState createState() => HomePageState(_tabIndex);
}

class HomePageState extends State<HomePage> {
  /// 气泡框透明度
  double _bubbleOpacityLevel = 0.0;

  /// 气泡可见性
  bool _bubbleIsShow = false;

  int _tabIndex = 0;

  HomePageState(this._tabIndex);

  var _pageController;

  /// 点击导航项是要显示的页面
  List<Widget> pages = [];

  /// 分类名称数组
  List<Widget> _commodityClassifyList = [
    Text('推荐'),
  ];

  /// 分类页数组
  List<Widget> _commodityClassifyPageList = [
    ShopIndexHomePage_Recommend(
        GlobalConst.NET_API_CALL.getRecommendCommodityList,
        {"contentClassify": "1"}),
  ];

  @override
  void initState() {
    /// ------------------ 初始化底部tab切换页面 start ------------------
    setState(() {
      pages = [
        IndexPage(),
        ShopIndexPage(_commodityClassifyList, _commodityClassifyPageList),
        null,
        MessagePage(),
        MyPage()
      ];
    });
    /// ------------------ 初始化底部tab切换页面 end ------------------

    /// ------------------ 初始化商品页类型切换 start ------------------
    GlobalConst.NET_API_CALL.getBigClassifyList().then((value) {
      if (value['code'] == 0) {
        List bigClassifyList = value['data'];
        setState(() {
          for (Map m in bigClassifyList) {
            _commodityClassifyList.add(Text(m['name'].toString()));
            _commodityClassifyPageList.add(
              ShopIndexHomePage_Child(
                  GlobalConst.NET_API_CALL.getCommodityListByBigClassifyId,
                  {"bigClassifyId": m['id'].toString()}),
            );
          }
        });
      } else if (value['code'] == 1) {
        GlobalToast.showToast("加载错误");
      }
    });

    /// ------------------ 初始化商品页类型切换 end ------------------

    /// 初始化，这个函数在生命周期中只调用一次
    super.initState();

    /// 设置默认页
    _pageChanged(this._tabIndex);
    _pageController = PageController(initialPage: this._tabIndex);
  }

  @override
  Widget build(BuildContext context) {
    //构建页面
    return buildBottomTabScaffold();
  }

  //底部导航栏显示的内容
  final List<BottomNavigationBarItem> bottomNavItems = [
    BottomNavigationBarItem(
      backgroundColor: Color(GlobalColor.APP_THEME_COLOR),
      icon: Icon(Icons.home),
      title: Text("首页"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Color(GlobalColor.APP_THEME_COLOR),
      icon: Badge(
        badgeContent: Text('3', style: TextStyle(color: Colors.white)),
        child: Icon(FontAwesome.shopping_bag),
      ),
      title: Text("商城"),
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.add,
        color: Colors.transparent,
      ),
      title: SizedBox(
        width: 0,
      ),
    ),
    BottomNavigationBarItem(
      backgroundColor: Color(GlobalColor.APP_THEME_COLOR),
      icon: Badge(
        badgeContent: Text('3', style: TextStyle(color: Colors.white)),
        child: Icon(Icons.message),
      ),
      title: Text("消息"),
    ),
    BottomNavigationBarItem(
      backgroundColor: Color(GlobalColor.APP_THEME_COLOR),
      icon: Icon(Icons.person),
      title: Text("我的"),
    ),
  ];

  //底部导航栏显示的内容
  final List<Widget> bottomNavItems_2 = [
    GestureDetector(
      child: IconButton(
          icon: Icon(Icons.home, color: Colors.white), onPressed: () {}),
    ),
    GestureDetector(
      child: IconButton(
          icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
    ),
    SizedBox(
      width: 66,
    ),
    GestureDetector(
      child: IconButton(
          icon: Icon(Icons.message, color: Colors.white), onPressed: () {}),
    ),
    GestureDetector(
      child: IconButton(
          icon: Icon(Icons.person, color: Colors.white), onPressed: () {}),
    ),
  ];

  Widget buildBottomTabScaffold() {
    return Scaffold(
      backgroundColor: Colors.white,

      /// 浮动按钮代替中间导航按钮
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
          margin: EdgeInsets.only(left: 0, top: 35, right: 0, bottom: 0),
          width: 66,
          height: 66,
          padding: EdgeInsets.all(5),
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
                  Icons.add,
                  size: 30,
                ),
              ),
            ),
            onPressed: () {
              /// 前往内容发布页面
              setState(() {
                _bubbleOpacityLevel = 1.0;
                _bubbleIsShow = true;
              });
            },
          )),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 28,
        items: bottomNavItems,
        currentIndex: _tabIndex,
        selectedItemColor: Color(GlobalColor.APP_THEME_COLOR),
        //所以一般都是使用fixed模式，此时，导航栏的图标和标题颜色会使用fixedColor指定的颜色，
        // 如果没有指定fixedColor，则使用默认的主题色primaryColor
        type: BottomNavigationBarType.fixed,
        //底部菜单点击回调
        onTap: (index) async {
//          _changePage(index);
          /// 震动反馈
          if (await Vibration.hasCustomVibrationsSupport()) {
            Vibration.vibrate(duration: 500);
          } else {
            Vibration.vibrate();
            await Future.delayed(Duration(milliseconds: 500));
            Vibration.vibrate();
          }
          _pageController.jumpToPage(index);
        },
      ),
      //对应的页面
      body: SafeArea(
        child: Stack(
          children: [
            /// 内容区域
            PageView.builder(
                //要点1
                physics: NeverScrollableScrollPhysics(),
                //禁止页面左右滑动切换
                controller: _pageController,
                onPageChanged: _pageChanged,
                //回调函数
                itemCount: pages.length,
                itemBuilder: (context, index) => pages[index]),

            /// 蒙层
            _buildOverlay(),

            /// 气泡框
            _vuildBuddleBox(),
          ],
        ),
      ),
    );
  }

  /// 构建蒙层
  Widget _buildOverlay() {
    if (_bubbleIsShow) {
      return AnimatedOpacity(
        onEnd: () {
          setState(() {
            _bubbleIsShow = false;
          });
        },
        opacity: _bubbleOpacityLevel,
        duration: new Duration(milliseconds: 100), //过渡时间：1
        child: GestureDetector(
          onTap: () {
            setState(() {
              _bubbleOpacityLevel = 0.0;
            });
          },
          child: Container(
            color: Colors.transparent,
            width: double.infinity,
            height: double.infinity,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  /// 构建气泡框
  Widget _vuildBuddleBox() {
    if (_bubbleIsShow) {
      return Positioned(
        bottom: 15,
        child: AnimatedOpacity(
          onEnd: () {
            setState(() {
              _bubbleIsShow = false;
            });
          },
          // 使用一个AnimatedOpacity Widget
          opacity: _bubbleOpacityLevel,
          duration: new Duration(milliseconds: 100), //过渡时间：1
          child: Container(
            width: ScreenUtil.getInstance().screenWidth,
            alignment: Alignment.center,
            child: BubbleWidget(
              ScreenUtil.getInstance().screenWidth * 0.5,
              110.0,
              Colors.white,
              BubbleArrowDirection.bottom,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 5,
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      /// 发送内容
                      GestureDetector(
                        onTap: () {
                          /// 前往内容发布页
                          GlobalRouteTable.goSendContentPage(context);
                          setState(() {
                            _bubbleOpacityLevel = 0.0;
                            _bubbleIsShow = false;
                          });
                        },
                        child: Container(
                            child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(5),
                              //边框设置
                              decoration: new BoxDecoration(
                                //背景
                                color: Color(0xff4997ff),
                                //设置四周圆角 角度
                                borderRadius:
                                    BorderRadius.all(Radius.circular(558.0)),
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesome.send_o,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Text(
                                "发送内容",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),

                      /// 分隔线
                      Container(
                        width: 30,
                      ),

                      /// 发送商品
                      GestureDetector(
                        onTap: () {
                          /// 前往商品发布页
                          GlobalRouteTable.goCommodityAddPage(context);
                          setState(() {
                            _bubbleOpacityLevel = 0.0;
                            _bubbleIsShow = false;
                          });
                        },
                        child: Container(
                            child: Column(
                          children: [
                            Container(
                              width: 50,
                              height: 50,
                              padding: EdgeInsets.all(5),
                              //边框设置
                              decoration: new BoxDecoration(
                                //背景
                                color: Color(0xffffdd38),
                                //设置四周圆角 角度
                                borderRadius:
                                    BorderRadius.all(Radius.circular(558.0)),
                              ),
                              child: Center(
                                child: Icon(
                                  FontAwesome.shopping_bag,
                                  size: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 6),
                              child: Text(
                                "发布商品",
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  void _pageChanged(int index) {
    setState(() {
      if (_tabIndex != index) _tabIndex = index;
    });
  }
}
