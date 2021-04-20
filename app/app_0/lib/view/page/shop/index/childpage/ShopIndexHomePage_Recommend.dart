import 'package:cached_network_image/cached_network_image.dart';

/// ----------------------------------
/// des:商城首页推荐页
/// ----------------------------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/activity/ActivityCard_1.dart';
import 'package:xhd_app/view/widget/card/MerchantCart_1.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/shop/CommodityItem.dart';

/// -------------------------------
/// Des: 商品主页推荐页面
/// -------------------------------

class ShopIndexHomePage_Recommend extends StatefulWidget {
  /// 请求参数
  Map<String, String> _reqParam = Map();

  /// 网络请求方法参数
  Function(Map<String, String> _reqParam) _netCallFunction;

  ShopIndexHomePage_Recommend(
      Function(Map<String, String> _reqParam) netCallFunction,
      Map<String, String> reqParam,
      {Key key}) {
    _reqParam = reqParam;
    _netCallFunction = netCallFunction;
  }

  @override
  _ShopIndexHomePage_RecommendState createState() =>
      _ShopIndexHomePage_RecommendState(_netCallFunction, _reqParam);
}

class _ShopIndexHomePage_RecommendState
    extends State<ShopIndexHomePage_Recommend>
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

  _ShopIndexHomePage_RecommendState(
      Function(Map<String, String> _reqParam) netCallFunction,
      Map<String, String> reqParam) {
    _reqParam = reqParam;
    _netCallFunction = netCallFunction;
  }

  /// 内容项列表
  List<Widget> _contentItemList = [];

  void initState() {
    /// ----------------- 顶部拓展区高度初始化 start -----------------
    /// 商家推荐区域高度
    merchantRecommendHeight = 228.0;

    /// ----------------- 顶部拓展区高度初始化 end -----------------

    /// 初始化
    _refreshContent();
    _reqParam['page'] = _page.toString();
    _reqParam['pageSize'] = _pageSize.toString();
  }

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

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
        print("响应数据----${value.toString()}");
        int code = value['code'];
        if (code == 0) {
          /// 结果集内容列表
          List dataList = value['data'];
          setState(() {
            for (Map map in dataList) {
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
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
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

  /// 构建商家推荐区域
  Widget _buildMerchantRecommendArea() {
    Widget banner = Container(
      height: merchantRecommendHeight,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(5),
        child: Swiper(
          itemCount: carouselImageUrls.length,
          autoplay: true,
          itemBuilder: (BuildContext context, int index) {
            return MerchantCart_1("", carouselImageUrls[index]);
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

  /// 构建推荐区域
  Widget _buildRecommendArea() {
    Widget recommendArea = Container(
        margin: EdgeInsets.only(
          top: 10,
        ),
        padding: EdgeInsets.only(left: 10, right: 10),
        height: merchantRecommendHeight,
        child: Row(
          children: [
            Expanded(
              flex: 1,
              child: _buildMerchantRecommendArea(),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  /// 限时活动
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration(
                        //背景
                        color: Colors.white,
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(8.0, 8.0), //阴影xy轴偏移量
                              blurRadius: 10.0, //阴影模糊程度
                              spreadRadius: 5.0 //阴影扩散程度
                              )
                        ],
                      ),
                      child: Stack(
                        /// 标题
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "限时购",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "限时限量",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(
                                        GlobalColor.APP_THEME_COLOR,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fspider.nosdn.127.net%2Faefdb7a91be258a45b275f38ada7db30.jpeg&refer=http%3A%2F%2Fspider.nosdn.127.net&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1617246338&t=bc827d4bc69a52fa71b88a4ca76c2689",
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                Expanded(
                                  child: Image.network(
                                    "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fcbu01.alicdn.com%2Fimg%2Fibank%2F2016%2F890%2F192%2F3524291098_1915366348.jpg&refer=http%3A%2F%2Fcbu01.alicdn.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1617244960&t=263dc006557f65f2e271eab76bd24bbe",
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  /// 一元专区
                  Expanded(
                    child: Container(
                      decoration: new BoxDecoration(
                        //背景
                        color: Colors.white,
                        //设置四周圆角 角度
                        borderRadius: BorderRadius.all(Radius.circular(4.0)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.black12,
                              offset: Offset(8.0, 8.0), //阴影xy轴偏移量
                              blurRadius: 10.0, //阴影模糊程度
                              spreadRadius: 5.0 //阴影扩散程度
                              )
                        ],
                      ),
                      child: Stack(
                        /// 标题
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            width: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "一元专区",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 19,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(
                                  "全场一元",
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Color(
                                        GlobalColor.APP_THEME_COLOR,
                                      )),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(bottom: 10),
                            width: double.infinity,
                            height: double.infinity,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Expanded(
                                  child: Image.network(
                                    "https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1251470360,3684920224&fm=26&gp=0.jpg",
                                    width: 45,
                                    height: 45,
                                  ),
                                ),
                                Expanded(
                                  child: Image.network(
                                    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=2058993059,3305810562&fm=26&gp=0.jpg",
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
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
          ],
        ));
    return recommendArea;
  }

  /// 活动区域
  Widget _buildActivityArea() {
    List<Widget> _activityList = [
      ActivityCard_1(),
      ActivityCard_1(),
      ActivityCard_1(),
      ActivityCard_1(),
      ActivityCard_1(),
    ];
    Widget activityArea = Container(
      margin: EdgeInsets.only(
        top: 15,
      ),
      child: Column(
        children: [
          /// 标题
          Container(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            child: Row(
              children: [
                Image.asset(
                  GlobalFilePath.TITLE_LOGO_42,
                  width: 25,
                  height: 25,
                ),
                Container(
                  padding: EdgeInsets.only(left: 5),
                  child: Text(
                    "热门活动",
                    style: TextStyle(
                        fontSize: 16, color: Color(GlobalColor.SHALLOW_GRAY)),
                  ),
                ),
              ],
            ),
          ),

          /// 内容区域
          Container(
            padding: EdgeInsets.only(
              top: 2,
              bottom: 10,
            ),
            width: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: _activityList),
            ),
          ),
        ],
      ),
    );
    return activityArea;
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
                /// 横幅
                _buildBannerArea(),

                /// 推荐区域
                _buildRecommendArea(),

                /// 活动区域
                _buildActivityArea(),

                /// 内容列表
                _getContentList(),
              ],
            );
          }),
    );
  }
}
