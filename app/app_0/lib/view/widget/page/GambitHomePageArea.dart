import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/enums/GlobalGambitHomePageTypeEnum.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/content/ContentItem.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/content/HotCommentContentItem.dart';
import 'package:xhd_app/view/widget/content/HotCommentContentItemAddHotCommentTag.dart';

/// -------------------------------
/// Des: 话题主页内容区构建
/// -------------------------------
class GambitHomePageArea extends StatefulWidget {
  /// gambitId 话题id
  String gambitId;

  /// classify 话题页内容分类
  String classify;

  GambitHomePageArea(this.gambitId, this.classify, {Key key}) : super(key: key);

  @override
  _GambitHomePageAreaState createState() {
    return _GambitHomePageAreaState();
  }
}

class _GambitHomePageAreaState extends State<GambitHomePageArea> {
  /// 页号
  num _page = 1;

  /// 页大小
  num _pageSize = 10;

  /// 刷新组件控制器
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 内容项列表
  List<Widget> _contentItemList = [];

  /// 初始化内容
  void initContent() {
    refreshContent();
  }

  /// 刷新
  void refreshContent() {
    setState(() {
      _contentItemList.clear();
    });
    /// --------------------- 刷新处理 start ---------------------
    if (GlobalGambitHomePageTypeEnum.HOTCOMMENT.index.toString() !=
        widget.classify) {
      /// 全部内容
      // monitor network fetch
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getContentListByGambitId(widget.gambitId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            /// 结果集内容列表
            List dataList = value['data'];
            setState(() {
              for (Map m in dataList) {
                _contentItemList.add(ContentItem(m));
              }
            });
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 复位页号
          _page = 1;

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    } else if (GlobalGambitHomePageTypeEnum.HOTCOMMENT.index.toString() ==
        widget.classify) {
      /// 发起评论内容
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getContentListByGambitId(widget.gambitId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value["data"];
            for (Map map in dataList) {
              /// 构建内容项队列
              setState(() {
                _contentItemList.add(HotCommentContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 复位页号
          _page = 1;

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    }

    /// --------------------- 刷新处理 end ---------------------
  }

  /// 加载
  void loadContent() {
    /// --------------------- 加载处理 start ---------------------
    if (GlobalGambitHomePageTypeEnum.HOTCOMMENT.index.toString() !=
        widget.classify) {
      /// 全部内容
      // monitor network fetch
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getContentListByGambitId(widget.gambitId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            /// 结果集内容列表
            List dataList = value['data'];
            setState(() {
              for (Map m in dataList) {
                _contentItemList.add(ContentItem(m));
              }
            });
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 自增页号
          _page++;

          /// 释放刷新状态
          _refreshController.loadComplete();
        });
      });
    } else if (GlobalGambitHomePageTypeEnum.HOTCOMMENT.index.toString() ==
        widget.classify) {
      /// 热评专区
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getContentListByGambitId(widget.gambitId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value["data"];
            for (Map map in dataList) {
              /// 评论内容

              /// 构建内容项队列
              setState(() {
                _contentItemList.add(HotCommentContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 自增页号
          _page++;

          /// 释放刷新状态
          _refreshController.loadComplete();
        });
      });
    }

    /// --------------------- 加载处理 end ---------------------
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 初始化
    initContent();
  }

  @override
  Widget build(BuildContext context) {
    Widget contentArea = StatefulBuilder(builder: (context, setState) {
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
        onRefresh: refreshContent,
        onLoading: loadContent,
        child: ListView.builder(
            itemCount: _contentItemList.length,
            itemBuilder: (context, i) {
              return _contentItemList[i];
            }),
      );
    });
    return contentArea;
  }
}
