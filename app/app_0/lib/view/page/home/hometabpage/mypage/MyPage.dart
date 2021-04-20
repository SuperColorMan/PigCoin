import 'dart:convert';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:xhd_app/model/user/UserInfoModel.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';

class MyPage extends StatefulWidget {
  MyPage({Key key}) : super(key: key);

  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyPage> with TickerProviderStateMixin {
  /// ----------- 用户数据模型 -----------
  UserInfoModel _userInfoModel;

  /// ---------------------------------

  /// 全局api接口调用类
  GlobalNetApiCall _globalNetApiCall = GlobalNetApiCall();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

//    /// 页面初始化
//    _globalNetApiCall.testApi().then((result) {
//      print("接口返回的数据是:${result}");
//    }).whenComplete((){
//      print("异步任务处理完成");
//    }).catchError((result){
//      print("出现异常了");
//    });

    /// ------------- 用户数据初始化 -------------
    _userInfoModel = new UserInfoModel(context);

    ///-----------------------------------------

    isLogin();
  }

  /// 用户id
  String _userId;

  /// 用户个性id
  String _userUId;

  /// 用户名
  String _userName;

  /// 性别
  String _userSex;

  /// 简介
  String _userIntro;

  /// 判断登录情况
  void isLogin() {
    /// ------------- 获取登录信息 start-------------
    /// 登录用户信息
    GlobalLocalCache.getLoginUserInfo().then((loginUserInfo) {
      Map loginUserInfoMap = jsonDecode(loginUserInfo as String) as Map;
      print("登录信息-----${loginUserInfoMap.toString()}");

      /// 互动信息
      Map tuInteractionInfo = loginUserInfoMap['tuInteractionInfo'];

      /// 初始化用户信息
      setState(() {
        /// 用户性别
        String _sex = "外星人";
        if (loginUserInfoMap['sex'] == 0) {
          _sex = "女";
        } else if (loginUserInfoMap['sex'] == 1) {
          _sex = "男";
        } else if (loginUserInfoMap['sex'] == 2) {
          _sex = "外星人";
        }

        /// 用户id
        _userId = loginUserInfoMap['id'].toString();

        /// 用户个性id
        _userUId = loginUserInfoMap['uid'].toString();

        /// 用户名
        _userName = loginUserInfoMap['name'].toString();

        /// 性别
        _userSex = _sex;

        /// 简介
        _userIntro = loginUserInfoMap['intro'].toString();
        _userInfoModel = new UserInfoModel(
          context,
          id: _userId,
          uid: _userUId,
          userName: _userName,
          sex: _userSex,
          intro: _userIntro,
          userHeadImg:
              '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}',
        );
        _userInfoModel.attentionConut =
            tuInteractionInfo['attentionCount'].toString();
        _userInfoModel.fansCount = tuInteractionInfo['fansCount'].toString();
        _userInfoModel.goodCount = tuInteractionInfo['byGoodCount'].toString();
      });
    });

    /// 登录用户信息id获取
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      print("用户id---${loginUserId}");

      /// 今日新增信息数据
      _globalNetApiCall.getToDayInfo(loginUserId.toString()).then((value) {
        Map data = value['data'] as Map;
        _userInfoModel.newAddLookCount = data['lookCount'].toString();
        _userInfoModel.newAddGoodCount = data['goodCount'].toString();
        _userInfoModel.newAddCollectCount = data['collCount'].toString();
      });
      if (loginUserId > 0) {
        setState(() {
          _userAreaFlag = true;
        });
      } else {
        setState(() {
          _userAreaFlag = false;
        });
      }
    });

    /// ------------- 获取登录信息 end-------------
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _buildPage(context));
  }

  /// ----------- 构建用户信息区域(登录状态) start-----------
  Widget _buildUserInfoArea() {
    return Container(
      child: Column(
        children: [
          /// 用户信息
          Container(
            color: Color(0xfffffffff),
            padding: EdgeInsets.only(left: 0, top: 30, right: 0, bottom: 0),
            child: Row(
              children: [
                /// 用户头像
                Container(
                  margin: EdgeInsets.only(left: 15),
                  child: GestureDetector(
                    onTap: () {
                      //跳转到个人页
                      GlobalRouteTable.goMyHomePage(context, 0);
                    },
                    child: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: _userInfoModel.userHeadImg,
                        fit: BoxFit.cover,
                        width: 70,
                        height: 70,
                        // color: Colors.black
                      ),
                    ),
                  ),
                ),

                /// 用户信息区域
                Expanded(
                  flex: 3,
                  child: Container(
                    margin: EdgeInsets.only(left: 1),
                    child: Column(
                      children: [
                        /// 用户名
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              _userInfoModel.userName,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 20,
                              ),
                            )),

                        /// 用户简介
                        Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              _userInfoModel.intro,
                              textAlign: TextAlign.left,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 13,
                              ),
                            )),

                        /// 信息区域
                        Container(
                            margin: EdgeInsets.only(top: 10),
                            padding: EdgeInsets.only(left: 10),
                            child: Row(
                              children: [
                                Container(
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "关注",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 6),
                                        child: Text(
                                          _userInfoModel.attentionConut
                                              .toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "粉丝",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 6),
                                        child: Text(
                                          _userInfoModel.fansCount.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 16),
                                  child: Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          "获赞",
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 6),
                                        child: Text(
                                          _userInfoModel.goodCount.toString(),
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 11,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
                      ],
                    ),
                  ),
                ),

                /// 个人主页
                Expanded(
                  child: GestureDetector(
                    child: Container(
                      decoration: new BoxDecoration(
                        //背景
                        color: Color(0xfff4f5f6),
                        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(10.0)),
                      ),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 10, top: 3, bottom: 5),
                      child: Text(
                        "个人主页",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    onTap: () {
                      /// 跳转到个人页
                      GlobalRouteTable.goMyHomePage(context, 0);
                    },
                  ),
                ),
              ],
            ),
          ),

          /// 导航区域
          Container(
            margin: EdgeInsets.only(top: 15),
            color: Color(0xfffffffff),
            padding: EdgeInsets.only(left: 3, top: 0, right: 3, bottom: 0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// 我的内容
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      GlobalRouteTable.goMyHomePage(context, 1);
                    },
                    child: Container(
                      height: 60,
                      child: new Card(
                        elevation: 2.0, //阴影
                        color: Colors.white, //背景色
                        child: Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: 8, top: 3, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "内容",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "我发布的",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(GlobalColor.SHALLOW_GRAY)),
                                  ),
                                ],
                              ),
                            ),

                            /// 水印
                            Positioned(
                              child: Opacity(
                                  opacity: 0.3, //设置透明度
                                  child: Image.asset(
                                    "images/comm/mypage_tag_content.jpg",
                                    width: 30,
                                    height: 30,
                                  )),
                              bottom: -2,
                              right: -2,
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 2),

                  /// 我的评论
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      GlobalRouteTable.goMyHomePage(context, 3);
                    },
                    child: Container(
                      height: 60,
                      child: new Card(
                        elevation: 2.0, //阴影
                        color: Colors.white, //背景色
                        child: Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: 8, top: 3, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "评论",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "我评论的",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(GlobalColor.SHALLOW_GRAY)),
                                  ),
                                ],
                              ),
                            ),

                            /// 水印
                            Positioned(
                              child: Opacity(
                                  opacity: 0.3, //设置透明度
                                  child: Image.asset(
                                    "images/comm/mypage_tag_comment.jpg",
                                    width: 36,
                                    height: 36,
                                  )),
                              bottom: -7,
                              right: -5,
                            )
                          ],
                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 2),

                  /// 点赞
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      GlobalRouteTable.goMyHomePage(context, 2);
                    },
                    child: Container(
                      height: 60,
                      child: new Card(
                        elevation: 2.0, //阴影
                        color: Colors.white, //背景色
                        child: Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: 8, top: 3, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "点赞",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "我点赞的",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(GlobalColor.SHALLOW_GRAY)),
                                  ),
                                ],
                              ),
                            ),

                            /// 水印
                            Positioned(
                              child: Opacity(
                                  opacity: 0.3, //设置透明度
                                  child: Image.asset(
                                    "images/comm/mypage_tag_good.jpg",
                                    width: 34,
                                    height: 34,
                                  )),
                              bottom: -1,
                              right: -1,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                  SizedBox(width: 2),

                  /// 收藏
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      GlobalRouteTable.goMyHomePage(context, 4);
                    },
                    child: Container(
                      height: 60,
                      child: new Card(
                        elevation: 2.0, //阴影
                        color: Colors.white, //背景色
                        child: Stack(
                          children: [
                            Container(
                              padding:
                                  EdgeInsets.only(left: 8, top: 3, bottom: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "收藏",
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(
                                    "我收藏的",
                                    style: TextStyle(
                                        fontSize: 12,
                                        color: Color(GlobalColor.SHALLOW_GRAY)),
                                  ),
                                ],
                              ),
                            ),

                            /// 水印
                            Positioned(
                              child: Opacity(
                                  opacity: 0.3, //设置透明度
                                  child: Image.asset(
                                    "images/comm/mypage_tag_collect.jpg",
                                    width: 38,
                                    height: 38,
                                  )),
                              bottom: -5,
                              right: -5,
                            ),
                          ],
                        ),
                      ),
                    ),
                  )),
                ],
              ),
            ),
          ),

          /// 历史查看记录
          GestureDetector(
            onTap: () {
              GlobalLocalCache.getLoginUserId().then((loginUserId) {
                GlobalRouteTable.goUserLookContentHistoryPage(
                    context, loginUserId.toString());
              });
            },
            child: Container(
              padding:
                  EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("查看历史", style: TextStyle(fontSize: 15)),
                  Icon(Icons.chevron_right_outlined),
                ],
              ),
            ),
          ),

          /// 分割线
          Container(
            color: Color(0xfff9fafb),
            height: 6,
          ),
        ],
      ),
    );
  }

  /// ----------- 构建用户信息区域(登录状态) end-----------
  /// ----------- 登录与注册区域(未登录状态) start-----------
  Widget _buildLoginOrRegister() {
    /// 登录与注册区域
    return Container(
      child: Column(
        children: [
          Container(
            color: Color(0xfffffffff),
            padding: EdgeInsets.only(left: 0, top: 5, right: 0, bottom: 5),
            child: Row(
              children: [
                /// 登录与注册
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 6),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "欢迎来到${GlobalConst.APP_NAME}",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 10, bottom: 6),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "弘扬正确价值观",
                          style: TextStyle(
                              fontSize: 15,
                              color: Color(GlobalColor.SHALLOW_GRAY)),
                        ),
                      ),

                      /// 登录与注册按钮
                      Container(
                        padding: EdgeInsets.only(
                          left: 10,
                        ),
                        height: 35,
                        alignment: Alignment.centerLeft,
                        child: CommWidgetBuilder.gradientButton("登录/注册",
                            fontSize: 14, callBack: () {
                          /// 前往登录与注册
                          GlobalRouteTable.goLoginPage(context, () {
                            isLogin();
                          });
                        }),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.bottomRight,
                    child: Image.asset(
                      GlobalFilePath.LOGIN_AREA_BG_IMG,
                      width: 150,
                      height: 150,
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// 分割线
          Container(
            color: Color(0xfff9fafb),
            height: 6,
          ),
        ],
      ),
    );
  }

  /// ----------- 登录与注册区域(未登录状态) end-----------

  /// ----------- 构建用户区域 start-----------
  bool _userAreaFlag = false;

  Widget _buildUserArea() {
    if (_userAreaFlag) {
      return _buildUserInfoArea();
    } else {
      return _buildLoginOrRegister();
    }
  }

  /// ----------- 构建用户区域 end-------------

  /// ----------- 页面构建 start-----------
  Widget _buildPage(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      color: Color(0xfffffffff),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return Container(
              padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 30),
              child: new Column(
                children: [
                  /// 用户区域
                  _buildUserArea(),

                  /// 创作信息
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 20),
                    child: Column(
                      children: [
                        /// 标题
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "创作信息",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),

                        /// 信息显示区域
                        Row(
                          children: [
                            /// 新增查看量
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          left: 30,
                                          right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.trending_up,
                                            color: Color(
                                                GlobalColor.APP_THEME_COLOR),
                                          ),
                                          Text(_userInfoModel.newAddLookCount)
                                        ],
                                      )),
                                  Container(
                                    child: Text("今日新增查看量"),
                                  ),
                                ],
                              ),
                            ),

                            /// 分割线
                            Container(
                              width: 0.2,
                              height: 30,
                              color: Color(GlobalColor.SHALLOW_GRAY),
                            ),

                            /// 新增获赞数
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          left: 30,
                                          right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.trending_up,
                                            color: Color(
                                                GlobalColor.APP_THEME_COLOR),
                                          ),
                                          Text(_userInfoModel.newAddGoodCount)
                                        ],
                                      )),
                                  Container(
                                    child: Text("今日新增获赞数"),
                                  ),
                                ],
                              ),
                            ),

                            /// 分割线
                            Container(
                              width: 0.2,
                              height: 30,
                              color: Color(GlobalColor.SHALLOW_GRAY),
                            ),

                            /// 新增收藏数
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          left: 30,
                                          right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.trending_up,
                                            color: Color(
                                                GlobalColor.APP_THEME_COLOR),
                                          ),
                                          Text(
                                              _userInfoModel.newAddCollectCount)
                                        ],
                                      )),
                                  Container(
                                    child: Text("今日新增收藏数"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// 分割线
                  Container(
                    color: Color(0xfff9fafb),
                    height: 6,
                  ),

                  /// 经营分析
                  Container(
                    padding: EdgeInsets.only(top: 15, bottom: 20),
                    child: Column(
                      children: [
                        /// 标题
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "经营分析",
                                style: TextStyle(fontSize: 16),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                /// 前往用户经营分析页
                                GlobalRouteTable.goUserBusinessAnalysePage(
                                    context);
                              },
                              child: Container(
                                  padding: EdgeInsets.only(right: 15),
                                  child: Row(
                                    children: [
                                      Text(
                                        "查看详情",
                                        style: TextStyle(
                                            color: Color(
                                                GlobalColor.SHALLOW_GRAY)),
                                      ),
                                      SizedBox(
                                        width: 6,
                                      ),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 18,
                                        color: Color(GlobalColor.SHALLOW_GRAY),
                                      ),
                                    ],
                                  )),
                            ),
                          ],
                        ),

                        /// 信息显示区域
                        Row(
                          children: [
                            /// 新增查看量
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          left: 30,
                                          right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.trending_up,
                                            color: Color(
                                                GlobalColor.APP_THEME_COLOR),
                                          ),
                                          Text(_userInfoModel.newAddLookCount)
                                        ],
                                      )),
                                  Container(
                                    child: Text("今日新增查看量"),
                                  ),
                                ],
                              ),
                            ),

                            /// 分割线
                            Container(
                              width: 0.2,
                              height: 30,
                              color: Color(GlobalColor.SHALLOW_GRAY),
                            ),

                            /// 新增获赞数
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          left: 30,
                                          right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.trending_up,
                                            color: Color(
                                                GlobalColor.APP_THEME_COLOR),
                                          ),
                                          Text(_userInfoModel.newAddGoodCount)
                                        ],
                                      )),
                                  Container(
                                    child: Text("今日新增获赞数"),
                                  ),
                                ],
                              ),
                            ),

                            /// 分割线
                            Container(
                              width: 0.2,
                              height: 30,
                              color: Color(GlobalColor.SHALLOW_GRAY),
                            ),

                            /// 新增收藏数
                            Expanded(
                              child: Column(
                                children: [
                                  Container(
                                      padding: EdgeInsets.only(
                                          top: 20,
                                          bottom: 10,
                                          left: 30,
                                          right: 30),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Icon(
                                            Icons.trending_up,
                                            color: Color(
                                                GlobalColor.APP_THEME_COLOR),
                                          ),
                                          Text(
                                              _userInfoModel.newAddCollectCount)
                                        ],
                                      )),
                                  Container(
                                    child: Text("今日新增收藏数"),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  /// 分割线
                  Container(
                    color: Color(0xfff9fafb),
                    height: 6,
                  ),

                  /// 更多功能
                  Container(
                    padding: EdgeInsets.only(top: 15),
                    child: Column(
                      children: [
                        /// 标题
                        Row(
                          children: [
                            Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                "更多功能",
                                style: TextStyle(fontSize: 16),
                              ),
                            )
                          ],
                        ),

                        /// 按钮区域
                        Container(
                          child: Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 25),
                                child: Row(
                                  children: [
                                    /// 购物车
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          /// 跳转到个人购物车页
                                          GlobalRouteTable.goShoppingCartPage(
                                              context, () {});
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Icon(
                                                Icons.shopping_cart_outlined,
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text("购物车"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// 订单
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          /// 跳转到个人订单页
                                          GlobalRouteTable.goUserOrderFormPage(
                                              context, () {});
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Icon(
                                                Icons.assignment_outlined,
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text("订单"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// 支付
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          /// 跳转到个人设置页
                                          GlobalRouteTable.goUserSettingPage(
                                              context);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Icon(
                                                Icons.attach_money,
                                                size: 30,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text("支付"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                  top: 25,
                                ),
                                child: Row(
                                  children: [
                                    /// 设置
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          /// 跳转到个人设置页
                                          GlobalRouteTable.goUserSettingPage(
                                              context);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Icon(
                                                Icons.settings,
                                                size: 28,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text("设置"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// 黑名单
                                    Expanded(
                                      child: GestureDetector(
                                        onTap: () {
                                          /// 跳转到黑名单
                                          GlobalRouteTable.goUserBlackListPage(
                                              context);
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              child: Icon(
                                                FontAwesome.frown_o,
                                                size: 28,
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(top: 8),
                                              child: Text("黑名单"),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    /// 意见反馈
                                    Expanded(
                                        child: Column(
                                      children: [
                                        Container(
                                          child: Icon(
                                            Icons.wysiwyg,
                                            size: 28,
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(top: 8),
                                          child: Text("意见反馈"),
                                        ),
                                      ],
                                    )),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  /// ----------- 页面构建 end-----------
  ///

}
