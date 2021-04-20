import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/page/SearchHomeLevelArea.dart';
import 'package:xhd_app/view/widget/page/SearchHomePageWidget.dart';
import 'package:xhd_app/view/widget/search/SearchPageBuilder.dart';

/// -----------------------
/// des: 搜索主页
/// -----------------------
const url =
    'http://www.pptbz.com/pptpic/UploadFiles_6909/201203/2012031220134655.jpg';

class SearchHomePage extends StatefulWidget {
  @override
  _SearchHomePageState createState() => _SearchHomePageState();
}

class _SearchHomePageState extends State<SearchHomePage> {
  /// 接口调用对象
  GlobalNetApiCall _globalNetApiCall = GlobalNetApiCall();

  /// 搜索框焦点对象
  FocusNode _focusNode = FocusNode();

  /// 热门搜索关键字列表
  List<Widget> _hotSearchKeyWord = [
    Container(
      padding: EdgeInsets.only(top: 10, bottom: 10),
      alignment: Alignment.centerLeft,
      child: Row(
        children: [
          Expanded(
            child: Text(
              "热热搜1热搜1热搜1热搜1热搜1热搜1热搜1热搜1热搜1热搜1热搜1热搜1热搜1搜1",
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
          Icon(
            Icons.whatshot,
            color: Colors.red,
          ),
        ],
      ),
    ),
  ];

  /// 是否显示搜索内容结果
  bool _isShowSearchResultArea = false;

  /// 是否显示推荐搜索区域
  bool _isShowRecommendSearchArea = true;

  /// 是否显示关键字预览列表区域
  bool _isShowKeyWordArea = false;

  /// 是否显示历史搜索关键字列表区域
  bool _isShowHistoryKeyWordArea = false;

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

  /// 文本编辑器控制器
  final TextEditingController _searchTextEditingController =
      TextEditingController();

  List list = List();
  ScrollController _scrollController;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// --------------------- tabbar配置参数区域 start---------------------
  var _tabTitle = [];

  var _tabClassify = [];

  /// --------------------- tabbar配置参数区域 end---------------------

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refresh();
    _scrollController = ScrollController()
      ..addListener(() {
        //判断是否滑到底
        if (_scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent) {
          _loadMore();
        }
      });

    /// 编辑框焦点监听
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        /// 获取焦点

      } else {}
    });

    /// --------------- 内容分类初始化 start ---------------
    _globalNetApiCall.getSearchResultType().then((type) {
      if (type['code'] == 0) {
        setState(() {
          List dataList = type['data'];
          for (Map m in dataList) {
            _tabTitle.add(m['des']);
            _tabClassify.add(m['type'].toString());
          }
        });
      } else {
        GlobalToast.showToast("分类获取失败");
      }
    });

    /// --------------- 内容分类初始化 end ---------------
  }

  //获取内容List
  Widget _getContentList() {
    return ListView.builder(itemBuilder: (context, i) {
      return new Container(
        margin: EdgeInsets.only(bottom: 10),
        child: Column(children: [
          //用户信息
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Expanded(
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1056629638,148331236&fm=26&gp=0.jpg',
                      fit: BoxFit.cover,
                      width: 38,
                      height: 38,
                      // color: Colors.black
                    ),
                  ),
                  Container(
                      width: 250,
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "名称1名称12312312312123名称12312312312123名称12312312312123名称12312312312123名称123123123121232312312312123",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )),
                ],
              ),
            ),
          ),
          //描述
          Container(
              padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
              child: Text(
                "erqwherhqwioejriojqiowjeriojqwioejriojqwioerjosdjfoiajsopjfpoqwjeroqwjeoir",
                style: TextStyle(fontSize: 16),
              )),
          //图片
          Container(
              child: CachedNetworkImage(
            imageUrl:
                'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1056629638,148331236&fm=26&gp=0.jpg',
            fit: BoxFit.fitWidth,
            placeholder: (context, url) => new Image.asset('images/wallfy.png'),
          )),
          //互动区域
          Container(
              padding: EdgeInsets.only(top: 8, bottom: 8),
              child: Row(
                children: [
                  //点赞
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.thumb_up_alt_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          "赞",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  //点踩
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.thumb_down_alt_outlined,
                          color: Colors.grey,
                        ),
                        Text(
                          "踩",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  //评论
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.chat_bubble_outline,
                          color: Colors.grey,
                        ),
                        Text(
                          "评论",
                          style: TextStyle(color: Colors.grey),
                        )
                      ],
                    ),
                  ),
                  //点赞
                  Expanded(
                    child: Column(
                      children: [
                        Icon(
                          Icons.wifi_tethering_rounded,
                          color: Colors.grey,
                        )
                      ],
                    ),
                  ),
                ],
              )),
        ]),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list.addAll(
            List.generate(Random().nextInt(5) + 1, (i) => 'more Item $i'));
      });
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        list = List.generate(Random().nextInt(20) + 15, (i) => 'Item $i');
      });
    });
  }

  /// 用户项列表
  List classifyContentList = [
    "生活1",
    "生活1",
    "生活1",
    "生活1",
    "生活1",
    "生活1",
    "生活1",
    "生活1",
    "生活1",
  ];

  /// 搜索关键字列表
  List _searchKeyWordList = [];

  /// ---------------- 关键字历史区域 start ----------------
  Widget _buildKeyWordHistory() {
    return Container(
      color: Colors.white,
      child: ListView.builder(
          itemCount: _searchKeyWordList.length,
          itemBuilder: (context, i) {
            return SearchPageBuilder.buildHistorySearchKeyWordItem(
                _searchKeyWordList[i]);
          }),
    );
  }

  /// ---------------- 关键字历史区域 end ----------------

  /// ---------------- 搜索关键字预览 start ----------------
  Widget _buildKeyWordReView() {
    return Container(
      color: Colors.white,
      child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: ListView.builder(
              itemCount: classifyContentList.length,
              itemBuilder: (context, i) {
                return GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    margin: EdgeInsets.only(bottom: 15),
                    child: Row(
                      children: [
                        Container(
                          child: CachedNetworkImage(
                            imageUrl:
                                "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3504145682,2441617993&fm=26&gp=0.jpg",
                            width: 60,
                            height: 60,
                            fit: BoxFit.fill,
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "奥特曼话题",
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10, top: 5),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "110000个内容",
                                  style: TextStyle(
                                      color: Color(GlobalColor.SHALLOW_GRAY)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              })),
    );
  }

  /// ---------------- 搜索关键字预览 end ----------------

  /// ---------------- 推荐搜索区域 start ----------------
  Widget _buildRecommendedSearchArea() {
    return Container(
        color: Colors.white,
        child: MediaQuery.removePadding(
            context: context,
            removeTop: true,
            removeBottom: true,
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      /// 热搜区域
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Column(
                          children: [
                            /// 标题区域
                            Container(
                              alignment: Alignment.center,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      /// logo
                                      Container(
                                        margin: EdgeInsets.only(right: 10),
                                        alignment: Alignment.center,
                                        width: 30,
                                        height: 30,
                                        child: Image.asset(
                                          GlobalFilePath.TITLE_LOGO_4,
                                          fit: BoxFit.fill,
                                          width: 30,
                                          height: 30,
                                        ),
                                      ),

                                      /// 标题文本
                                      Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "热搜榜单",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      GlobalRouteTable.goHotSearchHomePage(
                                          context);
                                    },
                                    child: Row(
                                      children: [
                                        Text(
                                          "更多热搜",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                            color:
                                                Color(GlobalColor.SHALLOW_GRAY),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_forward_ios,
                                          size: 15,
                                          color:
                                              Color(GlobalColor.SHALLOW_GRAY),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            IntrinsicHeight(
                              child: Row(
                                children: [
                                  Expanded(
                                      child: Column(
                                    children: _hotSearchKeyWord,
                                  )),

                                  /// 分隔线
                                  Container(
                                    margin:
                                        EdgeInsets.only(left: 20, right: 20),
                                    color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                                    width: 0.8,
                                  ),
                                  Expanded(
                                      child: Column(
                                    children: _hotSearchKeyWord,
                                  )),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

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
                              size: 8,
                              color: Colors.black54,
                              activeColor: Colors.white,
                            )),
                          ),
                        ),
                      ),

                      /// 榜单区域结构
                      SearchHomeLevelArea(
                        "美食榜单",
                        GlobalFilePath.TITLE_LOGO_1,
                        List(),
                      ),
                      SearchHomeLevelArea(
                        "科技榜单",
                        GlobalFilePath.TITLE_LOGO_2,
                        List(),
                      ),
                      SearchHomeLevelArea(
                        "美女榜单",
                        GlobalFilePath.TITLE_LOGO_3,
                        List(),
                      ),
                    ],
                  );
                })));
  }

  /// ---------------- 推荐搜索区域 end ----------------

  /// ---------------- 搜索结果区域 start ----------------
  Widget _buildSearchResultArea() {
    return NestedScrollView(
      headerSliverBuilder: (context, bool) {
        return [
          new SliverPersistentHeader(
            delegate: new SliverTabBarDelegate(
              new TabBar(
                isScrollable: true,
                tabs: _tabTitle.map((f) => Tab(text: f)).toList(),
                indicatorColor: Colors.red,
                unselectedLabelColor: Colors.black,
                labelColor: Colors.red,
              ),
              color: Colors.white,
            ),
            pinned: true,
          ),
        ];
      },
      body: TabBarView(
        children: _tabClassify
            .map((classify) =>
                SearchHomePageWidget(classify, _searchTextEditingController))
            .toList(),
      ),
    );
  }

  /// ---------------- 搜索结果区域 end ----------------

  /// 构建内容
  Widget _buildContentArea() {
    /// 关键字历史区域
    if (_isShowHistoryKeyWordArea) {
      return _buildKeyWordHistory();
    }

    /// 搜索关键字预览
    if (_isShowKeyWordArea) {
      return _buildKeyWordReView();
    }

    /// 推荐搜索区域
    if (_isShowRecommendSearchArea) {
      /// 是否显示推荐搜索区域
      return _buildRecommendedSearchArea();
    }

    /// 搜索结果区域
    if (_isShowSearchResultArea) {
      /// 构建搜索内容结果区域
      return _buildSearchResultArea();
    }
  }

  @override
  Widget build(BuildContext context) {
    return new DefaultTabController(
        length: _tabTitle.length,
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: PreferredSize(
              child: AppBar(
                title: TextField(
                  controller: _searchTextEditingController,
                  onTap: () {
                    setState(() {
                      /// 是否显示搜索内容结果
                      _isShowSearchResultArea = false;

                      /// 是否显示推荐搜索区域
                      _isShowRecommendSearchArea = false;

                      /// 是否显示关键字预览列表区域
                      _isShowKeyWordArea = false;

                      /// 是否显示历史搜索关键字列表区域
                      _isShowHistoryKeyWordArea = true;
                    });

                    /// 显示搜索历史
                    GlobalLocalCache.getSearchKeyWordList().then((value) {
                      List<String> searchKeyWordList = value;
                      setState(() {
                        _searchKeyWordList.clear();
                        for (String searchKeyWord in searchKeyWordList) {
                          _searchKeyWordList.add(searchKeyWord);
                        }
                      });
                      print("搜索历史-------${searchKeyWordList.toString()}");
                    });
                  },
                  onChanged: (String str) {
                    if (str.length > 0) {
                      setState(() {
                        /// 是否显示搜索内容结果
                        _isShowSearchResultArea = false;

                        /// 是否显示推荐搜索区域
                        _isShowRecommendSearchArea = false;

                        /// 是否显示关键字预览列表区域
                        _isShowKeyWordArea = true;

                        /// 是否显示历史搜索关键字列表区域
                        _isShowHistoryKeyWordArea = false;
                        _searchKeyWordList.clear();
                      });
                    } else {
                      setState(() {
                        /// 是否显示搜索内容结果
                        _isShowSearchResultArea = false;

                        /// 是否显示推荐搜索区域
                        _isShowRecommendSearchArea = true;

                        /// 是否显示关键字预览列表区域
                        _isShowKeyWordArea = false;

                        /// 是否显示历史搜索关键字列表区域
                        _isShowHistoryKeyWordArea = false;
                        _searchKeyWordList.clear();
                      });
                    }
                  },

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
                centerTitle: true,
                elevation: 0,
                backgroundColor: Colors.white,
                brightness: Brightness.dark,
                actions: [
                  GestureDetector(
                    onTap: () {
                      if (_searchTextEditingController.value.text.length > 0) {
                        /// 存在关键字,执行搜索
                        /// 点击搜索
                        setState(() {
                          /// 是否显示搜索内容结果
                          _isShowSearchResultArea = true;

                          /// 是否显示推荐搜索区域
                          _isShowRecommendSearchArea = false;

                          /// 是否显示关键字预览列表区域
                          _isShowKeyWordArea = false;

                          /// 是否显示历史搜索关键字列表区域
                          _isShowHistoryKeyWordArea = false;
                          _searchKeyWordList.clear();
                        });

                        /// 缓存搜索关键字
                        String searchKeyWord =
                            _searchTextEditingController.value.text;
                        GlobalLocalCache.cacheSearchKeyWordList(searchKeyWord);
                      } else {
                        /// 不存在关键词
                        GlobalToast.showToast("请输入关键词!");
                      }
                    },
                    child: Container(
                      padding: EdgeInsets.only(right: 20),
                      child: Center(
                        child: Text(
                          "搜索",
                          style: TextStyle(color: Color(GlobalColor.DEEP_GRAY)),
                        ),
                      ),
                    ),
                  ),
                ],
//        automaticallyImplyLeading: false,
                leading: GestureDetector(
                  onTap: () {
                    if (_isShowSearchResultArea ||
                        _isShowKeyWordArea ||
                        _isShowHistoryKeyWordArea) {
                      setState(() {
                        /// 是否显示搜索内容结果
                        _isShowSearchResultArea = false;

                        /// 是否显示推荐搜索区域
                        _isShowRecommendSearchArea = true;

                        /// 是否显示关键字预览列表区域
                        _isShowKeyWordArea = false;

                        /// 是否显示历史搜索关键字列表区域
                        _isShowHistoryKeyWordArea = false;
                        _searchKeyWordList.clear();

                        /// 清空搜索关键字
                        _searchTextEditingController.clear();
                      });
                    } else if (_isShowRecommendSearchArea) {
                      Navigator.pop(context);
                    }
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
          body: Container(
            color: Color(GlobalColor.MAX_SHALLOW_GRAY),
            margin: EdgeInsets.only(top: 10),
            child: _buildContentArea(),
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
