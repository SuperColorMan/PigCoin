import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/model/user/UserInfoModel.dart';
import 'package:xhd_app/view/anim/PageRouteAnimation.dart';
import 'package:xhd_app/view/comm/enums/GlobalUserContentTypeEnum.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';
import 'package:xhd_app/view/page/search/SearchHomePage.dart';
import 'package:xhd_app/view/page/user/EditUserInfoPage.dart';
import 'package:xhd_app/view/widget/page/UserPageContentArea.dart';

class MyHomePage extends StatefulWidget {
  int defaultPageIndex;

  MyHomePage(this.defaultPageIndex, {Key key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState(defaultPageIndex);
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin {
  /// ----------- 默认页号 -----------
  int _defaultPageIndex = 0;

  /// ---------------------------------
  _MyHomePageState(int defaultPageIndex) {
    this._defaultPageIndex = defaultPageIndex;
  }

  /// ----------- 用户数据模型 -----------
  UserInfoModel _userInfoModel;

  /// ---------------------------------

  /// ------------------ TarBar 相关配置参数 ------------------
  /// tab标题列表
  var tabTitle = [
    '全部',
    '内容',
    '点赞',
    '评论',
    '收藏',
  ];

  /// tab索引
  List<String> tabClassify = [
    "${GlobalUserContentTypeEnum.ALL.index}",
    "${GlobalUserContentTypeEnum.CONTENT.index}",
    "${GlobalUserContentTypeEnum.GOOD.index}",
    "${GlobalUserContentTypeEnum.COMMENT.index}",
    "${GlobalUserContentTypeEnum.COLLECT.index}",
  ];

  /// ------------------------------------------------------

  /// ------------------------ 内容请求相关参数 ------------------------
  String _userContentClassify = "1";

  /// 登录用户id
  String _loginUserId = "1";

  /// ------------------------------------------------------------------------

  GlobalNetApiCall _globalNetApiCall = GlobalNetApiCall();

  TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _tabController = TabController(
        initialIndex: _defaultPageIndex, vsync: this, length: tabTitle.length);

    /// ------------- 用户数据初始化 -------------
    _userInfoModel = new UserInfoModel(context);

    ///-----------------------------------------
  }

  /// 构建用户信息区域
  /// 用户区域高度
  double _userInfoAreaHeight = 150;

  Widget _builderUserInfo() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      color: Color(0xfffffffff),
      child: Stack(
        children: [
//        /// 用户壁纸
//        Container(
//          color: Colors.red,
//          height: _userInfoAreaHeight,
//          width: double.infinity,
//          child: CachedNetworkImage(
//              "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F58a1558bec460.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613018611&t=0b5e1d070af59586e5884bc4282edbf8",
//              fit:BoxFit.fill),),
//        /// 壁纸蒙层
//        Container(child: Center(
//          child:BackdropFilter(   //背景滤镜器
//            filter: ImageFilter.blur(sigmaX: 1.0,sigmaY: 1.0), //图片模糊过滤，横向竖向都设置5.0
//            child: Opacity( //透明控件
//              opacity: 0.5,
//              child: Container(// 容器组件
//                width: 500.0,
//                height: 500.0,
//                decoration: BoxDecoration(color:Colors.black), //盒子装饰器，进行装饰，设置颜色为灰色
//              ),
//            ),
//          ),
//        )),
          Container(
            child: Column(
              children: [
                ///用户信息
                Container(
                  color: Colors.transparent,
                  padding:
                      EdgeInsets.only(left: 0, top: 10, right: 0, bottom: 0),
                  child: Row(
                    children: [
                      /// 用户头像
                      Container(
                        margin: EdgeInsets.only(left: 15),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: _userInfoModel.userHeadImg,
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
                          margin: EdgeInsets.only(left: 1),
                          child: Column(
                            children: [
                              //用户互动信息
                              Container(
                                  padding: EdgeInsets.only(left: 25, right: 25),
                                  child: Row(
                                    children: [
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(_userInfoModel.goodCount),
                                          Text("获赞"),
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(_userInfoModel.attentionConut),
                                          Text("关注"),
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(_userInfoModel.fansCount),
                                          Text("粉丝"),
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text(_userInfoModel.collectCount),
                                          Text("收藏"),
                                        ],
                                      )),
                                    ],
                                  )),
                              //编辑按钮
                              Container(
                                margin: EdgeInsets.only(
                                    top: 5, left: 20, right: 20),
                                alignment: Alignment.centerLeft,
                                height: 35,
                                child: CommWidgetBuilder.gradientButton("编辑资料",
                                    callBack: () {
                                  //跳转到个人页
                                  Navigator.push(context,
                                      CustomRouteJianBian(EditUserInfoPage()));
                                }),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 用户简介
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 15),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text(_userInfoModel.intro,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(color: Colors.black87)),
                  ),
                ),
                //分割线
                Container(
                  color: Color(0xfff9fafb),
//                  color: Colors.red,
                  height: 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: tabTitle.length,
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
                heroTag: "4",
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
          appBar: PreferredSize(
              child: AppBar(
                title: Text(
                  _userInfoModel.userName,
                  style: TextStyle(color: Colors.black87),
                ),
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                brightness: Brightness.dark,
                actions: [
                  GestureDetector(
                    onTap: () {
                      //跳转到用户搜索页
                      Navigator.push(
                          context, CustomRouteJianBian(SearchHomePage()));
                    },
                    child: Container(
                      child: IconButton(
                        icon: Icon(
                          Icons.search,
                          color: Colors.black87,
                        ),
                        iconSize: 30,
                      ),
                      margin: EdgeInsets.only(right: 10),
                    ),
                  ),
                ],
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
          body: new NestedScrollView(
            headerSliverBuilder: (context, bool) {
              return [
                SliverAppBar(
                  expandedHeight: _userInfoAreaHeight,
                  floating: false,
                  pinned: false,
                  automaticallyImplyLeading: false,
                  backgroundColor: Colors.white,
                  flexibleSpace:
                      FlexibleSpaceBar(background: _builderUserInfo()),
                ),
                SliverPersistentHeader(
                  delegate: new SliverTabBarDelegate(
                    new TabBar(
                      controller: _tabController,
                      tabs: tabTitle.map((f) => Tab(text: f)).toList(),
                      indicatorSize: TabBarIndicatorSize.label,
                      indicatorColor: Color(GlobalColor.APP_THEME_COLOR),
                      unselectedLabelColor: Colors.black,
                      labelColor: Color(GlobalColor.APP_THEME_COLOR),
                    ),
                    color: Colors.white,
                  ),
                  pinned: true,
                ),
              ];
            },
            body: TabBarView(
              controller: _tabController,
              children: tabClassify
                  .map((classify) => UserPageContentArea("1", classify))
                  .toList(),
            ),
          ),
        ));
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}
