import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/content/GoodContentItem.dart';
import 'package:xhd_app/view/widget/content/SysContentItem.dart';
import 'package:xhd_app/view/widget/message/GlobalMessageBuilder.dart';

/// -------------------------------
/// Des: 用户消息主页
/// -------------------------------
class MessagePage extends StatefulWidget {
  @override
  _MessagePageState createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage>
    with SingleTickerProviderStateMixin, TickerProviderStateMixin {
  /// ------------------ 局部组件初始化 start ------------------
  /// 页面key
  GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  /// ------------------ 局部组件初始化 end ------------------

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _scrollViewController;

  /// 拓展区域高度
  double _expandedHeight;

  /// 消息列表
  List _messageList = [
    GlobalMessageBuilder.buildSystemMessage(),
    GlobalMessageBuilder.buildPushMessage(),
    GlobalMessageBuilder.buildServiceMessage(),
  ];

  @override
  void initState() {
    super.initState();

    /// ----------------- 顶部拓展区高度初始化 start -----------------
    /// 拓展区域高度
    _expandedHeight = 180;

    /// ----------------- 顶部拓展区高度初始化 end -----------------
    /// ----------------- 系统消息与私信消息初始化 start -----------------
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      GlobalConst.NET_API_CALL
          .getMessageByUserId(loginUserId.toString())
          .then((value) {
            if(value['code']==0){
              setState(() {
                List contentList=value['data'];
                for(Map c in contentList){
                  if(c['srcType']==0){
                    /// 系统通知
                    Map tmessSysInform=c['tmessSysInform'];
                    _messageList.add(SysContentItem(tmessSysInform['tcContent']));
                  }else{
                    /// 私信模块
                  }
                }
              });
            }else{
            }
            print("当前系统消息---${value}");
      });
    });

    /// ----------------- 系统消息与私信消息初始化 end -----------------
  }

  @override
  void dispose() {
    super.dispose();
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

  /// 获取内容List
  Widget _getContentList() {
    return ListView.builder(itemBuilder: (context, i) {
      return GoodContentItem(Map());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(primaryColor: Colors.white),
        child: Scaffold(
          key: scaffoldKey,
          body: NestedScrollView(
            controller: _scrollViewController,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverAppBar(
                  leading: Container(),
                  floating: false,

                  /// 滑动到最上面，再滑动是否隐藏导航栏的文字和标题等的具体内容，为true是隐藏，为false是不隐藏
                  pinned: true,

                  /// 是否固定导航栏，为true是固定，为false是不固定，往上滑，导航栏可以隐藏
                  snap: false,

                  /// 只跟floating相对应，如果为true，floating必须为true，也就是向下滑动一点儿，整个大背景就会动画显示全部，网上滑动整个导航栏的内容就会消失
                  title: Text("消息"),
                  expandedHeight: _expandedHeight,
                  flexibleSpace: FlexibleSpaceBar(
                      centerTitle: true,
                      collapseMode: CollapseMode.pin,
                      background: Stack(
                        children: [
                          /// 用户信息区域
                          Container(
                            /// 头部整个背景颜色
                            height: double.infinity,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                /// 用户信息区域
                                _buildFunctionArea(),
                              ],
                            ),
                          ),
                        ],
                      )),
                )
              ];
            },
            body: Container(
              color: Colors.white,
              padding: EdgeInsets.only(top: 10, bottom: 10),
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
                    itemCount: _messageList.length,
                    itemBuilder: (BuildContext context, int index) {
                      return _messageList[index];
                    }),
              ),
            ),
          ),
        ));
  }

  /// 构建功能区域
  Widget _buildFunctionArea() {
    return Container(
      width: double.infinity,
      child: Column(
        children: [
          /// 消息类型
          Container(
            padding: EdgeInsets.only(left: 30, right: 30, top: 20, bottom: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                /// 赞和收藏
                GestureDetector(
                  onTap: () {
                    GlobalRouteTable.goGoodAndCollectMessagePage(context);
                  },
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          GlobalFilePath.MESSAGE_GOOD_AND_COLL,
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "赞和收藏",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 新增粉丝
                GestureDetector(
                  onTap: () {
                    GlobalRouteTable.goFansMessagePage(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset(
                          GlobalFilePath.MESSAGE_NEW_FANS,
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "新增粉丝",
                            style: TextStyle(fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// 评论和@
                GestureDetector(
                  onTap: () {
                    GlobalRouteTable.goCommentAndAtMessagePage(context);
                  },
                  child: Container(
                    child: Column(
                      children: [
                        Image.asset(
                          GlobalFilePath.MESSAGE_COMMENT_AND_AT,
                          width: 50,
                          height: 50,
                        ),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.only(top: 10),
                          child: Text(
                            "评论和@",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 分割线
          Container(
            width: double.infinity,
            height: 3,
            color: Color(GlobalColor.MAX_SHALLOW_GRAY),
          ),
        ],
      ),
    );
  }
}
