import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/user/RowUserItem_3.dart';

class FansMessagePage extends StatefulWidget {
  FansMessagePage({Key key}) : super(key: key);

  @override
  _FansMessagePageState createState() => _FansMessagePageState();
}

class _FansMessagePageState extends State<FansMessagePage>
    with TickerProviderStateMixin {
  bool flag = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 粉丝用户列表
  List _fansUserList=List();

  /// 相关请求参数
  String _page = "1";
  String _pageSize = "10";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// --------------------- 初始化粉丝列表 start ---------------------
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      GlobalConst.NET_API_CALL
          .getFansListByUserId(loginUserId.toString(), _page, _pageSize)
          .then((value) {
        if(value['code']==0){
              /// 响应成功
              setState(() {
                List userList=value['data'];
                for(Map user in userList){
                  _fansUserList.add(user);
                }
              });
            }else{
              /// 响应失败
            }
      });
    });
    /// --------------------- 初始化粉丝列表 end ---------------------

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
              '新增粉丝',
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
          child:
              ListView.builder(
                  itemCount:_fansUserList.length,
                  itemBuilder: (BuildContext context, int index) {
            return RowUserItem_3(_fansUserList[index]);
          }),
        ),
      ),
    );
  }
}
