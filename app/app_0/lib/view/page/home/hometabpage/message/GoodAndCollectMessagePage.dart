import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/enums/GlobalUserMessageTypeEnum.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/content/CollectContentItem.dart';
import 'package:xhd_app/view/widget/content/GoodContentItem.dart';

class GoodAndCollectMessagePage extends StatefulWidget {
  GoodAndCollectMessagePage({Key key}) : super(key: key);

  @override
  _GoodAndCollectMessagePageState createState() =>
      _GoodAndCollectMessagePageState();
}

class _GoodAndCollectMessagePageState extends State<GoodAndCollectMessagePage>
    with TickerProviderStateMixin {
  bool flag = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 获取指定用户被点赞与收藏的内容列表
  List _goodAndCollectContentList = List();

  /// 相关请求参数
  num _page = 1;
  num _pageSize = 10;
  String _loginUserId = "0";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// ------------------ 页面数据初始化 start ------------------
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      setState(() {
        _loginUserId = loginUserId.toString();
      });
      GlobalConst.NET_API_CALL
          .getByCollectAndGoodContentListByUserId(_loginUserId, _loginUserId,
              _page.toString(), _pageSize.toString())
          .then((value) {
        print("点赞回传---${value}");
        if (value['code'] == 0) {
          /// 获取成功
          List _contentList = value['data'];
          setState(() {
            for (Map content in _contentList) {
              if (content['userMessType'].toString() ==
                  GlobalUserMessageTypeEnum.GOOD.index.toString()) {
                /// 点赞内容
                print("点赞内容");

                _goodAndCollectContentList.add(GoodContentItem(content));
              } else if (content['userMessType'].toString() ==
                  GlobalUserMessageTypeEnum.COLLECT.index.toString()) {
                /// 收藏内容
                print("收藏内容");

                _goodAndCollectContentList.add(CollectContentItem(content));
              }
            }
          });
        } else {
          /// 获取失败
        }
      });
    });

    /// ------------------ 页面数据初始化 end ------------------
  }

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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff9fafb),
      appBar: PreferredSize(
          child: AppBar(
            title: Text(
              '点赞与收藏',
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
      body: Container(
        color: Colors.white,
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
              itemCount: _goodAndCollectContentList.length,
              itemBuilder: (BuildContext context, int index) {
                return _goodAndCollectContentList[index];
              }),
        ),
      ),
    );
  }
}
