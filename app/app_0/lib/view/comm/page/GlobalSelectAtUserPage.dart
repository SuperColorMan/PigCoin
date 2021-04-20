import 'dart:convert';

/// ---------------------------------
/// @用户选择页
/// ---------------------------------
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/user/RowUserItem_2.dart';

/// ------------------------------------
///  全局@用户选择页
/// ------------------------------------
class GlobalSelectAtUserPage extends StatefulWidget {
  @override
  _GlobalSelectAtUserPageState createState() => _GlobalSelectAtUserPageState();
}

class _GlobalSelectAtUserPageState extends State<GlobalSelectAtUserPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// --------------- 当前登录用户相关信息 start
  String _loginUserId = null;
  Map _loginInfo = null;

  /// --------------- 当前登录用户相关信息 end
  /// 是否处于编辑状态
  bool _isEditStatus = false;

  /// 下拉刷新
  void _onRefresh() async {
    _refreshController.refreshCompleted();
  }

  /// 上拉加载
  void _onLoading() async {
    _refreshController.loadComplete();
  }

  /// 文本编辑器控制器
  final TextEditingController _textEditingController = TextEditingController();

  /// 编辑框高度
  double editBoxHeight = 70.0;

  /// 被选择用户信息
  Map _selectedUserInfo = Map();

  /// 输入框焦点对象
  final FocusNode _focusNode = FocusNode();

  /// 用户项列表
  List<Map> _userList = [];

  /// ------------------------ 页面初始化相关数据 start------------------------
  String _page = "1";
  String _pageSize = "10";

  /// ------------------------ 页面初始化相关数据 end------------------------
  ///
  /// 构建搜索用户项列表
  /// Container(
  //              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
  //              margin: EdgeInsets.only(bottom: 15),
  //              child: Row(
  //                children: [
  //                  Container(
  //                    child: Image.network(
  //                      "https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3504145682,2441617993&fm=26&gp=0.jpg",
  //                      width: 60,
  //                      height: 60,
  //                      fit: BoxFit.fill,
  //                    ),
  //                  ),
  //                  Expanded(
  //                    child: Column(
  //                      children: [
  //                        Container(
  //                          margin: EdgeInsets.only(left: 10),
  //                          alignment: Alignment.centerLeft,
  //                          child: Text(
  //                            "奥特曼话题",
  //                            textAlign: TextAlign.left,
  //                          ),
  //                        ),
  //                        Container(
  //                          margin: EdgeInsets.only(left: 10, top: 5),
  //                          alignment: Alignment.centerLeft,
  //                          child: Text(
  //                            "110000个内容",
  //                            style: TextStyle(
  //                                color: Color(GlobalColor.SHALLOW_GRAY)),
  //                          ),
  //                        ),
  //                      ],
  //                    ),
  //                  ),
  //                ],
  //              ),
  //            ),
  Widget _buildSeachUserItemList() {
    return ListView.builder(
        itemCount: _userList.length,
        itemBuilder: (context, i) {
          return GestureDetector(
            onTap: () {
              /// 用户id
              _selectedUserInfo["userId"] = _userList[i]["id"];

              /// 用户名
              _selectedUserInfo["userName"] = _userList[i]["name"];
              String selectedUserInfoStr = json.encode(_selectedUserInfo);
              setState(() {
                _selectedUserInfo.clear();
              });
              Navigator.pop(context, selectedUserInfoStr);
            },
            child: RowUserItem_2(_userList[i]),
          );
        });
  }

  /// 构建标题区域
  Widget _buildTitleArea() {
    if (!_isEditStatus) {
      return Container(
        padding: EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
          bottom: 10,
        ),
        alignment: Alignment.centerLeft,
        child: Text("我关注的人"),
        color: Colors.white,
      );
    } else {
      return Container();
    }
  }

  /// 获取指定用户关注的用户列表
  void _getAttentionUserList(String userId) {
    GlobalConst.NET_API_CALL
        .getUserAttentionListById(userId, _page, _pageSize)
        .then((value) {
          setState(() {
            _userList.clear();
          });
      if (value['code'] == 0) {
        List attentionUserList = value['data'];
        setState(() {
          for (Map user in attentionUserList) {
            _userList.add(user);
          }
        });
      } else if (value['code'] == 1) {
        GlobalToast.showToast(value['mess']);
      }
    });
  }

  /// 初始化登录用户信息
  void _initLoginUserInfo() {
    /// 登录判断
    GlobalLocalCache.getLoginUserId().then((value) {
      setState(() {
        _loginUserId = value.toString();
        _getAttentionUserList(_loginUserId);
      });
    });
    GlobalLocalCache.getLoginUserInfo().then((value) {
      _loginInfo = jsonDecode(value);
    });
  }

  /// 页面初始化
  void _initPage() {
    /// 加载关注用户列表
    _initLoginUserInfo();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        //有焦点
        setState(() {
          _isEditStatus = true;
          _userList.clear();
        });
      } else {
        //失去焦点
        setState(() {
          _isEditStatus = false;
          _textEditingController.clear();
          _getAttentionUserList(_loginUserId);
        });
      }
    });

    /// 初始化页面
    _initPage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          /// 触摸收起键盘
          _focusNode.unfocus();
        },
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              /// 搜索区域
              Container(
                height: editBoxHeight,
                color: Colors.white,
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    /// 返回按钮
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 15),
                      child: GestureDetector(
                          onTap: () {
                            /// 关闭页面
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios)),
                    ),

                    /// 关键字编辑框
                    Expanded(
                      child: TextField(
                        onChanged: (String str) {
                          print("输入内容$str");
                        },
                        controller: _textEditingController,
                        maxLines: 1,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: "内容编辑区域",
                          hintMaxLines: 20,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          // 是否使用填充色
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),

                    /// 搜索按钮
                    Container(
                      padding: EdgeInsets.only(left: 15, right: 10),
                      child: GestureDetector(
                        onTap: () {
                          /// 搜索用户
                          GlobalConst.NET_API_CALL
                              .searchUser(_textEditingController.value.text,
                                  _page, _pageSize)
                              .then((value) {
                            setState(() {
                              /// 清空列表
                              _userList.clear();
                            });
                            if (value['code'] == 0) {
                              List _uList = value['data'];
                              setState(() {
                                for (Map u in _uList) {
                                  _userList.add(u);
                                }
                              });
                            } else if (value['code'] == 1) {
                              GlobalToast.showToast(value['mess']);
                            }
                          });
                        },
                        child: Text(
                          "搜索",
                          style: TextStyle(color: Color(GlobalColor.DEEP_GRAY)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 标题区域
              _buildTitleArea(),

              /// 用户列表区域
              Expanded(
                child: Container(
                  width: double.infinity,
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
                    child: _buildSeachUserItemList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
