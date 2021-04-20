import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/search/SearchPageBuilder.dart';

/// -------------------------------
/// Des: 热搜页面内容区
/// -------------------------------
class HotSearchPageContentArea extends StatefulWidget {
  String userId;

  String classify;

  HotSearchPageContentArea(this.userId, this.classify, {Key key})
      : super(key: key);

  @override
  _HotSearchPageContentAreaState createState() {
    return _HotSearchPageContentAreaState();
  }
}

class _HotSearchPageContentAreaState extends State<HotSearchPageContentArea> {
  /// 页号
  num _page = 1;

  /// 页大小
  num _pageSize = 10;

  /// 刷新组件控制器
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 内容项列表
  List<Widget> _hotKeyWordItemList = [];

  /// 内容区背景颜色
  Color _contentAreaBgColor = Colors.white;

  /// 内容是否为空
  bool _contentIsNull = false;

  /// 初始化内容
  void _initContent() {
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      Future<Map<String, dynamic>> resMap =
          GlobalConst.NET_API_CALL.getUserContentByClassify(
        widget.userId,
        loginUserId.toString(),
        _page.toString(),
        _pageSize.toString(),
        "0",
      );
      resMap.then((value) {
        int code = value['code'];
        if (code == 0) {
          List dataList = value['data'];
          if (dataList.isEmpty || dataList.length == 0) {
            setState(() {
              _contentIsNull = true;
            });
          }
          setState(() {
            for (int i = 0; i < dataList.length; i++) {
              Map m = dataList[i];
              _hotKeyWordItemList
                  .add(SearchPageBuilder.buildHotSearchKeyWordItem(i + 1));
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
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentIsNull = false;
    /// 清空内容
    _hotKeyWordItemList.clear();
    /// 初始化内容
    _initContent();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      /// 构建用户页内容区背景
      Widget _buildUserBgImg() {
        if (_contentIsNull) {
          _contentAreaBgColor = Color(GlobalColor.MAX_SHALLOW_GRAY);
          return Container(
            padding: EdgeInsets.only(top: 60),
            alignment: Alignment.topCenter,
            child: Opacity(
              opacity: 0.5,
              child: Image.asset(
                "${GlobalFilePath.USER_PAGE_NULL_CONTENT}",
                width: 200,
                height: 200,
              ),
            ),
          );
        } else {
          return Container();
        }
      }

      /// 构建用户内容区
      return Container(
          color: _contentAreaBgColor,
          child: Stack(
            children: [
              /// 背景图片
              _buildUserBgImg(),

              /// 内容区域
              SmartRefresher(
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
                onRefresh: () {
                  setState(() {
                    /// 清空内容
                    _hotKeyWordItemList.clear();
                  });
                  _initContent();
                },
                onLoading: () {},
                child: ListView.builder(
                    itemCount: _hotKeyWordItemList.length,
                    itemBuilder: (context, i) {
                      if (_hotKeyWordItemList.length > 0) {
                        return _hotKeyWordItemList[i];
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ));
    });
  }
}
