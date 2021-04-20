/// -----------------------
/// des: 搜索榜单详情页
/// -----------------------
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';
import 'package:xhd_app/view/widget/page/HotSearchPageContentArea.dart';

class SearchLevelListPage extends StatefulWidget {
  SearchLevelListPage({Key key}) : super(key: key);

  @override
  _SearchLevelListPageState createState() => _SearchLevelListPageState();
}

class _SearchLevelListPageState extends State<SearchLevelListPage>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
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

  ScrollController _scrollViewController;

  /// 拓展区域高度
  double _expandedHeight;

  /// 拓展区域高度TabBar吸顶圆角高度
  double _expandedTabBarHeight;

  @override
  void initState() {
    super.initState();

    /// ----------------- 顶部拓展区高度初始化 start -----------------
    /// 拓展区域高度
    _expandedHeight = ScreenUtil.getInstance().screenHeight * 0.3;

    /// 拓展区域高度TabBar吸顶圆角高度
    _expandedTabBarHeight = 60;

    /// ----------------- 顶部拓展区高度初始化 end -----------------

    _scrollViewController = ScrollController(initialScrollOffset: 0.0);

    ///滚动事件初始化
    _scrollViewController.addListener(() {
      /// 滚动长度监听
      if (_scrollViewController.offset >= _expandedHeight - 50) {
        titleUserHeadPicState.currentState.setOpacity(1.0);
        titleAttentionButtonState.currentState.setOpacity(1.0);
        titleBackButtonState.currentState
            .setBtnColor(Color(GlobalColor.APP_THEME_COLOR));
        titleDrawerButtonState.currentState
            .setBtnColor(Color(GlobalColor.APP_THEME_COLOR));
      } else if (_scrollViewController.offset <= _expandedHeight - 50) {
        titleUserHeadPicState.currentState.setOpacity(0.0);
        titleAttentionButtonState.currentState.setOpacity(0.0);
        titleBackButtonState.currentState.setBtnColor(Colors.white);
        titleDrawerButtonState.currentState.setBtnColor(Colors.white);
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollViewController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(primaryColor: Colors.white),
        child: Scaffold(
          key: scaffoldKey,
          body: NestedScrollView(
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
                  //只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
                  title: TitleUserHeadPic(titleUserHeadPicState),

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
                                'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.deyi.com%2Fforum%2F201909%2F29%2F153820496306d3ee2bea71.jpg&refer=http%3A%2F%2Fimg.deyi.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614329504&t=92a00e3671754a715526de5b1b0b430d',
                          ),

                          /// 用户信息区域
                          Container(
                            /// 头部整个背景颜色
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                /// 吸顶框圆角配置,思路:圆角背景覆盖最底层tabbar
                                _buildTabBarBg()
                              ],
                            ),
                          ),
                        ],
                      )),
                  bottom: PreferredSize(
                    child: Container(
                      height: _expandedTabBarHeight,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("每日10点更新"),
                          Text("榜单规则"),
                        ],
                      ),
                    ),
                  ),
                )
              ];
            },
            body: HotSearchPageContentArea(
              "1",
              "1",
            ),
          ),
        ));
  }

  /// 吸顶框圆角配置
  Widget _buildTabBarBg() {
    return Container(
      //TabBar圆角背景颜色
      height: _expandedTabBarHeight,
      child: ClipRRect(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(15), topRight: Radius.circular(15)),
          child: Container(color: Colors.white)),
    );
  }
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
          child: Container(
            child:

                /// 用户头像
                ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(518),
                topRight: Radius.circular(518),
                bottomLeft: Radius.circular(518),
                bottomRight: Radius.circular(518),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg',
                fit: BoxFit.fill,
                width: 35,
                height: 35,
                // color: Colors.black
              ),
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
        width: 80,
        padding: EdgeInsets.only(top: 10, bottom: 10, right: 10),
        child: CommWidgetBuilder.gradientButton("关注", fontSize: 14),
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
