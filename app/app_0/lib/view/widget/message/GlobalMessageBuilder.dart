import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

/// -------------------------------
/// Des: 全局消息条目结构构建器
/// -------------------------------

class GlobalMessageBuilder {
  /// 系统通知
  static Widget buildSystemMessage() {
    return Slidable(
      key: Key("1"),
      dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(), onDismissed: (actionType) {}),
      actionPane: SlidableScrollActionPane(),
      //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            /// 头像
            Expanded(
                flex: 2,
                child: Center(
                  child: ClipOval(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            //渐变位置
                            begin: Alignment.topRight, //右上
                            end: Alignment.bottomLeft, //左下
                            stops: [
                              0.0,
                              1.0
                            ], //[渐变起始点, 渐变结束点]
                            //渐变颜色[始点颜色, 结束颜色]
                            colors: [
                              Color(0xfff8aa3e),
                              Color(0xfff8a83a),
                            ]),
                        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        //设置四周边框
                        border:
                            new Border.all(width: 1, color: Color(0xfff8aa3e)),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesome.bell,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )),

            ///用户信息
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    ///用户名
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 用户名
                          Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  '系统消息',
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              )),

                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Text("昨天",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: new Color(0xffa6a7a8),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    /// 关注标记
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(right: 0),
                        child: Text(
                          "关注了你",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        //右侧按钮列表
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: false,
          onTap: () {},
        ),
      ],
    );
  }

  /// 推送消息
  static Widget buildPushMessage() {
    return Slidable(
      key: Key("1"),
      dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(), onDismissed: (actionType) {}),
      actionPane: SlidableScrollActionPane(),
      //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            /// 头像
            Expanded(
                flex: 2,
                child: Center(
                  child: ClipOval(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            //渐变位置
                            begin: Alignment.topRight, //右上
                            end: Alignment.bottomLeft, //左下
                            stops: [
                              0.0,
                              1.0
                            ], //[渐变起始点, 渐变结束点]
                            //渐变颜色[始点颜色, 结束颜色]
                            colors: [
                              Color(0xfff85a68),
                              Color(0xfff85462),
                            ]),
                        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        //设置四周边框
                        border:
                            new Border.all(width: 1, color: Color(0xfff85a68)),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesome.bullhorn,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )),

            ///用户信息
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    ///用户名
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 用户名
                          Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  '系统消息',
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              )),

                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Text("昨天",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: new Color(0xffa6a7a8),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    /// 关注标记
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(right: 0),
                        child: Text(
                          "关注了你",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        //右侧按钮列表
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: false,
          onTap: () {},
        ),
      ],
    );
  }

  /// 客服消息
  static Widget buildServiceMessage() {
    return Slidable(
      key: Key("1"),
      dismissal: SlidableDismissal(
          child: SlidableDrawerDismissal(), onDismissed: (actionType) {}),
      actionPane: SlidableScrollActionPane(),
      //滑出选项的面板 动画
      actionExtentRatio: 0.25,
      child: Container(
        margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
        child: Row(
          children: [
            /// 头像
            Expanded(
                flex: 2,
                child: Center(
                  child: ClipOval(
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: new BoxDecoration(
                        gradient: LinearGradient(
                            //渐变位置
                            begin: Alignment.topRight, //右上
                            end: Alignment.bottomLeft, //左下
                            stops: [
                              0.0,
                              1.0
                            ], //[渐变起始点, 渐变结束点]
                            //渐变颜色[始点颜色, 结束颜色]
                            colors: [
                              Color(0xfffc654e),
                              Color(0xfffc5036),
                            ]),
                        //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                        borderRadius: BorderRadius.all(Radius.circular(25.0)),
                        //设置四周边框
                        border:
                            new Border.all(width: 1, color: Color(0xfffc654e)),
                      ),
                      child: Center(
                        child: Icon(
                          FontAwesome.headphones,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                )),

            ///用户信息
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    ///用户名
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          /// 用户名
                          Expanded(
                              flex: 5,
                              child: Container(
                                padding: EdgeInsets.only(right: 10),
                                child: Text(
                                  '系统消息',
                                  textAlign: TextAlign.left,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 16,
                                    color: Colors.black,
                                  ),
                                ),
                              )),

                          Expanded(
                            flex: 2,
                            child: Container(
                              margin: EdgeInsets.only(left: 5),
                              child: Row(
                                children: [
                                  Text("昨天",
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: new Color(0xffa6a7a8),
                                      )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),

                    /// 关注标记
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(right: 0),
                        child: Text(
                          "关注了你",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        )),
                  ],
                )),
          ],
        ),
      ),
      secondaryActions: <Widget>[
        //右侧按钮列表
        IconSlideAction(
          caption: '删除',
          color: Colors.red,
          icon: Icons.delete,
          closeOnTap: false,
          onTap: () {},
        ),
      ],
    );
  }
}
