import 'package:flutter/cupertino.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalStyleConst.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';

/// ---------------------------------------------------------------------------------------------
/// Des: 构建评论以内容条目项的结构生成,上方是评论内容,下方是被评论的内容,注意:此时该内容结构中必须包含评论信息
/// ---------------------------------------------------------------------------------------------
class CommentContentItem extends StatefulWidget {
  Map contentStructure;

  CommentContentItem(this.contentStructure, {Key key}) : super(key: key);

  @override
  _CommentContentItemState createState() {
    return _CommentContentItemState();
  }
}

class _CommentContentItemState extends State<CommentContentItem> {
  @override
  Widget build(BuildContext context) {
    Map contentStructure = widget.contentStructure;

    /// 评论信息
    var commentInfo = contentStructure['tcComment'];

    /// 评论id
    String commentId = commentInfo['id'].toString();

    /// 被评论内容中的图片列表
    List<dynamic> contentImgList = contentStructure['imgList'];

    /// 评论内容
    String commentBody = commentInfo['body'];

    /// 发起评论用户信息
    var userInfo = commentInfo['tuUser'];

    /// 被评论内容
    String contentBody = contentStructure['body'];

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

    /// 发起评论内容发送者用户信息
    var contentUserInfo = contentStructure['tuUser'];
    String userId = userInfo['id'].toString();
    String userName = userInfo['name'].toString();
    String byUserId = contentUserInfo['id'].toString();
    String byUserName = contentUserInfo['name'].toString();

    /// 互动信息
    Map tCommInteractionInfo = commentInfo['tcInteractionInfo'];

    /// 首张图片id
    String firstImgId =
        contentImgList.length > 0 ? contentImgList[0]['id'].toString() : "0";
    Widget _byFirstImg = Container();
    if (firstImgId != "0") {
      _byFirstImg = Expanded(
        flex: 2,
        child: Container(
            width: 65,
            child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(4)),
                clipBehavior: Clip.antiAlias,
                child: CachedNetworkImage(
                  imageUrl:
                      GlobalApiUrlTable.GET_CONTENT_IMG + "?id=" + firstImgId,
                  fit: BoxFit.fill,
                  placeholder: (context, url) => BallBeatIndicator(
                      ballColor: Color(GlobalColor.APP_THEME_COLOR)),
                ))),
      );
    }
    return GestureDetector(
      onTap: () {},
      child: Container(
        /// 下边框
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 5, color: Color(GlobalColor.MAX_SHALLOW_GRAY)))),
        padding: EdgeInsets.only(right: 10,bottom: 10),
        margin: EdgeInsets.only(bottom: 0),
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
                          "${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${userId}&${GlobalDateUtil.getCurrentTimestamp()}",
                      fit: BoxFit.fill,
                      width: 38,
                      height: 38,
                      placeholder: (context, url) => BallBeatIndicator(
                          ballColor: Color(GlobalColor.APP_THEME_COLOR)),
                      // color: Colors.black
                    ),
                  ),
                  Container(
                      width: 250,
                      padding: EdgeInsets.only(left: 10),
                      child: Text(
                        "${userName}",
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

          /// 正文
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            child: ExtendedText(
              "${commentBody}",
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

          /// 对方内容区域
          Container(
            height: 80,
            width: double.infinity,
            alignment: Alignment.center,
            padding: EdgeInsets.only(left: 10),
            child: Container(
              height: 65,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 9,
                    child: Container(
                      width: ScreenUtil.getInstance().screenWidth * 0.78,
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(
                          children: <TextSpan>[
                            TextSpan(
                                style: TextStyle(
                                    fontWeight: GlobalStyleConst
                                        .CONTENT_USER_NAME_FONT_WEIGHT,
                                    color: Colors.blueAccent,
                                    fontSize: GlobalStyleConst
                                        .CONTENT_USER_NAME_FONT_SIZE),
                                text: byUserName),
                            TextSpan(
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(GlobalColor.DEEP_GRAY)),
                                text: ' : '),
                            TextSpan(
                                children: [
                                  WidgetSpan(
                                    child: ExtendedText(
                                      '${contentBody}',
                                      textAlign: TextAlign.left,
                                      softWrap: true,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: TextStyle(
                                        fontWeight: GlobalStyleConst
                                            .CONTENT_USER_NAME_FONT_WEIGHT,
                                        fontSize: GlobalStyleConst
                                            .CONTENT_USER_NAME_FONT_SIZE,
                                      ),
                                      specialTextSpanBuilder:
                                          GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
                                      onSpecialTextTap: (dynamic value) {
                                        if (value.toString().startsWith('\$')) {
                                          //以$开头
                                          print("美元");
                                        } else if (value
                                            .toString()
                                            .startsWith('@')) {
                                          //以@开头
                                          GlobalRouteTable.goUserPage(context,
                                              userName: value
                                                  .toString()
                                                  .substring(1));
                                          print("哈哈哈哈哈");
                                        }
                                      },
                                    ),
                                  ),
                                ],
                                style: TextStyle(
                                    fontSize: 16.0,
                                    color: Color(GlobalColor.DEEP_GRAY)),
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () async {
                                    /// 这里做点击事件
                                    print("12123");
                                  }),
                          ],
                        ),
                      ),
                    ),
                  ),
                  _byFirstImg,
                ],
              ),
              //边框设置
              decoration: new BoxDecoration(
                color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                //设置四周圆角 角度
                borderRadius: BorderRadius.all(Radius.circular(4.0)),
                //设置四周边框
                border: new Border.all(
                  width: 1,
//                    color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                  color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                ),
              ),
//              color: Color(GlobalColor.MAX_SHALLOW_GRAY),
            ),
          ),

          /// 互动区域
