import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/shop/OrderFormItem.dart';

import 'GlobalToast.dart';

/// -------------------------------
/// Des: 全局订单列表
/// -------------------------------

class GlobalOrderFormList extends StatefulWidget {
  /// 请求参数
  Map<String, String> reqParam = Map();

  /// 网络请求方法参数
  Function(Map<String, String> reqParam) netCallFunction;

  GlobalOrderFormList({Key key, this.netCallFunction, this.reqParam});

  @override
  _GlobalOrderFormListState createState() => _GlobalOrderFormListState();
}

class _GlobalOrderFormListState extends State<GlobalOrderFormList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  /// ---------------------- 内容获取相关参数 start ----------------------

  /// 起始页
  num _page = 1;

  /// 页大小
  num _pageSize = 10;

  /// ---------------------- 内容获取相关参数 end ----------------------

  /// 内容项列表
  List<Widget> _orderFormItemList = [
    OrderFormItem(),
    OrderFormItem(),
    OrderFormItem(),
    OrderFormItem(),
  ];

  void initState() {
    /// 参数初始化
//    widget.reqParam = widget.reqParam;
//    widget.netCallFunction(widget.reqParam) = widget.netCallFunction(widget.reqParam);

    /// 初始化
    _refreshContent();
    widget.reqParam['page'] = _page.toString();
    widget.reqParam['pageSize'] = _pageSize.toString();
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
      widget.reqParam['page'] = _page.toString();
//      _orderFormItemList.clear();
    });
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      widget.reqParam['loginUserId'] = loginUserId.toString();
      Future<Map<String, dynamic>> resMap = widget.netCallFunction(widget.reqParam);
    });
  }

  /// 加载更多内容
  void _loadContent() {
    // monitor network fetch
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      widget.reqParam['loginUserId'] = loginUserId.toString();
      Future<Map<String, dynamic>> resMap = widget.netCallFunction(widget.reqParam);
    });
  }

  /// ---------------------------------------------------

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
      child: _getGlobalOrderFormList(),
    );
  }

  /// 获取内容List
  Widget _getGlobalOrderFormList() {
    return ListView.builder(
        itemCount: _orderFormItemList.length,
        itemBuilder: (context, i) {
          return _orderFormItemList[i];
        });
  }
}
