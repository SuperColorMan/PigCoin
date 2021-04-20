import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/shop/CommodityItem.dart';

/// ----------------------------------
/// des: 商品主页子页面
/// ----------------------------------
class ShopIndexHomePage_Child extends StatefulWidget {
  /// 请求参数
  Map<String, String> _reqParam = Map();

  /// 网络请求方法参数
  Function(Map<String, String> _reqParam) _netCallFunction;

  ShopIndexHomePage_Child(
      Function(Map<String, String> _reqParam) netCallFunction,
      Map<String, String> reqParam,
      {Key key}) {
    _reqParam = reqParam;
    _netCallFunction = netCallFunction;
  }

  @override
  _ShopIndexHomePage_ChildState createState() =>
      _ShopIndexHomePage_ChildState(_netCallFunction, _reqParam);
}

class _ShopIndexHomePage_ChildState extends State<ShopIndexHomePage_Child>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  /// 商家推荐区域高度
  double merchantRecommendHeight;

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

  /// ---------------------- 内容获取相关参数 start ----------------------
  /// 请求参数
  Map<String, String> _reqParam = Map();

  /// 起始页
  num _page = 1;

  /// 页大小
  num _pageSize = 10;

  /// 网络请求方法参数
  Function(Map<String, String> _reqParam) _netCallFunction;

  /// ---------------------- 内容获取相关参数 end ----------------------

  _ShopIndexHomePage_ChildState(
      Function(Map<String, String> _reqParam) netCallFunction,
      Map<String, String> reqParam) {
    _reqParam = reqParam;
    _netCallFunction = netCallFunction;
  }

  /// 内容项列表
  List<Widget> _contentItemList = [];

  /// 导航按钮数组
  List<Widget> _navBtnList = [];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 小类初始化
  void _smallClaasifyInit() {
    Future<Map<String, dynamic>> resMap =
        GlobalConst.NET_API_CALL.getSmallClassifyListByBigId(_reqParam);
    resMap.then((value) {
      if (value['code'] == 0) {
        List dataList = value['data'];

        /// 不满2排显示1排
        int len = dataList.length;
        len = len > 10 ? 10 : 5;
        for (int i = 0; i < len; i++) {
          Map m = dataList[i];
          _navBtnList.add(buildNavBtn(m));
        }
      }
      print("小类列表----${value}");
    });
  }

  /// 下拉刷新
  void _onRefresh() async {
    _refreshContent();
  }

  /// 上拉加载
  void _onLoading() async {
    _loadContent();
  }

  /// ----------------- 内容操作方法区域 -----------------
  /// 刷新内容
  void _refreshContent() {
    /// 清空内容列表
    setState(() {
      /// 重置页号
      _page = 1;
      _reqParam['page'] = _page.toString();
      _contentItemList.clear();
    });
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      _reqParam['loginUserId'] = loginUserId.toString();
      Future<Map<String, dynamic>> resMap = _netCallFunction(_reqParam);
      resMap.then((value) {
        int code = value['code'];
        if (code == 0) {
          /// 结果集内容列表
          List dataList = value['data'];
          setState(() {
            for (Map map in dataList) {
              print("商品子页面---${map.toString()}");

              /// 构建内容项队列
              _contentItemList.add(CommodityItem(map));
            }
          });

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        } else if (code == 1) {
          GlobalToast.showToast("请求失败");

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        }
      });
    });
  }

  /// 加载更多内容
  void _loadContent() {
    // monitor network fetch
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      _reqParam['loginUserId'] = loginUserId.toString();
      Future<Map<String, dynamic>> resMap = _netCallFunction(_reqParam);
      resMap.then((value) {
        int code = value['code'];
        if (code == 0) {
          GlobalToast.showToast("请求成功");

          /// 结果集内容列表
          List dataList = value['data'];
          setState(() {
            for (Map map in dataList) {
              /// 构建内容项队列
              _contentItemList.add(CommodityItem(map));
            }

            /// 页号自增
            _page++;
            _reqParam['page'] = _page.toString();
          });

          /// 释放加载状态
          _refreshController.loadComplete();
        } else if (code == 1) {
          GlobalToast.showToast("请求失败");

          /// 释放加载状态
          _refreshController.loadComplete();
        }
      });
    });
  }

  /// ---------------------------------------------------

  /// 构建横幅区域
  Widget _buildBannerArea() {
    Widget banner = Container(
      margin: EdgeInsets.only(bottom: 10),
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        bottom: 0,
      ),
      height: 100,
      child: ClipRRect(
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
    );
    return banner;
  }

  /// 构建导航区域
  Widget buildNavArea() {
    /// 导航区域
    Widget nav = Container(
      margin: EdgeInsets.only(top: 5),
      child: GridView.builder(
          padding: EdgeInsets.only(top: 0, bottom: 0),
          //解决无限高度问题
          shrinkWrap: true,
          //禁用滑动事件
          physics: NeverScrollableScrollPhysics(),
          itemCount: _navBtnList.length,
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 5,
            //纵轴间距
            mainAxisSpacing: 1.0,
            //横轴间距
            crossAxisSpacing: 0.0,
          ),
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            return _navBtnList[index];
          }),
    );
    return nav;
  }

  /// 获取内容List
  Widget _getContentList() {
    return StaggeredGridView.countBuilder(
        padding: EdgeInsets.only(top: 0),
        //解决无限高度问题
        shrinkWrap: true,
        //禁用滑动事件
        physics: NeverScrollableScrollPhysics(),
        crossAxisCount: 4,
        crossAxisSpacing: 6,
        mainAxisSpacing: 6,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        itemCount: _contentItemList.length,
        // 数据量大小
        itemBuilder: (context, i) {
          return _contentItemList[i];
        });
  }

  /// 构建导航按钮
  Widget buildNavBtn(Map smallClassifyStruct) {
    return Column(
      children: [
        CachedNetworkImage(
          imageUrl:
              "${GlobalApiUrlTable.COMMODITY_CLASSIFY_HEAD_PIC}?id=${smallClassifyStruct['id'].toString()}",
          width: 40,
          height: 40,
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "${smallClassifyStruct['name'].toString()}",
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  void initState() {
    /// 小类初始化
    _smallClaasifyInit();

    /// ----------------- 顶部拓展区高度初始化 start -----------------
    /// 商家推荐区域高度
    merchantRecommendHeight = 228.0;

    /// ----------------- 顶部拓展区高度初始化 end -----------------

    /// 初始化
    _refreshContent();
    _reqParam['page'] = _page.toString();
    _reqParam['pageSize'] = _pageSize.toString();
  }

  @override
  Widget build(BuildContext context) {
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        waterDropColor: Color(GlobalColor.APP_THEME_COLOR),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return Column(
              children: [
                /// 导航区域
                buildNavArea(),

                /// 横幅
                _buildBannerArea(),

                /// 内容列表
                _getContentList(),
              ],
            );
          }),
    );
  }
}
