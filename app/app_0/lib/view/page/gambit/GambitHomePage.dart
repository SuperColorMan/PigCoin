import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/enums/GlobalGambitHomePageTypeEnum.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';
import 'package:xhd_app/view/widget/page/GambitHomePageArea.dart';
import 'package:xhd_app/view/widget/user/UserHeadPicStack.dart';

/// -------------------------------
/// Des: 话题主页
/// -------------------------------
class GambitHomePage extends StatefulWidget {
  /// 话题信息
  Map gambitInfo;

  GambitHomePage(this.gambitInfo, {Key key}) : super(key: key);

  @override
  _GambitHomePageState createState() => _GambitHomePageState(gambitInfo);
}

class _GambitHomePageState extends State<GambitHomePage>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  /// 话题信息
  Map gambitInfo;

  _GambitHomePageState(this.gambitInfo);

  /// ----------- 默认页号 -----------
  int _defaultPageIndex = 0;

  /// ---------------------------------

  /// ------------------ 局部组件初始化 start ------------------
  /// 头部用户头像
  GlobalKey<TitleUserHeadPicState> titleUserHeadPicState = GlobalKey();

  /// 头部关注按钮
  GlobalKey<TitleAttentionButtonState> titleAttentionButtonState = GlobalKey();

  /// 头部返回按钮
  GlobalKey<TitleBackButtonState> titleBackButtonState = GlobalKey();

  /// 头部抽屉按钮
  GlobalKey<TitleDrawerButtonState> titleDrawerButtonState = GlobalKey();

  /// 页面key
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  /// ------------------ 局部组件初始化 end ------------------

  /// ------------------ TarBar 相关配置参数 ------------------
  /// tab标题列表
  var tabTitle = [
    Tab(
      child: Text(
        "最新",
        style: TextStyle(fontSize: 16),
      ),
    ),
    Tab(
      child: Text(
        "最热",
        style: TextStyle(fontSize: 16),
      ),
    ),
    Tab(
      child: Text(
        "神评专区",
        style: TextStyle(fontSize: 16),
      ),
    ),
  ];

  /// tab索引
  List<String> tabClassify = [
    "${GlobalGambitHomePageTypeEnum.NEW.index}",
    "${GlobalGambitHomePageTypeEnum.HOT.index}",
    "${GlobalGambitHomePageTypeEnum.HOTCOMMENT.index}",
  ];

  /// ------------------------------------------------------

  ScrollController _scrollViewController;
  TabController _tabController;

  /// 拓展区域高度
  double _expandedHeight;

  /// 拓展区域高度TabBar吸顶圆角高度
  double _expandedTabBarHeight;

  /// ----------------- 话题信息start -----------------
  /// 话题id
  String _gambitId = "";

  /// 话题名称
  String _gambitName = "";

  /// ----------------- 话题信息 end -----------------
  ///
  @override
  void initState() {
    super.initState();

    /// ----------------- 话题信息初始化 start -----------------
    _gambitId = gambitInfo['id'].toString();
    _gambitName = gambitInfo['name'].toString();

    /// ----------------- 话题信息初始化 end -----------------

    /// ----------------- 顶部拓展区高度初始化 start -----------------
    /// 拓展区域高度
    _expandedHeight = ScreenUtil.getInstance().screenHeight * 0.5;

    /// 拓展区域高度TabBar吸顶圆角高度
    _expandedTabBarHeight = 208;

    /// ----------------- 顶部拓展区高度初始化 end -----------------

    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(
        initialIndex: _defaultPageIndex, vsync: this, length: tabTitle.length);

    ///滚动事件初始化
    _scrollViewController.addListener(() {
      /// 滚动长度监听
      if (_scrollViewController.offset >= _expandedHeight - 60) {
        titleUserHeadPicState.currentState.setOpacity(1.0);
        titleAttentionButtonState.currentState.setOpacity(1.0);
        titleBackButtonState.currentState
            .setBtnColor(Color(GlobalColor.APP_THEME_COLOR));
        titleDrawerButtonState.currentState
            .setBtnColor(Color(GlobalColor.APP_THEME_COLOR));
      } else if (_scrollViewController.offset <= _expandedHeight - 60) {
        titleUserHeadPicState.currentState.setOpacity(0.0);
        titleAttentionButtonState.currentState.setOpacity(0.0);
        titleBackButtonState.currentState.setBtnColor(Colors.white);
        titleDrawerButtonState.currentState.setBtnColor(Colors.white);
      }
    });
  }

  /// -------------- 构建右侧抽屉 start --------------
  Widget _builRightdDrawer() {
    return Container(
      width: ScreenUtil.getInstance().screenWidth * 0.7,
      color: Colors.white,
      child: ListView(
        children: <Widget>[
          new ListTile(
            title: new Text("识花"),
            trailing: new Icon(Icons.local_florist),
          ),
          new ListTile(
            title: new Text("搜索"),
            trailing: new Icon(Icons.search),
          ),
          new Divider(),
          new ListTile(
            title: new Text("设置"),
            trailing: new Icon(Icons.settings),
          ),
        ],
      ),
    );
  }

  /// -------------- 构建右侧抽屉 end --------------

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(primaryColor: Colors.white),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        floatingActionButton: Container(
            margin: EdgeInsets.only(left: 0, top: 35, right: 0, bottom: 0),
            width: 66,
            height: 66,
            padding: EdgeInsets.all(5),
//          decoration: BoxDecoration(
//              borderRadius: BorderRadius.circular(50), color: Colors.white),
            child: FloatingActionButton(
              heroTag: "1",
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
                GlobalRouteTable.goSendContentPage(context);
              },
            )),
        key: scaffoldKey,
        endDrawer: _builRightdDrawer(),
        body: Listener(
          onPointerMove: (result) {
            //手指的移动时
//              updatePicHeight(result.position.dy); //自定义方法，图片的放大由它完成。
          },
          onPointerUp: (_) {
            //当手指抬起离开屏幕时
//              runAnimate(); //动画执行
//              animationController.forward(from: 0); //重置动画
          },
          child: NestedScrollView(
              controller: _scrollViewController,
              headerSliverBuilder:
                  (BuildContext context, bool innerBoxIsScrolled) {
                return <Widget>[
                  SliverAppBar(
                    floating: false,
                    //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
                    pinned: true,
                    //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
                    snap: false,
                    title: Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 标题
                          TitleUserHeadPic(titleUserHeadPicState),

                          /// 关注按钮
                          TitleAttentionButton(titleAttentionButtonState),
                        ],
                      ),
                    ),

                    /// 返回按钮
                    leading: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        padding: EdgeInsets.only(left: 20),
                        alignment: Alignment.centerLeft,
                        child: TitleBackButton(titleBackButtonState),
                      ),
                    ),

                    /// 关注按钮
                    actions: [
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Row(
                          children: [
                            /// 抽屉按钮
                            GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                scaffoldKey.currentState.openEndDrawer();
                              },
                              child: TitleDrawerButton(titleDrawerButtonState),
                            ),
                          ],
                        ),
                      ),
                    ],
                    expandedHeight: _expandedHeight,
                    flexibleSpace: FlexibleSpaceBar(
                        centerTitle: true,
                        collapseMode: CollapseMode.pin,
                        background: Stack(
                          children: [
                            /// 用户背景壁纸
                            CachedNetworkImage(
                              height: _expandedHeight,
                              width: double.infinity,
                              fit: BoxFit.fill,
                              imageUrl:
                                  'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fphotocdn.sohu.com%2F20151229%2Fmp51247958_1451396005252_2.jpeg&refer=http%3A%2F%2Fphotocdn.sohu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614412793&t=2a456c17a26df6cc440e8b7540ca2a37',
                            ),

                            /// 毛玻璃蒙层
                            ClipRect(
                                child: Center(
                              child: BackdropFilter(
                                //背景滤镜器
                                filter:
                                    ImageFilter.blur(sigmaX: 1.0, sigmaY: 2.0),
                                //图片模糊过滤，横向竖向都设置5.0
                                child: Opacity(
                                  //透明控件
                                  opacity: 0.5,
                                  child: Container(
                                    // 容器组件
                                    width: 500.0,
                                    height: 500.0,
                                    decoration: BoxDecoration(
                                        color:
                                            Colors.black), //盒子装饰器，进行装饰，设置颜色为灰色
                                  ),
                                ),
                              ),
                            )),

                            /// 用户信息区域
                            Container(
                              /// 头部整个背景颜色
                              height: double.infinity,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  /// 用户信息区域
                                  _buildInfoArea(),

                                  /// 吸顶框圆角配置,思路:圆角背景覆盖最底层tabbar
                                  _buildTabBarBg()
                                ],
                              ),
                            ),
                          ],
                        )),
                    bottom: PreferredSize(
                      preferredSize: Size(double.infinity, 50),
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.centerLeft,
                        child: TabBar(
                            isScrollable: true,
                            indicatorSize: TabBarIndicatorSize.label,
                            indicatorColor: Color(GlobalColor.APP_THEME_COLOR),
                            unselectedLabelColor: Colors.black,
                            labelColor: Color(GlobalColor.APP_THEME_COLOR),
                            controller: _tabController,
                            tabs: tabTitle),
                      ),
                    ),
                  )
                ];
              },
              body: TabBarView(
                controller: _tabController,
                children: tabClassify
                    .map((classify) => GambitHomePageArea(
                          _gambitId,
                          classify,
                        ))
                    .toList(),
              )),
        ),
      ),
    );
  }

  /// 构建信息区域
  Widget _buildInfoArea() {
    return Container(
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            ///用户信息
            Container(
              color: Colors.transparent,
              padding: EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
              child: Row(
                children: [
                  /// 用户头像
                  Container(
                    width: 68,
                    height: 68,
                    decoration: new BoxDecoration(
                      //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                      borderRadius: BorderRadius.all(Radius.circular(8.0)),
                      //设置四周边框
                      border: new Border.all(width: 2, color: Colors.white),
                    ),
                    margin: EdgeInsets.only(left: 15),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fphotocdn.sohu.com%2F20151229%2Fmp51247958_1451396005252_2.jpeg&refer=http%3A%2F%2Fphotocdn.sohu.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614412793&t=2a456c17a26df6cc440e8b7540ca2a37',
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                        // color: Colors.black
                      ),
                    ),
                  ),

                  /// 用户信息区域
                  Expanded(
                    flex: 4,
                    child: Container(
                      margin: EdgeInsets.only(left: 15),
                      child: Column(
                        children: [
                          /// 话题名称
                          Container(
                              child: Row(
                            children: [
                              Container(
                                constraints: BoxConstraints(
                                  maxWidth:
                                      ScreenUtil.getInstance().screenWidth *
                                          0.6,
                                ),
                                child: Text(
                                  '${_gambitName}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500),
                                  textAlign: TextAlign.left,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                ),
                              ),
                            ],
                          )),
                        ],
                      ),
                    ),
                  ),

                  /// 加入按钮
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.only(right: 9),
                      height: 35,
                      child:
                          CommWidgetBuilder.gradientButton("加入", fontSize: 14),
                    ),
                  ),
                ],
              ),
            ),

            ///用户简介
            Container(
              margin: EdgeInsets.only(top: 15, bottom: 15),
              child: FractionallySizedBox(
                widthFactor: 0.9,
                child: Text("这是话题简介",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 吸顶框圆角配置
  Widget _buildTabBarBg() {
    return Container(
      //TabBar圆角背景颜色
      height: _expandedTabBarHeight,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(
            color: Colors.white,
            child: _buildGambitExtendInfo(context),
          )),
    );
  }
}

/// 话题公告列表
List _gambitInformList = [
  Card(
    elevation: 2.0, //阴影
    color: Colors.white, //背景色
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(10.0)),
    ),
    child: new Container(
      width: double.infinity,
      child: Row(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10),
            //设置 child 居中
            alignment: Alignment(0, 0),
            height: 30,
            width: 50,
            //边框设置
            decoration: new BoxDecoration(
              //背景
              color: Color(GlobalColor.APP_THEME_COLOR),
              //设置四周圆角 角度
              borderRadius: BorderRadius.all(Radius.circular(4.0)),
              //设置四周边框
              border: new Border.all(
                  width: 1, color: Color(GlobalColor.APP_THEME_COLOR)),
            ),
            child: Text(
              "通知",
              style: TextStyle(color: Colors.white),
            ),
          ),
          Expanded(
              child: Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Text(
              '这是一个话题这是一个话题这是一个话题这是一个话题这是一个话题这是一个话题这是一个话题',
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
              ),
              textAlign: TextAlign.left,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          )),
        ],
      ),
    ),
  ),
];

