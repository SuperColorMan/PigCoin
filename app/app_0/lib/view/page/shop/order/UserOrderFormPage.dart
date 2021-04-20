/// -------------------------------
/// Des: 用户订单页
/// -------------------------------

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/material/tabs.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalContentList.dart';
import 'package:xhd_app/view/widget/comm/GlobalOrderFormList.dart';

/// -------------------------------
/// Des: 用户订单页
/// -------------------------------

class UserOrderFormPage extends StatefulWidget {
  UserOrderFormPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _UserOrderFormPageState createState() => _UserOrderFormPageState();
}

class _UserOrderFormPageState extends State<UserOrderFormPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;
  ScrollController _scrollViewController;

  @override
  bool get wantKeepAlive => true;

  /// 拓展区域高度
  double _expandedHeight;

  void initState() {
    /// ----------------- 顶部拓展区高度初始化 start -----------------
    /// 拓展区域高度
    _expandedHeight = 200;

    /// ----------------- 顶部拓展区高度初始化 end -----------------

    _scrollViewController = ScrollController(initialScrollOffset: 0.0);
    _tabController = TabController(
        initialIndex: 0, vsync: this, length: _commodityClassifyList.length);
  }

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

  /// 商品分类名称数组
  List<Widget> _commodityClassifyList = [
    Text('全部'),
    Text('待付款'),
    Text('已付款'),
    Text('商品运送中'),
    Text('已签收'),
    Text('订单正常流程完成'),
    Text('退换处理中'),
    Text('退换处理完成'),
    Text('订单结束'),
  ];

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: Colors.white,
      ),
      child: Scaffold(
        appBar: AppBar(
          leading: GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () {
              Navigator.pop(context);
            },
            child: Center(
              child: Icon(
                Icons.arrow_back_ios,
                color: Colors.black,
                size: 25,
              ),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          title: Text(
            "我的订单",
            style: TextStyle(color: Colors.black),
          ),
        ),
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
                expandedHeight: _expandedHeight,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  collapseMode: CollapseMode.pin,

                  /// 推荐内容区域
                  background: Container(
                    color: Colors.white,
                    child: Column(
                      children: [
                        /// 轮播图
                        Container(
                          height: 100,
                          margin: EdgeInsets.only(top: 20),
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Swiper(
                              itemCount: carouselImageUrls.length,
                              autoplay: true,
                              itemBuilder: (BuildContext context, int index) {
                                return CachedNetworkImage(
                                  imageUrl: carouselImageUrls[index],
                                  fit: BoxFit.cover,
                                );
                              },
                              pagination: SwiperPagination(
                                  builder: DotSwiperPaginationBuilder(
                                size: 6,
                                color: Colors.black54,
                                activeColor: Color(GlobalColor.APP_THEME_COLOR),
                              )),
                            ),
                          ),
                        ),
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
                    labelStyle: TextStyle(fontSize: 16),
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
                    tabs: _commodityClassifyList),
              ),
            ];
          },
          body: Container(
            padding: EdgeInsets.only(
              top: 6,
            ),
            child: TabBarView(
                controller: _tabController,
                children: _commodityClassifyList
                    .asMap()
                    .keys
                    .map((item) => GlobalOrderFormList(
                        netCallFunction:
                            GlobalConst.NET_API_CALL.getContentByType,
                        reqParam: {"contentClassify": item.toString()}))
                    .toList()),
          ),
        ),
      ),
    );
  }
}
