import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/material/tabs.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 商城首页主要部分
/// -------------------------------

class ShopIndexHomePage extends StatefulWidget {
  /// 分类列表
  List<Widget> commodityClassifyList = [];

  /// 分类页数组
  List<Widget> commodityClassifyPageList = [];

  /// 页面标题
  String title;

  ShopIndexHomePage(this.commodityClassifyList,this.commodityClassifyPageList,{Key key, this.title}) : super(key: key);

  @override
  _ShopIndexHomePageState createState() => _ShopIndexHomePageState();
}

class _ShopIndexHomePageState extends State<ShopIndexHomePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  bool get wantKeepAlive => true;

  /// 拓展区域高度
  double _expandedHeight;

  /// ----------- 轮播图数据 -----------
  List carouselImageUrls = [
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
  ];

  /// ---------------------------------

  /// ----------------- 构建导航区域 start -----------------
  /// 导航按钮数组
  List<Widget> navBtnList;

  Widget buildNavArea() {
    /// 导航区域
    Widget nav = Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: GridView.builder(
          //解决无限高度问题
          shrinkWrap: true,
          //禁用滑动事件
          physics: NeverScrollableScrollPhysics(),
          itemCount: navBtnList.length,
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 5,
            //纵轴间距
            mainAxisSpacing: 1.0,
            //横轴间距
            crossAxisSpacing: 1.0,
          ),
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            return navBtnList[index];
          }),
    );
    return nav;
  }

  /// ----------------- 构建导航区域 end -----------------

  void initState() {
    /// ----------------- 构建导航区域初始化 start -----------------
    navBtnList = [
      /// 新品
      GestureDetector(
        onTap: () {
          GlobalRouteTable.goNewCommodityPage(context);
        },
        child: Column(
          children: [
            Image.asset(
              GlobalFilePath.TITLE_LOGO_43,
              width: 45,
              height: 45,
            ),
            SizedBox(
              height: 5,
            ),
            Text("新款速报"),
          ],
        ),
      ),

      /// 今日爆款
      GestureDetector(
        onTap: () {
          GlobalRouteTable.goHotCommodityPage(context);
        },
        child: Column(
          children: [
            Image.asset(
              GlobalFilePath.TITLE_LOGO_44,
              width: 50,
              height: 50,
            ),
            SizedBox(
              height: 0,
            ),
            Text("今日爆款"),
          ],
        ),
      ),

      /// 好物分享
      GestureDetector(
        onTap: () {
          GlobalRouteTable.goCommoditySharePage(context);
        },
        child: Column(
          children: [
            Image.asset(
              GlobalFilePath.TITLE_LOGO_48,
              width: 48,
              height: 48,
            ),
            SizedBox(
              height: 2,
            ),
            Text("好物分享"),
          ],
        ),
      ),

      /// 买家日常
      GestureDetector(
        onTap: () {
          GlobalRouteTable.goBuyUserEveryDayPage(context);
        },
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: 3),
              child: Image.asset(
                GlobalFilePath.TITLE_LOGO_49,
                width: 40,
                height: 40,
              ),
            ),
            SizedBox(
              height: 7,
            ),
            Text("买家日常"),
          ],
        ),
      ),

      /// 优秀卖家
      GestureDetector(
        onTap: () {
          GlobalRouteTable.goExcellentSellerPage(context);
        },
        child: Column(
          children: [
            Image.asset(
              GlobalFilePath.TITLE_LOGO_50,
              width: 45,
              height: 45,
            ),
            SizedBox(
              height: 5,
            ),
            Text("优秀卖家"),
          ],
        ),
      ),
    ];

    /// ----------------- 构建导航区域初始化 end -----------------

    /// ----------------- 顶部拓展区高度初始化 start -----------------
    /// 拓展区域高度
    _expandedHeight = 128;

    /// ----------------- 顶部拓展区高度初始化 end -----------------

    _scrollViewController = ScrollController(initialScrollOffset: 0.0);

    /// ----------------- 分类tab页初始化 start -----------------
    _tabController = TabController(
        initialIndex: 0, vsync: this, length: widget.commodityClassifyList.length);
//      ShopIndexHomePage_Child(
//          GlobalConst.NET_API_CALL.getContentByType, {"contentClassify": "1"}),
//    GlobalConst.NET_API_CALL.getBigClassifyList().then((value) {
//      if (value['code'] == 0) {
//        List bigClassifyList = value['data'];
//        setState(() {
//          for (Map m in bigClassifyList) {
//            _commodityClassifyList.add(Text(m['name'].toString()));
//            _commodityClassifyPageList.add(
//              ShopIndexHomePage_Child(
//                  GlobalConst.NET_API_CALL.getCommodityListByBigClassifyId,
//                  {"bigClassifyId": m['id'].toString()}),
//            );
//          }
//          _tabController = TabController(
//              initialIndex: 0,
//              vsync: this,
//              length: _commodityClassifyList.length);
//        });
//      } else if (value['code'] == 1) {
//        GlobalToast.showToast("加载错误");
//      }
//    });

    /// ----------------- 分类tab页初始化 end -----------------
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: NestedScrollView(
          controller: _scrollViewController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
                floating: true,
                //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
                pinned: true,
                snap: false,
                leading: Container(),
                expandedHeight: _expandedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,

                  /// 头部区域
                  background: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        /// 导航区域
                        buildNavArea(),
                      ],
                    ),
                  ),
                ),
                bottom: TabBar(
                    unselectedLabelColor: Colors.grey,
                    //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
                    unselectedLabelStyle: TextStyle(fontSize: 16),
                    //设置未选中时的字体样式，tabs里面的字体样式优先级最高
                    labelColor: Color(GlobalColor.APP_THEME_COLOR),
                    //设置选中时的字体颜色，tabs里面的字体样式优先级最高
                    labelStyle: TextStyle(fontSize: 22),
                    //设置选中时的字体样式，tabs里面的字体样式优先级最高
                    isScrollable: true,
                    //允许左右滚动
                    indicatorColor: Color(GlobalColor.APP_THEME_COLOR),
                    //选中下划线的颜色
                    indicatorSize: TabBarIndicatorSize.label,
                    //选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
                    indicatorWeight: 3.0,
                    //选中下划线的高度，值越大高度越高，默认为2。0
                    indicator: BoxDecoration(),
                    //用于设定选中状态下的展示样式
                    controller: _tabController,
                    tabs: widget.commodityClassifyList),
              ),
            ];
          },
          body: Container(
            padding: EdgeInsets.only(
              top: 6,
            ),
            child: TabBarView(
                controller: _tabController,
                children: widget.commodityClassifyPageList),
          ),
        ),
      ),
    );
  }
}
