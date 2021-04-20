import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/content/ContentItem.dart';
import 'package:xhd_app/view/widget/content/HotCommentContentItem.dart';

import 'GlobalToast.dart';

/// -------------------------------
/// Des: 全局神评论内容列表(单列直线列表)
/// -------------------------------

class GlobalHotCommentContentList extends StatefulWidget {
  /// 请求参数
  Map<String, String> _reqParam = Map();

  /// 网络请求方法参数
  Function(Map<String, String> _reqParam) _netCallFunction;

  GlobalHotCommentContentList(Function(Map<String, String> _reqParam) netCallFunction,
      Map<String, String> reqParam,
      {Key key}) {
    _reqParam = reqParam;
    _netCallFunction = netCallFunction;
  }

  @override
  _GlobalHotCommentContentListState createState() =>
      _GlobalHotCommentContentListState(_netCallFunction, _reqParam);
}

class _GlobalHotCommentContentListState extends State<GlobalHotCommentContentList>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

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

  _GlobalHotCommentContentListState(
      Function(Map<String, String> _reqParam) netCallFunction,
      Map<String, String> reqParam) {
    _reqParam = reqParam;
    _netCallFunction = netCallFunction;
  }

  /// 内容项列表
  List<Widget> _contentItemList = [];

  void initState() {
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
      print("内容当前登录用户------${loginUserId}");
      _reqParam['loginUserId'] = loginUserId.toString();
      Future<Map<String, dynamic>> resMap = _netCallFunction(_reqParam);
      resMap.then((value) {
        int code = value['code'];
        if (code == 0) {
          /// 结果集内容列表
          List dataList = value['data'];
          setState(() {
            for (Map map in dataList) {
              print("评论项目---${map.toString()}");
              /// 构建内容项队列
              _contentItemList.add(HotCommentContentItem(map));
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
              _contentItemList.add(HotCommentContentItem(map));
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
      child: _getGlobalHotCommentContentList(),
    );
  }

  /// 获取内容List
  Widget _getGlobalHotCommentContentList() {
    return ListView.builder(
        itemCount: _contentItemList.length,
        itemBuilder: (context, i) {
          return _contentItemList[i];
        });
  }
}
