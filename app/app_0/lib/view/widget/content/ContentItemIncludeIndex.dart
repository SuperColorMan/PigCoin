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

/// --------------------------------------------------------------------------------------------------
/// Des: 构建热门评论以内容条目项的结构生成(含有热评标签),上方是评论内容,下方是被评论的内容,注意:此时该内容结构中必须包含评论信息
/// --------------------------------------------------------------------------------------------------
class ContentItemIncludeIndex extends StatefulWidget {
  Map contentStructure;
  int index;
  Function callBack;

  ContentItemIncludeIndex(this.contentStructure, this.index,
      {Key key, this.callBack})
      : super(key: key);

  @override
  _ContentItemIncludeIndexState createState() {
    return _ContentItemIncludeIndexState();
  }
}

class _ContentItemIncludeIndexState extends State<ContentItemIncludeIndex> {
  @override
  Widget build(BuildContext context) {
    Map contentStructure = widget.contentStructure;

    /// -------------------------- 加入的话题处理 start --------------------------
    List<Widget> _joinGambitList = [];
    List gambitList = contentStructure['joinGambitList'];
    for (Map gambit in gambitList) {
      _joinGambitList.add(ContentJoinGambitTag(gambit));
    }

    /// -------------------------- 加入的话题处理 end --------------------------
    /// -------------------------- 神评论处理 start --------------------------
    List _hCList = contentStructure['hotCommentList'];
    List<Widget> _hotCommentList = [];
    Widget _hotCommentArea = Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 12, right: 2, top: 0, bottom: 0),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        child: Container(
          padding: EdgeInsets.only(top: 10, bottom: 10),
          color: Color(GlobalColor.MAX_SHALLOW_GRAY),
          child: Column(
            children: _hotCommentList,
          ),
        ),
      ),
    );
    if (_hCList != null && _hCList.length > 0) {
      for (Map c in _hCList) {
        _hotCommentList.add(InContentItemHotComment(c));
      }
    } else {
      _hotCommentArea = Container(
        height: 0,
      );
    }

    /// -------------------------- 神评论处理 end --------------------------

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

    /// 是否点赞
    bool isGood = contentStructure['isGood'] != null
        ? (contentStructure['isGood'] as int > 0 ? true : false)
        : false;

    /// 是否点踩
    bool isDiss = contentStructure['isDiss'] != null
        ? (contentStructure['isDiss'] as int > 0 ? true : false)
        : false;

    /// 是否收藏
    bool isColl = contentStructure['isColl'] != null
        ? (contentStructure['isColl'] as int > 0 ? true : false)
        : false;

    /// 是否评论
    bool isComment = contentStructure['isComment'] != null
        ? (contentStructure['isComment'] as int > 0 ? true : false)
        : false;

    /// 互动信息
    Map tcInteractionInfo = contentStructure['tcInteractionInfo'];

    /// 图片显示个数
    int imgShowCount =
        GlobalMatUtils.imgShowCountCal(showGlobalContentList.length);

    return GestureDetector(
      onTap: () {
        /// 页面跳转
        GlobalRouteTable.goShowContentPage(context, contentStructure);
      },
      child: Container(
        color: Colors.white,
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.only(bottom: 10),
        child: Column(children: [
          /// 用户信息
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Expanded(
              child: Row(
                children: [
                  /// 头像
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${userId}&${GlobalDateUtil.getCurrentTimestamp()}',
                      fit: BoxFit.fill,
                      width: 38,
                      height: 38,
                      // color: Colors.black
                    ),
                  ),

                  /// 用户名
                  Container(
                      width: 250,
                      padding: EdgeInsets.only(left: 10),
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
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
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
                  GlobalRouteTable.goUserPage(context,
                      userName: value.toString().substring(1));
                  print("哈哈哈哈哈");
                }
              },
            ),
          ),

          /// 图片
          Container(
            padding: EdgeInsets.only(left: 10),
            child: GlobalImageBuilder.buildContentItemImgShowArea(
                showGlobalContentList, imgShowCount, callBack: () {
              /// 前往图片查看页
              GlobalRouteTable.goShowImagePage(context, showGlobalContentList);
            }),
          ),

          /// 参与的话题区域
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            width: double.infinity,
            margin: EdgeInsets.only(top: 10, bottom: 5),
            child: Wrap(
              alignment: WrapAlignment.start,
              //布局方向
              direction: Axis.horizontal,
              spacing: 10,
              runSpacing: 10,
              children: _joinGambitList,
            ),
          ),

          /// 热门评论显示区域
          _hotCommentArea,

          /// 互动区域
          Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              child: Row(
                children: [
                  /// 点赞按钮
                  Expanded(
                    child: LikeButton(
                      isLiked: isGood,
                      onTap: (bool isLiked) {
                        /// 点赞内容
                        return GlobalLikeButtonCallBack.contentGood(
                            isLiked, contentId.toString(), userId.toString());
                      },
                      countBuilder: (int count, bool isLiked, String text) {
                        var color = isLiked
                            ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
                            : Color(GlobalColor.SHALLOW_GRAY);
                        Widget result;
                        result = Text(
                          text,
                          style: TextStyle(color: color, fontSize: 15),
                        );
                        return result;
                      },
                      likeCount: tcInteractionInfo != null
                          ? tcInteractionInfo['goodCount']
                          : 0,
                      countPostion: CountPostion.bottom,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.thumb_up_alt_outlined,
                          color: isLiked
                              ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
                              : Color(GlobalColor.SHALLOW_GRAY),
                          size: 20,
                        );
                      },
                      circleColor: CircleColor(
                          start: Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                          end: Color(GlobalColor.GOOD_PITCH_ON_COLOR)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor:
                            Color(GlobalColor.GOOD_PITCH_ON_TRAN_COLOR),
                        dotSecondaryColor:
                            Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                      ),
                    ),
                  ),

                  /// 点踩按钮
                  Expanded(
                    child: LikeButton(
                      isLiked: isDiss,
                      onTap: (bool isLiked) {
                        /// 点赞内容
                        return GlobalLikeButtonCallBack.contentDiss(
                            isLiked, contentId.toString(), userId.toString());
                      },
                      countBuilder: (int count, bool isLiked, String text) {
                        var color = isLiked
                            ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
                            : Color(GlobalColor.SHALLOW_GRAY);
                        Widget result;
                        result = Text(
                          text,
                          style: TextStyle(color: color, fontSize: 15),
                        );
                        return result;
                      },
                      likeCount: tcInteractionInfo != null
                          ? tcInteractionInfo['dissCount']
                          : 0,
                      countPostion: CountPostion.bottom,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.thumb_down_alt_outlined,
                          color: isLiked
                              ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
                              : Color(GlobalColor.SHALLOW_GRAY),
                          size: 20,
                        );
                      },
                      circleColor: CircleColor(
                          start: Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                          end: Color(GlobalColor.GOOD_PITCH_ON_COLOR)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor:
                            Color(GlobalColor.GOOD_PITCH_ON_TRAN_COLOR),
                        dotSecondaryColor:
                            Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                      ),
                    ),
                  ),

                  /// 评论
                  Expanded(
                    child: LikeButton(
                      isLiked: isComment,
                      onTap: (bool isLiked) {
                        final Completer<bool> completer = new Completer<bool>();
                        completer.complete(isLiked ? false : true);
                        return completer.future;
                      },
                      countBuilder: (int count, bool isLiked, String text) {
                        var color = isLiked
                            ? Colors.blueAccent
                            : Color(GlobalColor.SHALLOW_GRAY);
                        Widget result;
                        result = Text(
                          text,
                          style: TextStyle(color: color, fontSize: 15),
                        );
                        return result;
                      },
                      likeCount: tcInteractionInfo != null
                          ? tcInteractionInfo['commentCount']
                          : 0,
                      countPostion: CountPostion.bottom,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.chat_bubble_outline,
                          color: isLiked
                              ? Colors.blueAccent
                              : Color(GlobalColor.SHALLOW_GRAY),
                          size: 20,
                        );
                      },
                      circleColor: CircleColor(
                          start: Colors.blueAccent, end: Colors.blue),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Colors.blueAccent,
                        dotSecondaryColor: Colors.blue,
                      ),
                    ),
                  ),

                  /// 收藏
                  Expanded(
                    child: LikeButton(
                      isLiked: isColl,
                      onTap: (bool isLiked) {
                        /// 收藏内容
                        return GlobalLikeButtonCallBack.contentCollect(
                            isLiked, contentId.toString(), userId.toString());
                      },
                      countBuilder: (int count, bool isLiked, String text) {
                        var color = isLiked
                            ? Color(GlobalColor.COLL_PITCH_ON_COLOR)
                            : Color(GlobalColor.SHALLOW_GRAY);
                        Widget result;
                        result = Text(
                          text,
                          style: TextStyle(color: color, fontSize: 15),
                        );
                        return result;
                      },
                      likeCountPadding: EdgeInsets.only(top: 1),
                      likeCount: tcInteractionInfo != null
                          ? tcInteractionInfo['collCount']
                          : 0,
                      countPostion: CountPostion.bottom,
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          Icons.star_border,
                          color: isLiked
                              ? Color(GlobalColor.COLL_PITCH_ON_COLOR)
                              : Color(GlobalColor.SHALLOW_GRAY),
                          size: 24,
                        );
                      },
                      circleColor: CircleColor(
                          start: Color(GlobalColor.COLL_PITCH_ON_COLOR),
                          end: Color(GlobalColor.COLL_PITCH_ON_COLOR)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor:
                            Color(GlobalColor.COLL_PITCH_ON_TRAN_COLOR),
                        dotSecondaryColor:
                            Color(GlobalColor.COLL_PITCH_ON_COLOR),
                      ),
                    ),
                  ),
                ],
              )),
        ]),
      ),
    );
  }
}
