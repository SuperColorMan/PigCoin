/// ----------------------------------
/// des: 关注话题页
/// ----------------------------------
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/gambit/RowGambitItem.dart';
import 'package:xhd_app/view/widget/gambit/RowGambitItem_3.dart';

class FindPage_1 extends StatefulWidget {
  FindPage_1({Key key}) : super(key: key);

  @override
  _FindPage_1State createState() => _FindPage_1State();
}

//页面状态配置,用于动态修改页面数据,页面事件等。
class _FindPage_1State extends State<FindPage_1> {
  /// 是否存在已加入的话题
  bool _isExisteJoinGambie = false;

  /// 加入话题的列表
  List<Widget> _joinGambitList = [
    RowGambitItem({"name": "123", "contentCount": "12123"}),
  ];

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 下拉刷新
  void _onRefresh() async {
    _refreshController.refreshCompleted();
  }

  /// 上拉加载
  void _onLoading() async {
    _refreshController.loadComplete();
  }

  /// 构建内容区域
  Widget _buildContentArea() {
    if (_isExisteJoinGambie) {
      /// 显已经加入的话题
      return Column(
        children: [
          /// 标题
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Row(
              children: [
                Text(
                  "加入的话题",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),

          /// 加入话题的列表
          Container(
            child: Expanded(
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
                    itemCount: _joinGambitList.length,
                    itemBuilder: (context, i) {
                      return _joinGambitList[i];
                    }),
              ),
            ),
          ),
        ],
      );
    } else {
      /// 显示推荐加入的话题,未加入任何话题
      return Container(
        child: ListView.builder(
            physics: ClampingScrollPhysics(),
            itemCount: 1,
            itemBuilder: (context, i) {
              return Column(
                children: [
                  /// 提示
                  Container(
                    width: double.infinity,
                    height: 100,
                    alignment: Alignment.center,
                    color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          GlobalFilePath.TITLE_LOGO_23,
                          width: 40,
                          height: 40,
                        ),
                        Container(
                          padding: EdgeInsets.only(top: 10),
                          child: Text(
                            "你还没有关注任何话题哦~",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 标题
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "近期热门话题",
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),

                  /// 话题推荐
                  Container(
                    width: double.infinity,
                    child: Expanded(
                      child: Column(
                        children: [
                          RowGambitItem_3(
                              {"name": "123", "contentCount": "12123"}),
                          RowGambitItem_3(
                              {"name": "123", "contentCount": "12123"}),
                          RowGambitItem_3(
                              {"name": "123", "contentCount": "12123"}),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            }),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _buildContentArea(),
    );
  }
}
