import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';
import 'package:xhd_app/view/widget/shop/GlobalShopCartItemBuilder.dart';

/// -------------------------------
/// Des: 购物车页面
/// -------------------------------

class ShoppingCartPage extends StatefulWidget {
  ShoppingCartPage({Key key}) : super(key: key);

  @override
  _ShoppingCartPageState createState() => _ShoppingCartPageState();
}

class _ShoppingCartPageState extends State<ShoppingCartPage>
    with TickerProviderStateMixin {
  /// 全选标识符
  bool _allSelect = false;

  /// 商品项目
  List<Widget> _commodityItem=[
    GlobalShopCartItemBuilder.buildShopCartItem(),
    GlobalShopCartItemBuilder.buildShopCartItem(),
    GlobalShopCartItemBuilder.buildShopCartItem(),
    GlobalShopCartItemBuilder.buildShopCartItem(),
  ];

  /// 刷新内容
  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  /// 加载内容
  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
  }

  /// 刷新组件控制器
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 滚动组件控制器
  ScrollController _scrollController = ScrollController();

  /// 构建页
  Widget _buildPage() {
    return StatefulBuilder(builder: (context, setState) {
      return new Column(children: <Widget>[
        /// ----------------- 页面主题区域 start -----------------
        new Flexible(
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
            child: ListView.builder(
                controller: _scrollController,
                itemCount: _commodityItem.length,
                itemBuilder: (context, i) {
                  return _commodityItem[i];
                }),
          ),
        ),

        /// ----------------- 页面主题区域 start -----------------
        /// 分隔线
        new Divider(height: 1.0),

        /// ----------------- 付款操作区域 start -----------------
        Container(
          padding: EdgeInsets.only(bottom: 30, left: 20, right: 20, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ///  按钮区域
              Container(
                child: Row(
                  children: [
                    /// 全选按钮
                    Container(
                      child: Row(
                        children: [
                          Checkbox(
                            value: _allSelect,
                            activeColor: Color(GlobalColor.APP_THEME_COLOR),
                            onChanged: (bool val) {
                              // val 是布尔值
                              setState(() {
                                _allSelect = val;
                              });
                            },
                          ),
                          Text(
                            "全选",
                            style: TextStyle(
                                fontSize: 16,
                                color: Color(GlobalColor.SHALLOW_GRAY)),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              ///  付款信息区域
              Container(
                child: Row(
                  children: [
                    /// 价格信息
                    Container(
                      child: Column(
                        children: [
                          /// 总价
                          Container(
                            child: Row(
                              children: [
                                /// 单位icon
                                Icon(FontAwesome.rmb,
                                    color: Color(GlobalColor.APP_THEME_COLOR)),

                                /// 金额
                                Text(
                                  "6666",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.w600,
                                      color:
                                          Color(GlobalColor.APP_THEME_COLOR)),
                                ),
                              ],
                            ),
                          ),

                          /// 分割线
                          SizedBox(
                            height: 3,
                          ),

                          /// 邮费
                          Container(
                            child: Row(
                              children: [
                                Text(
                                  "邮费 : ",
                                  style: TextStyle(
                                      color: Color(GlobalColor.SHALLOW_GRAY)),
                                ),

                                /// 邮费金额单位icon
                                Icon(
                                  FontAwesome.rmb,
                                  color: Color(GlobalColor.SHALLOW_GRAY),
                                  size: 14,
                                ),

                                /// 邮费金额
                                Text(
                                  "100",
                                  style: TextStyle(
                                      color: Color(GlobalColor.SHALLOW_GRAY)),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// 付款按钮
                    Container(
                      padding: EdgeInsets.only(
                        left: 10,
                      ),
                      height: 35,
                      alignment: Alignment.centerLeft,
                      child: CommWidgetBuilder.gradientButton("付款",
                          fontSize: 14, circularValue: 558),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        /// ----------------- 付款操作区域 end -----------------
      ]);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff9fafb),
        appBar: PreferredSize(
            child: AppBar(
              title: Text(
                '购物车',
                style: TextStyle(color: Colors.black87),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              brightness: Brightness.dark,
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
        body: _buildPage());
  }
}
