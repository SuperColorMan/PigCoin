import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';

/// ----------------------------------
/// des: 商品选择页面
/// ----------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalCommodityList.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/shop/CommoditySelectItem.dart';

class CommoditySelectPage extends StatefulWidget {
  CommoditySelectPage({Key key}) : super(key: key);

  @override
  _CommoditySelectPageState createState() => _CommoditySelectPageState();
}

//页面状态配置,用于动态修改页面数据,页面事件等。
class _CommoditySelectPageState extends State<CommoditySelectPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 分页数据
  String page = "1";
  String pageSize = "10";

  /// 查询方式
  String searchType = "0";

  /// 下拉刷新
  void _onRefresh() async {
    /// 释放刷新状态
    _refreshController.refreshCompleted();
  }

  /// 上拉加载
  void _onLoading() async {
    /// 释放加载状态
    _refreshController.loadComplete();
  }

  /// 搜索框文本编辑器控制器
  TextEditingController _textEditingController = TextEditingController();

  /// 搜搜输入框焦点对象
  final FocusNode _focusNode = FocusNode();

  /// 选择的商品id列表
  List _selectedCommodityIdList = [];

  /// 选择的分类
  String selectedClassify = "";

  /// 商品选择回调
  void selectItemCallBack(bool isSelected, String id) {
    /// 添加商品id
    if (isSelected) {
      _selectedCommodityIdList.add(id);
    } else {
      _selectedCommodityIdList.remove(id);
    }
  }

  /// ---------------------- 商品条目列表 ----------------------
  List<Widget> _commodityItemList = [];

  /// -----------------------------------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 初始化
    _commodityItemList
        .add(CommoditySelectItem(selectItemCallBack: selectItemCallBack));
    _commodityItemList
        .add(CommoditySelectItem(selectItemCallBack: selectItemCallBack));
    _commodityItemList
        .add(CommoditySelectItem(selectItemCallBack: selectItemCallBack));
    _commodityItemList
        .add(CommoditySelectItem(selectItemCallBack: selectItemCallBack));
  }

  @override
  Widget build(BuildContext context) {
    /// 拓展区域高度
    double _expandedHeight = 150;

    /// 搜索框
    Widget _searchBox = Container(
      padding: EdgeInsets.only(left: 10, right: 10, top: 10),
      child: Row(
        children: [
          /// 搜索框
          Expanded(
            child: TextField(
              onChanged: (String str) {
                print("输入内容$str");
              },
              controller: _textEditingController,
              maxLines: 1,
              focusNode: _focusNode,
              decoration: InputDecoration(
                hintText: "搜索商品",
                hintMaxLines: 20,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(5),
                  borderSide: BorderSide.none,
                ),
                // 是否使用填充色
                filled: true,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 10),
              ),
            ),
          ),

          /// 搜索按钮
          GestureDetector(
            onTap: () {
              /// 执行搜索商品
            },
            child: Container(
              padding: EdgeInsets.only(
                left: 10,
              ),
              child: SizedBox(
                width: 70,
                child: RaisedButton(
                  color: Color(GlobalColor.APP_THEME_COLOR),
                  onPressed: () {},
                  child: Text(
                    '搜索',
                    style: TextStyle(fontSize: 16.0, color: Colors.white),
                  ),

                  ///圆角
                  shape: RoundedRectangleBorder(
                      side: BorderSide.none,
                      borderRadius: BorderRadius.all(Radius.circular(5))),
                ),
              ),
            ),
          ),
        ],
      ),
    );

    /// 加载内容
    void loadContent() {
      if (searchType == "0") {
        print("根据分类选择。。。");
        /// 根据分类
        ///  -------------------- 初始化关注的人发布的商品 start --------------------
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .getCommodityListByClassifys(
                  selectedClassify, page.toString(), pageSize.toString());
          resMap.then((value) {
            int code = value['code'];
            if (code == 0) {
              List dataList = value['data'];
              setState(() {
                _commodityItemList.clear();
                for (Map m in dataList) {
                  _commodityItemList.add(CommoditySelectItem(
                      selectItemCallBack: selectItemCallBack));
                }
              });
            } else if (code == 1) {
              GlobalToast.showToast("获取关联商品失败");
            }
          });
        });

        ///  -------------------- 初始化关注的人发布的商品 end --------------------
      } else if (searchType == "1") {
        /// 关注
        ///  -------------------- 初始化关注的人发布的商品 start --------------------
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .getCommodityListByUserAttentionUser(
                  loginUserId.toString(), page.toString(), pageSize.toString());
          resMap.then((value) {
            int code = value['code'];
            if (code == 0) {
              List dataList = value['data'];
              setState(() {
                _commodityItemList.clear();
                for (Map m in dataList) {
                  _commodityItemList.add(CommoditySelectItem(
                      selectItemCallBack: selectItemCallBack));
                }
              });
            } else if (code == 1) {
              GlobalToast.showToast("获取关联商品失败");
            }
          });
        });

        ///  -------------------- 初始化关注的人发布的商品 end --------------------
      } else if (searchType == "2") {
        /// 我的
        ///  -------------------- 初始化我的商品 start --------------------
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .getCommodityListByUserId(
                  loginUserId.toString(), page.toString(), pageSize.toString());
          resMap.then((value) {
            int code = value['code'];
            if (code == 0) {
              List dataList = value['data'];
              setState(() {
                _commodityItemList.clear();
                for (Map m in dataList) {
                  _commodityItemList.add(CommoditySelectItem(
                      selectItemCallBack: selectItemCallBack));
                }
              });
            } else if (code == 1) {
              GlobalToast.showToast("获取关联商品失败");
            }
          });
        });

        ///  -------------------- 初始化我的商品 end --------------------
      } else if (searchType == "3") {
        /// 收藏
        ///  -------------------- 初始化收藏商品 start --------------------
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .getCommodityListByUserAttentionUser(
                  loginUserId.toString(), page.toString(), pageSize.toString());
          resMap.then((value) {
            int code = value['code'];
            if (code == 0) {
            } else if (code == 1) {
              GlobalToast.showToast("获取关联商品失败");
            }
          });
        });

        ///  -------------------- 初始化收藏商品 end --------------------
      } else if (searchType == "4") {
        /// 买过
        ///  -------------------- 初始化买过的商品 start --------------------
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .getCommodityListByUserAttentionUser(
                  loginUserId.toString(), page.toString(), pageSize.toString());
          resMap.then((value) {
            int code = value['code'];
            if (code == 0) {
            } else if (code == 1) {
              GlobalToast.showToast("获取关联商品失败");
            }
          });
        });

        ///  -------------------- 初始化买过的商品 end --------------------
      }
    }

    /// 查询方式选择
    Widget _searchFunctionSelect = Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 15),
      padding: EdgeInsets.only(left: 10, right: 10),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            /// 分类
            GestureDetector(
              onTap: () {
                /// 前往商品分类页面
                GlobalRouteTable.goCommoditySelectClassifyPage(context,
                    (String result) {
                  /// 处理商品分类
                  searchType = "0";
                  selectedClassify = result;
                  loadContent();
                  print("选择的分类----${result.toString()}");
                }, defaultIndex: 0);
              },
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        child: Image.asset(
                          GlobalFilePath.TITLE_LOGO_33,
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "分类",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            /// 分隔线
            SizedBox(
              width: 10,
            ),

            /// 关注
            GestureDetector(
              onTap: () {
                /// 获取指定用户关注的用户发布的商品
                searchType = "1";
                loadContent();
              },
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        child: Image.asset(
                          GlobalFilePath.TITLE_LOGO_35,
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "关注",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            /// 分隔线
            SizedBox(
              width: 10,
            ),

            /// 我的
            GestureDetector(
              onTap: () {
                /// 处理我发布的商品
                searchType = "2";
                loadContent();
              },
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        child: Image.asset(
                          GlobalFilePath.TITLE_LOGO_32,
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "我的",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            /// 分隔线
            SizedBox(
              width: 10,
            ),

            /// 收藏
            GestureDetector(
              onTap: () {
                /// 处理我收藏的商品
              },
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        child: Image.asset(
                          GlobalFilePath.TITLE_LOGO_31,
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "收藏",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),

            /// 分隔线
            SizedBox(
              width: 10,
            ),

            /// 买过
            GestureDetector(
              onTap: () {
                /// 处理我买过的商品
              },
              child: Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(4),
                          topRight: Radius.circular(4),
                          bottomLeft: Radius.circular(4),
                          bottomRight: Radius.circular(4),
                        ),
                        child: Image.asset(
                          GlobalFilePath.TITLE_LOGO_29,
                          width: 40,
                          height: 40,
                          fit: BoxFit.fill,
                        )),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "买过",
                      style: TextStyle(fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ]),
    );

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        actions: [
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8, right: 10),
            child: SizedBox(
              width: 70,
              child: RaisedButton(
                color: Color(GlobalColor.APP_THEME_COLOR),
                onPressed: () {
                  /// 选择商品的id列表
                  String _selectedCommodityIdListStr =
                      json.encode(_selectedCommodityIdList);
                  setState(() {
                    /// 清空列表
                    _selectedCommodityIdList.clear();
                  });
                  Navigator.pop(context, _selectedCommodityIdListStr);
                },
                child: Text(
                  '确定',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),

                ///圆角
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          "选择商品",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: GestureDetector(
          onTap: () {
            setState(() {
              /// 失去焦点
              _focusNode.unfocus();

              /// 清空搜索关键字
              _textEditingController.clear();
            });
          },
          child: NestedScrollView(
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  backgroundColor: Colors.white,
                  //滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
                  floating: true,
                  //是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
                  pinned: false,
                  snap: false,
                  expandedHeight: _expandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                    centerTitle: true,
                    collapseMode: CollapseMode.pin,

                    /// 推荐内容区域
                    background: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          /// 搜索框
                          _searchBox,

                          /// 查询方式选择
                          _searchFunctionSelect,
                        ],
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: Container(
              padding: EdgeInsets.only(
                top: 6,
              ),
              child: SmartRefresher(
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
                child: StaggeredGridView.countBuilder(
                    crossAxisCount: 4,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                    staggeredTileBuilder: (index) => StaggeredTile.fit(2),
                    itemCount: _commodityItemList.length,
                    // 数据量大小
                    itemBuilder: (context, i) {
                      return _commodityItemList[i];
                    }),
              ),
            ),
          )),
    );
  }
}
