import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalStyleConst.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';
import 'package:xhd_app/view/comm/utils/GlobalLikeButtonCallBack.dart';
import 'package:xhd_app/view/comm/utils/GlobalMathUtils.dart';
import 'package:xhd_app/view/widget/comment/InContentItemHotComment.dart';
import 'package:xhd_app/view/widget/gambit/ContentJoinGambitTag.dart';
import 'package:xhd_app/view/widget/img/GlobalImageBuilder.dart';


/// -------------------------------
/// Des: 系统内容项组件
/// -------------------------------
class SysContentItem extends StatefulWidget {
  Map contentStructure;

  SysContentItem(
      this.contentStructure, {
        Key key,
      }) : super(key: key);

  @override
  _SysContentItemState createState() {
    return _SysContentItemState();
  }
}

class _SysContentItemState extends State<SysContentItem> {
  Map contentStructure;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("内容组件化。。。");
    setState(() {
      this.contentStructure = widget.contentStructure;
    });
  }

  @override
  Widget build(BuildContext context) {
    /// -------------------------- 加入的话题处理 start --------------------------
    List<Widget> _joinGambitList = [];
    List gambitList = contentStructure['joinGambitList'];
    for (Map gambit in gambitList) {
      _joinGambitList
          .add(ContentJoinGambitTag(gambit));
    }

    /// -------------------------- 加入的话题处理 end --------------------------

    /// 内容id
    num contentId = contentStructure['id'];

    /// 用户信息
    Map userInfo = contentStructure['tuUser'] as Map;

    /// 内容包含图片列表
    List<dynamic> imgList = contentStructure['imgList'] as List<dynamic>;

    /// 图片url列表
    List<String> showGlobalContentList = [];
    for (Map m in imgList) {
      /// 添加内容的图片显示猎
      num imgId = m['id'];
      showGlobalContentList
          .add('${GlobalApiUrlTable.GET_CONTENT_IMG}?id=${imgId}');
    }

    /// 用户id
    num userId = userInfo['id'];

    /// 用户名
    String userName = userInfo['name'];

    /// 内容正文
    String body = contentStructure['body'];

    /// 图片显示个数
    int imgShowCount =
    GlobalMatUtils.imgShowCountCal(showGlobalContentList.length);

    return GestureDetector(
      onTap: () {
        /// 页面跳转
        GlobalRouteTable.goShowContentPage(context, contentStructure);
      },
      child: Container(
        /// 下边框
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 2, color: Color(GlobalColor.MAX_SHALLOW_GRAY)))),
        padding: EdgeInsets.only(bottom: 15),
        margin: EdgeInsets.only(bottom: 10),
        child: Column(children: [
          /// 用户信息
          Container(
            padding: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
            child: Expanded(
              child: Row(
                children: [
                  /// 头像
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                      '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${userId}&${GlobalDateUtil.getCurrentTimestamp()}',
                      fit: BoxFit.fill,
                      width: 50,
                      height: 50,
                      // color: Colors.black
                    ),
                  ),

                  /// 用户名
                  Container(
                      width: 250,
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        userName,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight:
                          GlobalStyleConst.CONTENT_USER_NAME_FONT_WEIGHT,
                          fontSize:
                          GlobalStyleConst.CONTENT_USER_NAME_FONT_SIZE,
                        ),
                      )),
                ],
              ),
            ),
          ),

          /// 内容正文
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 20, right: 10, top: 0, bottom: 10),
            child: ExtendedText(
              body,
              style:
              TextStyle(fontSize: GlobalStyleConst.CONTENT_BODY_FONT_SIZE),
              textAlign: TextAlign.left,
              specialTextSpanBuilder: GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
              onSpecialTextTap: (dynamic value) {
                if (value.toString().startsWith('\$')) {
                  //以$开头
                  print("美元");
                } else if (value.toString().startsWith('@')) {
                  //以@开头
                  GlobalRouteTable.goUserPage(
                      context,userName: value.toString().substring(1));
                  print("哈哈哈哈哈");
                }
              },
            ),
          ),

          /// 图片
          Container(
            padding: EdgeInsets.only(left: 20,right: 20),
            child: GlobalImageBuilder.buildContentItemImgShowArea(
                showGlobalContentList, imgShowCount, callBack: () {
              /// 前往图片查看页
              GlobalRouteTable.goShowImagePage(context, showGlobalContentList);
            }),
          ),

        ]),
      ),
    );
  }
}