//          Container(
//              padding: EdgeInsets.only(top: 10, bottom: 10),
//              child: Row(
//                children: [
//                  /// 点赞按钮
//                  Expanded(
//                    child: LikeButton(
//                      isLiked: isGood,
//                      onTap: (bool isLiked) {
//                        /// 点赞评论
//                        return GlobalLikeButtonCallBack.commentGood(
//                            isLiked, commentId, userId.toString());
//                      },
//                      countBuilder: (int count, bool isLiked, String text) {
//                        var color = isLiked
//                            ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
//                            : Color(GlobalColor.SHALLOW_GRAY);
//                        Widget result;
//                        result = Text(
//                          text,
//                          style: TextStyle(color: color, fontSize: 15),
//                        );
//                        return result;
//                      },
//                      likeCount: tCommInteractionInfo != null
//                          ? tCommInteractionInfo['goodCount']
//                          : 0,
//                      countPostion: CountPostion.bottom,
//                      likeBuilder: (bool isLiked) {
//                        return Icon(
//                          Icons.thumb_up_alt_outlined,
//                          color: isLiked
//                              ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
//                              : Color(GlobalColor.SHALLOW_GRAY),
//                          size: 20,
//                        );
//                      },
//                      circleColor: CircleColor(
//                          start: Color(GlobalColor.GOOD_PITCH_ON_COLOR),
//                          end: Color(GlobalColor.GOOD_PITCH_ON_COLOR)),
//                      bubblesColor: BubblesColor(
//                        dotPrimaryColor:
//                            Color(GlobalColor.GOOD_PITCH_ON_TRAN_COLOR),
//                        dotSecondaryColor:
//                            Color(GlobalColor.GOOD_PITCH_ON_COLOR),
//                      ),
//                    ),
//                  ),
//
//                  /// 点踩按钮
//                  Expanded(
//                    child: LikeButton(
//                      isLiked: isDiss,
//                      onTap: (bool isLiked) {
//                        /// 点踩评论
//                        return GlobalLikeButtonCallBack.commentDiss(
//                            isLiked, commentId, userId.toString());
//                      },
//                      countBuilder: (int count, bool isLiked, String text) {
//                        var color = isLiked
//                            ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
//                            : Color(GlobalColor.SHALLOW_GRAY);
//                        Widget result;
//                        result = Text(
//                          text,
//                          style: TextStyle(color: color, fontSize: 15),
//                        );
//                        return result;
//                      },
//                      likeCount: tCommInteractionInfo != null
//                          ? tCommInteractionInfo['dissCount']
//                          : 0,
//                      countPostion: CountPostion.bottom,
//                      likeBuilder: (bool isLiked) {
//                        return Icon(
//                          Icons.thumb_down_alt_outlined,
//                          color: isLiked
//                              ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
//                              : Color(GlobalColor.SHALLOW_GRAY),
//                          size: 20,
//                        );
//                      },
//                      circleColor: CircleColor(
//                          start: Color(GlobalColor.GOOD_PITCH_ON_COLOR),
//                          end: Color(GlobalColor.GOOD_PITCH_ON_COLOR)),
//                      bubblesColor: BubblesColor(
//                        dotPrimaryColor:
//                            Color(GlobalColor.GOOD_PITCH_ON_TRAN_COLOR),
//                        dotSecondaryColor:
//                            Color(GlobalColor.GOOD_PITCH_ON_COLOR),
//                      ),
//                    ),
//                  ),
//
//                  /// 评论
//                  Expanded(
//                    child: LikeButton(
//                      onTap: (bool isLiked) {
//                        final Completer<bool> completer = new Completer<bool>();
//                        completer.complete(isLiked ? false : true);
//                        return completer.future;
//                      },
//                      countBuilder: (int count, bool isLiked, String text) {
//                        var color = isLiked
//                            ? Colors.blueAccent
//                            : Color(GlobalColor.SHALLOW_GRAY);
//                        Widget result;
//                        result = Text(
//                          text,
//                          style: TextStyle(color: color, fontSize: 15),
//                        );
//                        return result;
//                      },
//                      likeCount: tCommInteractionInfo != null
//                          ? tCommInteractionInfo['commentCount']
//                          : 0,
//                      countPostion: CountPostion.bottom,
//                      likeBuilder: (bool isLiked) {
//                        return Icon(
//                          Icons.chat_bubble_outline,
//                          color: isLiked
//                              ? Colors.blueAccent
//                              : Color(GlobalColor.SHALLOW_GRAY),
//                          size: 20,
//                        );
//                      },
//                      circleColor: CircleColor(
//                          start: Colors.blueAccent, end: Colors.blue),
//                      bubblesColor: BubblesColor(
//                        dotPrimaryColor: Colors.blueAccent,
//                        dotSecondaryColor: Colors.blue,
//                      ),
//                    ),
//                  ),
//
//                  /// 收藏
//                  Expanded(
//                    child: LikeButton(
//                      isLiked: isColl,
//                      onTap: (bool isLiked) {
//                        /// 收藏评论
//                        return GlobalLikeButtonCallBack.commentCollect(
//                            isLiked, commentId, userId.toString());
//                      },
//                      countBuilder: (int count, bool isLiked, String text) {
//                        var color = isLiked
//                            ? Color(GlobalColor.COLL_PITCH_ON_COLOR)
//                            : Color(GlobalColor.SHALLOW_GRAY);
//                        Widget result;
//                        result = Text(
//                          text,
//                          style: TextStyle(color: color, fontSize: 15),
//                        );
//                        return result;
//                      },
//                      likeCountPadding: EdgeInsets.only(top: 1),
//                      likeCount: tCommInteractionInfo != null
//                          ? tCommInteractionInfo['collCount']
//                          : 0,
//                      countPostion: CountPostion.bottom,
//                      likeBuilder: (bool isLiked) {
//                        return Icon(
//                          Icons.star_border,
//                          color: isLiked
//                              ? Color(GlobalColor.COLL_PITCH_ON_COLOR)
//                              : Color(GlobalColor.SHALLOW_GRAY),
//                          size: 24,
//                        );
//                      },
//                      circleColor: CircleColor(
//                          start: Color(GlobalColor.COLL_PITCH_ON_COLOR),
//                          end: Color(GlobalColor.COLL_PITCH_ON_COLOR)),
//                      bubblesColor: BubblesColor(
//                        dotPrimaryColor:
//                            Color(GlobalColor.COLL_PITCH_ON_TRAN_COLOR),
//                        dotSecondaryColor:
//                            Color(GlobalColor.COLL_PITCH_ON_COLOR),
//                      ),
//                    ),
//                  ),
//                ],
//              )),
        ]),
      ),
    );
  }
}
