import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/model/user/UserMessageSettingModel.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';

/// -------------------------------
/// Des: 用户消息设置页
/// -------------------------------

class MessageSettingPage extends StatefulWidget {
  MessageSettingPage({Key key}) : super(key: key);

  @override
  _MessageSettingPageState createState() => _MessageSettingPageState();
}

class _MessageSettingPageState extends State<MessageSettingPage>
    with TickerProviderStateMixin {
  /// 用户通知设置数据模型
  UserMessageSettingModel _userMessageSettingModel;

  /// 操作项上下边距
  double _itemTopAndBottomPadding = 10;

  /// 构建页
  Widget _buildPage() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return new Column(
              children: [

                /// 内容通知区域标题
                Container(
                  child: Text("内容通知"),
                  alignment: Alignment.centerLeft,
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                ),

                /// 内容通知区域
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  color: Colors.white,
                  child: Column(
                    children: [

                      /// 精彩内容推送
                      Container(
                        padding: EdgeInsets.only(
                            top: _itemTopAndBottomPadding,
                            bottom: _itemTopAndBottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("精彩内容推送", style: TextStyle(fontSize: 15)),
                            Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: _userMessageSettingModel
                                    .isHotContentPush,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  setState(() {
                                    _userMessageSettingModel.isHotContentPush =
                                        value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 关注人的更新推送
                      Container(
                        padding: EdgeInsets.only(
                            top: _itemTopAndBottomPadding,
                            bottom: _itemTopAndBottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("关注人的更新推送", style: TextStyle(fontSize: 15)),
                            Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: _userMessageSettingModel
                                    .isAttUserUpdatePush,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  setState(() {
                                    _userMessageSettingModel
                                        .isAttUserUpdatePush =
                                        value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// 互动通知区域标题
                Container(
                  child: Text("内容通知"),
                  alignment: Alignment.centerLeft,
                  padding:
                  EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
                ),

                /// 内容通知区域
                Container(
                  padding: EdgeInsets.only(left: 20, right: 20),
                  color: Colors.white,
                  child: Column(
                    children: [

                      /// 评论
                      Container(
                        padding: EdgeInsets.only(
                            top: _itemTopAndBottomPadding,
                            bottom: _itemTopAndBottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("评论", style: TextStyle(fontSize: 15)),
                            Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: _userMessageSettingModel.isCommentInform,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  setState(() {
                                    _userMessageSettingModel.isCommentInform =
                                        value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 点赞
                      Container(
                        padding: EdgeInsets.only(
                            top: _itemTopAndBottomPadding,
                            bottom: _itemTopAndBottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("点赞", style: TextStyle(fontSize: 15)),
                            Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: _userMessageSettingModel.isGoodInform,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  setState(() {
                                    _userMessageSettingModel.isGoodInform =
                                        value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 关注
                      Container(
                        padding: EdgeInsets.only(
                            top: _itemTopAndBottomPadding,
                            bottom: _itemTopAndBottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("关注", style: TextStyle(fontSize: 15)),
                            Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: _userMessageSettingModel.isAttInform,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  setState(() {
                                    _userMessageSettingModel.isAttInform =
                                        value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// @
                      Container(
                        padding: EdgeInsets.only(
                            top: _itemTopAndBottomPadding,
                            bottom: _itemTopAndBottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("@", style: TextStyle(fontSize: 15)),
                            Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: _userMessageSettingModel.isAtInform,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  setState(() {
                                    _userMessageSettingModel.isAtInform = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// 私信
                      Container(
                        padding: EdgeInsets.only(
                            top: _itemTopAndBottomPadding,
                            bottom: _itemTopAndBottomPadding),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("私信", style: TextStyle(fontSize: 15)),
                            Transform.scale(
                              scale: 1.2,
                              child: Switch(
                                value: _userMessageSettingModel.isChatInform,
                                activeColor: Colors.red,
                                onChanged: (value) {
                                  setState(() {
                                    _userMessageSettingModel.isChatInform =
                                        value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// -------------------------- 用户通知设置数据模型初始化 --------------------------
    _userMessageSettingModel = new UserMessageSettingModel();

    /// -------------------------------------------------------------------------
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff9fafb),
        appBar: PreferredSize(
            child: AppBar(
              title: Text(
                '通知设置',
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
              actions: [
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(top: 8, bottom: 8, right: 10),
                    child: SizedBox(
                      width: 70,
                      child: RaisedButton(
                        color: Color(GlobalColor.APP_THEME_COLOR),
                        onPressed: () {
                          print('保存');
                          Map _editUserSettingMap = Map();
                          /// 是否推送热门内容,0:否,1:是
                          if (_userMessageSettingModel.isHotContentPush) {
                            _editUserSettingMap['isHotContentPush']='1';
                          } else {
                            _editUserSettingMap['isHotContentPush']='0';
                          }
                          /// 是否推送关注的人更新的内容,0:否,1:是
                          if (_userMessageSettingModel.isAttUserUpdatePush) {
                            _editUserSettingMap['isAttUserUpdatePush']='1';
                          } else {
                            _editUserSettingMap['isAttUserUpdatePush']='0';
                          }
                          /// 评论是否通知,0:否,1:是
                          if (_userMessageSettingModel.isCommentInform) {
                            _editUserSettingMap['isCommentInform']='1';
                          } else {
                            _editUserSettingMap['isCommentInform']='0';
                          }
                          ///  点赞是否通知,0:否,1:是
                          if (_userMessageSettingModel.isGoodInform) {
                            _editUserSettingMap['isGoodInform']='1';
                          } else {
                            _editUserSettingMap['isGoodInform']='0';
                          }
                          /// 关注该用户是否通知,0:否,1:是
                          if (_userMessageSettingModel.isAttInform) {
                            _editUserSettingMap['isAttInform']='1';
                          } else {
                            _editUserSettingMap['isAttInform']='0';
                          }
                          /// @该用户是否通知,0:否,1:是
                          if (_userMessageSettingModel.isAtInform) {
                            _editUserSettingMap['isAtInform']='1';
                          } else {
                            _editUserSettingMap['isAtInform']='0';
                          }
                          /// 私信是否通知,0:否,1:是
                          if (_userMessageSettingModel.isChatInform) {
                            _editUserSettingMap['isChatInform']='1';
                          } else {
                            _editUserSettingMap['isChatInform']='0';
                          }
                          GlobalLocalCache.getLoginUserId().then((loginUserId){
                            _editUserSettingMap['userId']=loginUserId.toString();
                            GlobalConst.NET_API_CALL.editUserSetting(_editUserSettingMap).then((value){
                              if(value['code']==0){
                                /// 缓存用户设置信息
                                GlobalLocalCache.cacheLoginUserSetting(_editUserSettingMap);
                                GlobalToast.showToast("设置成功");
                              }else{
                                GlobalToast.showToast("设置失败");
                              }
                            });
                          });
                        },
                        child: Text(
                          '保存',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),

                        ///圆角
                        shape: RoundedRectangleBorder(
                            side: BorderSide.none,
                            borderRadius: BorderRadius.all(Radius.circular(5))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            preferredSize: Size.fromHeight(50)),
        body: _buildPage());
  }
}
