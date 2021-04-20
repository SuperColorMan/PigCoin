import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:xhd_app/view/anim/PageRouteAnimation.dart';
import 'package:xhd_app/view/comm/enums/GlobalUserContentTypeEnum.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';
import 'package:xhd_app/view/widget/page/UserPageContentArea.dart';
import 'package:xhd_app/view/widget/user/UserSexLabel.dart';

import 'EditUserInfoPage.dart';

/// -------------------------------
/// Des: 用户主页
/// -------------------------------
class UserHomePage_2 extends StatefulWidget {
  /// 默认页索引
  int defaultPageIndex;

  /// 当前页用户名
  String userName;

  /// 当前用户id
  String userId;

  UserHomePage_2(
      {this.defaultPageIndex = 0, this.userName, this.userId, Key key})
      : super(key: key);

  @override
  _UserHomePage_2State createState() => _UserHomePage_2State(defaultPageIndex);
}

class _UserHomePage_2State extends State<UserHomePage_2>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  /// ----------- 默认页号 -----------
  int _defaultPageIndex = 0;

  /// ---------------------------------

  _UserHomePage_2State(int defaultPageIndex) {
    this._defaultPageIndex = defaultPageIndex;
  }

  /// ------------------ 局部组件初始化 start ------------------
  /// 头部用户头像
  GlobalKey<TitleUserHeadPicState> titleUserHeadPicState = GlobalKey();

  /// 头部关注按钮
  GlobalKey<TitleAttentionButtonState> titleAttentionButtonState = GlobalKey();

  /// 头部返回按钮
  GlobalKey<TitleBackButtonState> titleBackButtonState = GlobalKey();

  /// 头部抽屉按钮
  GlobalKey<TitleDrawerButtonState> titleDrawerButtonState = GlobalKey();

  /// ------------------ 局部组件初始化 end ------------------

  /// 局部组件初始化 end
  /// ------------------ TarBar 相关配置参数 ------------------
  /// tab标题列表
  var tabTitle = [
    Tab(text: '全部'),
    Tab(text: '内容'),
    Tab(text: '点赞'),
    Tab(text: '评论'),
    Tab(text: '收藏'),
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

  /// 构建用户信息区域
  /// 用户区域高度
  double _userInfoAreaHeight = 150;

  Widget _builderUserInfo() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      color: Color(0xfffffffff),
      child: Stack(
        children: [
          /// 用户壁纸
          Container(
            color: Colors.red,
            height: 100,
            width: double.infinity,
            child: CachedNetworkImage(
                imageUrl:
                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fpic1.win4000.com%2Fwallpaper%2F3%2F58a1558bec460.jpg&refer=http%3A%2F%2Fpic1.win4000.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613018611&t=0b5e1d070af59586e5884bc4282edbf8",
                fit: BoxFit.fill),
          ),

          /// 壁纸蒙层
          Container(
              child: Center(
            child: BackdropFilter(
              //背景滤镜器
              filter: ImageFilter.blur(sigmaX: 1.0, sigmaY: 1.0),
              //图片模糊过滤，横向竖向都设置5.0
              child: Opacity(
                //透明控件
                opacity: 0.5,
                child: Container(
                  // 容器组件
                  width: double.infinity,
                  height: 220,
                  decoration:
                      BoxDecoration(color: Colors.black), //盒子装饰器，进行装饰，设置颜色为灰色
                ),
              ),
            ),
          )),
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
                            imageUrl:
                                "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.5mcc.com.cn%2F5mcc_com_cn%2Fallimg%2F190214%2F03145V3c-40.jpg&refer=http%3A%2F%2Fimg.5mcc.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613784459&t=b21f432ac9046b6f3781edda3eb344b4",
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
                                          Text("1111"),
                                          Text("获赞"),
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text("1111"),
                                          Text("关注"),
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text("1111"),
                                          Text("粉丝"),
                                        ],
                                      )),
                                      Expanded(
                                          child: Column(
                                        children: [
                                          Text("1111"),
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

                ///用户简介
                Container(
                  margin: EdgeInsets.only(top: 8, bottom: 15),
                  child: FractionallySizedBox(
                    widthFactor: 0.9,
                    child: Text("阿萨德覅偶奇偶静安寺的金佛按实际地方",
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

  ScrollController _scrollViewController;
  TabController _tabController;

  /// ------------------- 缩放控制 start -------------------
  AnimationController animationController;
  Animation<double> anim;
  double extraPicHeight = 0;
  BoxFit fitType;
  double prev_dy;

  updatePicHeight(changed) {
    if (prev_dy == 0) {
      //如果是手指第一次点下时，我们不希望图片大小就直接发生变化，所以进行一个判定。
      prev_dy = changed;
    }
    if (extraPicHeight >= 45) {
      //当我们加载到图片上的高度大于某个值的时候，改变图片的填充方式，让它由以宽度填充变为以高度填充，从而实现了图片视角上的放大。
      fitType = BoxFit.fitHeight;
    } else {
      fitType = BoxFit.fitWidth;
    }
//控制最大放大高度
    if (extraPicHeight < 100) {
      extraPicHeight += changed - prev_dy; //新的一个y值减去前一次的y值然后累加，作为加载到图片上的高度。
      setState(() {
        //更新数据
        prev_dy = changed;
        extraPicHeight = extraPicHeight;
        fitType = fitType;
      });
    }
  }

  runAnimate() {
    //设置动画让extraPicHeight的值从当前的值渐渐回到 0
    setState(() {
      anim = Tween(begin: extraPicHeight, end: 0.0).animate(animationController)
        ..addListener(() {
          if (extraPicHeight >= 45) {
            //同样改变图片填充类型
            fitType = BoxFit.fitHeight;
          } else {
            fitType = BoxFit.fitWidth;
          }
          setState(() {
            extraPicHeight = anim.value;
            fitType = fitType;
          });
        });
      prev_dy = 0; //同样归零
    });
  }

  /// ------------------- 缩放控制 end -------------------

  /// 拓展区域高度
  double _expandedHeight;

  /// 拓展区域高度TabBar吸顶圆角高度
  double _expandedTabBarHeight;

  @override
  void initState() {
    super.initState();

    /// ----------------- 初始化用户信息 start -----------------
    if (widget.userName != null && widget.userName.isNotEmpty) {
      /// 根据用户名查询
    }
    if (widget.userId != null && widget.userId.isNotEmpty) {
      /// 根据用户id查询
    }

    /// ----------------- 初始化用户信息 end -----------------

    /// ----------------- 顶部拓展区高度初始化 start -----------------
    /// 拓展区域高度
    _expandedHeight = ScreenUtil.getInstance().screenHeight * 0.389;

    /// 拓展区域高度TabBar吸顶圆角高度
    _expandedTabBarHeight = 50;

    /// ----------------- 顶部拓展区高度初始化 end -----------------

    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(
        initialIndex: _defaultPageIndex, vsync: this, length: tabTitle.length);

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
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
  }

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
                              /// 关注按钮
                              TitleAttentionButton(titleAttentionButtonState),

                              /// 抽屉按钮
                              GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  SmartDialog.show(
                                    alignmentTemp: Alignment.centerRight,
                                    widget: Container(
                                      width:
                                          ScreenUtil.getInstance().screenWidth *
                                              0.6,
                                      color: Colors.blue,
                                    ),
                                  );
                                },
                                child:
                                    TitleDrawerButton(titleDrawerButtonState),
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
                              /// 用户背景
                              CachedNetworkImage(
                                  height: _expandedHeight,
                                  width: double.infinity,
                                  fit: BoxFit.fill,
                                  imageUrl:
                                      'https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180530%2F6247b0ba7b8046deb212d2dd6ee4ec6e.jpeg&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613789680&t=2d651fe560729b51856b9023dfcbfadb'),

                              /// 毛玻璃蒙层
                              ClipRect(
                                  child: Center(
                                child: BackdropFilter(
                                  //背景滤镜器
                                  filter: ImageFilter.blur(
                                      sigmaX: 1.0, sigmaY: 2.0),
                                  //图片模糊过滤，横向竖向都设置5.0
                                  child: Opacity(
                                    //透明控件
                                    opacity: 0.5,
                                    child: Container(
                                      // 容器组件
                                      width: 500.0,
                                      height: 500.0,
                                      decoration: BoxDecoration(
                                          color: Colors
                                              .black), //盒子装饰器，进行装饰，设置颜色为灰色
                                    ),
                                  ),
                                ),
                              )),

                              /// 用户信息区域
                              Container(
                                //头部整个背景颜色
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
                      bottom: TabBar(
                          indicatorSize: TabBarIndicatorSize.label,
                          indicatorColor: Color(GlobalColor.APP_THEME_COLOR),
                          unselectedLabelColor: Colors.black,
                          labelColor: Color(GlobalColor.APP_THEME_COLOR),
                          controller: _tabController,
                          tabs: tabTitle),
                    )
                  ];
                },
                body: TabBarView(
                  controller: _tabController,
                  children: tabClassify
                      .map((classify) => UserPageContentArea(
                            "1",
                            classify,
                          ))
                      .toList(),
                )),
          ),
        ));
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
                      borderRadius: BorderRadius.all(Radius.circular(558.0)),
                      //设置四周边框
                      border: new Border.all(width: 2, color: Colors.white),
                    ),
                    margin: EdgeInsets.only(left: 15),
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl:
                            "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.5mcc.com.cn%2F5mcc_com_cn%2Fallimg%2F190214%2F03145V3c-40.jpg&refer=http%3A%2F%2Fimg.5mcc.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613784459&t=b21f432ac9046b6f3781edda3eb344b4",
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
                          /// 用户名
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
                                  "我是彩色我是彩色下我是彩色下我是彩色下我是彩色下我是彩色下我是彩色下我是彩色下下",
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

                          /// 用户标签区域
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.only(top: 10, bottom: 5),
                            child: Wrap(
                              alignment: WrapAlignment.start,
                              //布局方向
                              direction: Axis.horizontal,
                              spacing: 10,
                              runSpacing: 10,
                              children: [
                                UserSexLabel(),
                              ],
                            ),
                          ),
                        ],
                      ),
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
                child: Text("阿萨德覅偶奇偶静安寺的金佛按实际地方",
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: Colors.white)),
              ),
            ),

            /// 用户信息区域
            Container(
              child: Container(
                margin: EdgeInsets.only(left: 1),
                padding: EdgeInsets.only(bottom: 18),
                child: Row(
                  children: [
                    /// 用户互动信息
                    Expanded(
                        flex: 4,
                        child: Row(
                          children: [
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "1111",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "获赞",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "1111",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "关注",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "1111",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "粉丝",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                            Expanded(
                                child: Column(
                              children: [
                                Text(
                                  "1111",
                                  style: TextStyle(color: Colors.white),
                                ),
                                Text(
                                  "收藏",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            )),
                          ],
                        )),

                    /// 编辑按钮
                    Expanded(
                        flex: 4,
                        child: Stack(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                /// 用户个人资料编辑
                                GestureDetector(
                                  onTap: () {
                                    /// 跳转到个人页
                                    Navigator.push(
                                        context,
                                        CustomRouteJianBian(
                                            EditUserInfoPage()));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 10),
                                    alignment: Alignment.centerRight,
                                    height: 35,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(100),
                                        topRight: Radius.circular(100),
                                        bottomLeft: Radius.circular(100),
                                        bottomRight: Radius.circular(100),
                                      ),
                                      child: Container(
                                        child: Stack(
                                          children: [
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.only(
                                                      left: 10,
                                                      right: 10,
                                                      top: 3,
                                                      bottom: 3),
                                                  //边框设置
                                                  decoration: new BoxDecoration(
                                                    color: Color(0x806F6F6F),
                                                    //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                25.0)),
                                                    //设置四周边框
                                                    border: new Border.all(
                                                        width: 1,
                                                        color: Colors.white),
                                                  ),
                                                  child: Text("编辑个人资料",
                                                      style: TextStyle(
                                                        fontSize: 12,
                                                        color: Colors.white,
                                                      ),
                                                      textAlign: TextAlign.left,
                                                      softWrap: true,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      maxLines: 1),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        )),
                  ],
                ),
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
        //过渡时间：500毫秒
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
              child: Image.network(
                'https://gimg2.baidu.com/image_search/src=http%3A%2F%2F5b0988e595225.cdn.sohucs.com%2Fimages%2F20180530%2F6247b0ba7b8046deb212d2dd6ee4ec6e.jpeg&refer=http%3A%2F%2F5b0988e595225.cdn.sohucs.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1613789680&t=2d651fe560729b51856b9023dfcbfadb',
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