/// 构建话题拓展信息 start
Widget _buildGambitExtendInfo(BuildContext context) {
  return Container(
    padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
    width: double.infinity,
    child: Column(
      children: [
        /// 最佳贡献用户标题
        Container(
          alignment: Alignment.centerLeft,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                GlobalFilePath.TITLE_LOGO_8,
                width: 30,
                height: 30,
                fit: BoxFit.fill,
              ),
              Container(
                margin: EdgeInsets.only(left: 10),
                child: Text("话题最佳贡献者"),
              ),
            ],
          ),
        ),

        /// 最佳贡献用户列表
        Container(
          alignment: Alignment.center,
          margin: EdgeInsets.only(top: 8),
          width: double.infinity,
          height: 35,
          child: UserHeadPicStack(
            childImgList: [
              'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F16%2F07%2F07%2F15577e085313911.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614414926&t=3ed397a21d05c3160f439c34caf7cb98',
              'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fbpic.588ku.com%2Felement_origin_min_pic%2F16%2F07%2F07%2F15577e085313911.jpg&refer=http%3A%2F%2Fbpic.588ku.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614414926&t=3ed397a21d05c3160f439c34caf7cb98',
            ],
          ),
        ),

        /// 话题公告,多个话题轮播狂
        Container(
          margin: EdgeInsets.only(top: 8),
          height: 60,
          child: Container(
            child: ClipRRect(
              child: Swiper(
                itemCount: _gambitInformList.length,
                autoplay: true,
                itemBuilder: (BuildContext context, int index) {
                  return _gambitInformList[index];
                },
                pagination: null,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

/// ---------------------- 页面局部组件定义区域 start ----------------------
/// ---------- 页面标题区域用户头像 start ----------
class TitleUserHeadPic extends StatefulWidget {
  TitleUserHeadPic(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TitleUserHeadPicState();
  }
}

class TitleUserHeadPicState extends State<TitleUserHeadPic> {
  TitleUserHeadPicState();

  /// 头部用户信息隐藏度
  double opacityLevel = 0.0;

  /// 头部用户信息隐藏速率,单位:ms
  int opacityMS = 200;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
        // 使用一个AnimatedOpacity Widget
        opacity: opacityLevel,
        duration: new Duration(milliseconds: opacityMS),

        /// 过渡时间：500毫秒
        child: new Container(
          height: 50,
          child: Container(
            alignment: Alignment.centerLeft,
            child: Text(
              "这是一个话题",
              style: TextStyle(
                  fontSize: 18, color: Color(GlobalColor.APP_THEME_COLOR)),
            ),
          ),
        ));
  }

  void setOpacity(double opacity) {
    setState(() {
      opacityLevel = opacity;
    });
  }
}

/// ---------- 页面标题区域用户头像 end ----------

/// ---------- 页面标题区域关注按钮 start ----------
class TitleAttentionButton extends StatefulWidget {
  TitleAttentionButton(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TitleAttentionButtonState();
  }
}

class TitleAttentionButtonState extends State<TitleAttentionButton> {
  /// 头部用户信息隐藏度
  double opacityLevel = 0.0;

  /// 头部用户信息隐藏速率,单位:ms
  int opacityMS = 200;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      // 使用一个AnimatedOpacity Widget
      opacity: opacityLevel,
      duration: new Duration(milliseconds: opacityMS),
      //过渡时间：500毫秒
      child: Container(
        alignment: Alignment.centerRight,
        width: 80,
        height: 55,
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
        child: CommWidgetBuilder.gradientButton("加入", fontSize: 14),
      ),
    );
  }

  void setOpacity(double opacity) {
    setState(() {
      opacityLevel = opacity;
    });
  }
}

/// ---------- 页面标题区域关注 end ----------

/// ---------- 页面标题区域返回按钮 start ----------
class TitleBackButton extends StatefulWidget {
  TitleBackButton(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TitleBackButtonState();
  }
}

class TitleBackButtonState extends State<TitleBackButton> {
  /// 颜色值
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.arrow_back_ios,
      color: color,
      size: 30,
    );
  }

  void setBtnColor(Color c) {
    setState(() {
      color = c;
    });
  }
}

/// ---------- 页面标题区域返回按钮 end ----------

/// ---------- 页面标题区域抽屉按钮 start ----------
class TitleDrawerButton extends StatefulWidget {
  TitleDrawerButton(Key key) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return TitleDrawerButtonState();
  }
}

class TitleDrawerButtonState extends State<TitleDrawerButton> {
  /// 颜色值
  Color color = Colors.white;

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.list,
      color: color,
      size: 35,
    );
  }

  void openDrawer(Function callBack) {
    setState(() {
      callBack();
    });
  }

  void setBtnColor(Color c) {
    setState(() {
      color = c;
    });
  }
}

/// ---------- 页面标题区域抽屉按钮 end ----------

/// ---------------------- 页面局部组件定义区域 end ----------------------
