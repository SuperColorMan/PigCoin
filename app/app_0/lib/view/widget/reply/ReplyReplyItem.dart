import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
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
import 'package:xhd_app/view/widget/img/GlobalImageBuilder.dart';

/// -------------------------------
/// Des: 回复评论项
/// -------------------------------

class ReplyReplyItem extends StatefulWidget {
  Map replyStructure;
  Function callBack;

  ReplyReplyItem(this.replyStructure, {Key key, this.callBack})
      : super(key: key);

  @override
  _ReplyReplyItemState createState() {
    return _ReplyReplyItemState();
  }
}

class _ReplyReplyItemState extends State<ReplyReplyItem> {
  @override
  Widget build(BuildContext context) {
    Map replyStructure = widget.replyStructure;

    /// 回复条目id
    String _replyId = replyStructure['id'].toString();

    /// 所属评论id
    String _commentId = replyStructure['commentId'].toString();

    /// 所属内容id
    String _contentId = replyStructure['contentId'].toString();

    /// 回复正文
    String _replyBody = replyStructure['body'].toString();

    /// 发起回复的用户信息
    Map _userInfo = replyStructure['userInfo'];

    /// 发起回复的用户名称
    String _userName = _userInfo['name'].toString();

    /// 发起回复的用户id
    String _userId = _userInfo['id'].toString();

    /// 发起回复的用户头像
    String _userHeadImg =
        '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}';

    /// 回复发生的内容
    Map _tcContent = replyStructure['tcContent'];

    /// 被回复的用户信息
    Map _byUserInfo = replyStructure['byUserInfo'];

    /// 被回复的用户名称
    String _byUserName = _userInfo['name'].toString();

    /// 被回复的用户id
    String _byUserId = _userInfo['id'].toString();

    /// 被回复的用户头像
    String _byUserHeadImg =
        '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_byUserId}&${GlobalDateUtil.getCurrentTimestamp()}';

    /// 对方回复的内容
    Map _byReply = replyStructure['byTcReply'];

    /// 对方回复正文
    String _byReplyBody = _byReply['body'].toString();

    /// 对方回复中出现图片

    /// 回复时间
    String _replyTime = replyStructure['createTime'].toString();

    /// --------------- 显示的图片处理 start ---------------
    List imgList = replyStructure['imgList'];
    List byImgList = _byReply['imgList'];

    /// 图片url列表
    List<String> replyShowImg = [];
    for (Map m in imgList) {
      replyShowImg.add('${GlobalApiUrlTable.GET_REPLY_IMG}?id=${m['id']}');
    }
    List<String> byReplyShowImg = [];
    for (Map m in byImgList) {
      byReplyShowImg.add('${GlobalApiUrlTable.GET_REPLY_IMG}?id=${m['id']}');
    }

    /// 回复内容图片显示个数
    int replyShowImgCount = GlobalMatUtils.imgShowCountCal(replyShowImg.length);

    /// 对方回复内容图片显示个数
    int byReplyShowImgCount =
        GlobalMatUtils.imgShowCountCal(byReplyShowImg.length);

    /// --------------- 显示的图片处理 end ---------------

    /// ------------ 用户名区域 start ------------
    List<Widget> userNameArea = [
      /// 用户名
      Container(
        constraints: BoxConstraints(
            maxWidth: ScreenUtil.getInstance().screenWidth * 0.25),
        child: Text(
          "${_userName}",
          textAlign: TextAlign.start,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(
            color: Colors.black,
            fontSize: GlobalStyleConst.CONTENT_USER_NAME_FONT_SIZE,
            fontWeight: GlobalStyleConst.CONTENT_USER_NAME_FONT_WEIGHT,
          ),
        ),
      ),
    ];
    if (_tcContent['userId'].toString() == _userId) {
      /// 添加作者标识符
      userNameArea.add(ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(0.5),
          topRight: Radius.circular(0.5),
          bottomLeft: Radius.circular(0.5),
          bottomRight: Radius.circular(0.5),
        ),
        child: Container(
          child: Text(
            "作者",
            style: TextStyle(color: Colors.white),
          ),
          padding: EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
          margin: EdgeInsets.only(left: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
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
                  Color(GlobalColor.APP_THEME_COLOR),
                  Color(GlobalColor.APP_THEME_COLOR_IS_STATUS)
                ]),
          ),
        ),
      ));
    }

    /// ------------ 用户名区域 end ------------

    /// ------------ 对方用户名作者标识符区域 start ------------
    Widget byAuthor = Container();
    if (_tcContent['userId'].toString() == _byUserId) {
      /// 添加作者标识符
      byAuthor = Container(
        child: Text(
          "作者",
          style: TextStyle(color: Colors.white),
        ),
        padding: EdgeInsets.only(left: 5, right: 5, top: 1, bottom: 1),
        margin: EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          gradient: LinearGradient(
              //渐变位置
              begin: Alignment.topRight,
              //右上
              end: Alignment.bottomLeft,
              //左下
              stops: [
                0.0,
                1.0
              ],
              //[渐变起始点, 渐变结束点]
              //渐变颜色[始点颜色, 结束颜色]
              colors: [
                Color(GlobalColor.APP_THEME_COLOR),
                Color(GlobalColor.APP_THEME_COLOR_IS_STATUS)
              ]),
        ),
      );
    }

    /// ------------ 对方用户名作者标识符区域 end ------------

    return Container(
      child: Column(
        children: [
          /// 用户信息
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 20),
            child: Expanded(
              child: Row(
                children: [
                  /// 头像
                  Expanded(
                    flex: 2,
                    child: Center(
                      child: ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: _userHeadImg,
                          fit: BoxFit.fill,
                          width: 35,
                          height: 35,
                          // color: Colors.black
                        ),
                      ),
                    ),
                  ),

                  /// 用户名称区域
                  Expanded(
                      flex: 7,
                      child: Column(
                        children: [
                          /// 用户名
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: userNameArea,
                            ),
                          ),

                          /// 分割线
                          SizedBox(
                            height: 5,
                          ),
                          Row(children: [
                            Container(
                              margin: EdgeInsets.only(top: 5),
                              child: Text(
                                _replyTime,
                                textAlign: TextAlign.left,
                                softWrap: true,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            )
                          ]),
                        ],
                      )),

                  /// 互动区域
                  Expanded(
                    flex: 7,
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 2),
                              child: LikeButton(
                                onTap: (bool isLiked) {
                                  /// 回复点赞
                                  return GlobalLikeButtonCallBack.replyGood(
                                      isLiked, _replyId, _userId);
                                },
                                countBuilder:
                                    (int count, bool isLiked, String text) {
                                  var color = isLiked
                                      ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
                                      : Color(GlobalColor.SHALLOW_GRAY);
                                  Widget result;
                                  result = Text(
                                    text,
                                    style:
                                        TextStyle(color: color, fontSize: 15),
                                  );
                                  return result;
                                },
                                likeCount: 0,
                                countPostion: CountPostion.left,
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
                                    start:
                                        Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                                    end:
                                        Color(GlobalColor.GOOD_PITCH_ON_COLOR)),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: Color(
                                      GlobalColor.GOOD_PITCH_ON_TRAN_COLOR),
                                  dotSecondaryColor:
                                      Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 15),
                              child: LikeButton(
                                onTap: (bool isLiked) {
                                  /// 回复点赞
                                  return GlobalLikeButtonCallBack.replyDiss(
                                      isLiked, _replyId, _userId);
                                },
                                countBuilder:
                                    (int count, bool isLiked, String text) {
                                  var color = isLiked
                                      ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
                                      : Color(GlobalColor.SHALLOW_GRAY);
                                  Widget result;
                                  result = Text(
                                    text,
                                    style:
                                        TextStyle(color: color, fontSize: 15),
                                  );
                                  return result;
                                },
                                likeCount: 0,
                                countPostion: CountPostion.left,
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
                                    start:
                                        Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                                    end:
                                        Color(GlobalColor.GOOD_PITCH_ON_COLOR)),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: Color(
                                      GlobalColor.GOOD_PITCH_ON_TRAN_COLOR),
                                  dotSecondaryColor:
                                      Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// 回复内容
          Container(
            alignment: Alignment.centerLeft,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 60, right: 10, top: 0, bottom: 10),
            child: ExtendedText(
              '${_replyBody}',
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

          /// 回复图片区域
          Container(
            padding: EdgeInsets.only(left: 50, right: 10),
            child: GlobalImageBuilder.buildContentItemImgShowArea(
                replyShowImg, replyShowImgCount),
          ),

          /// 对方回复内容
          Container(
            decoration: new BoxDecoration(
              border: new Border(
                  left: BorderSide(
                      color: Color(GlobalColor.MEDIUM_SHALLOW_GRAY),
                      width: 2)), // 边色与边宽度
            ),
            padding: EdgeInsets.only(left: 10, top: 5, bottom: 5),
            margin: EdgeInsets.only(
              left: 60,
              right: 20,
              bottom: 10,
              top: 10,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// 对方用户名称与回复内容
                RichText(
                  textAlign: TextAlign.left,
                  text: TextSpan(
                    children: <InlineSpan>[
                      TextSpan(
                          style: TextStyle(
                              fontWeight: GlobalStyleConst
                                  .CONTENT_USER_NAME_FONT_WEIGHT,
                              color: Colors.blueAccent,
                              fontSize:
                                  GlobalStyleConst.CONTENT_USER_NAME_FONT_SIZE),
                          text: '${_byUserName} : '),
                      WidgetSpan(
                        alignment: PlaceholderAlignment.middle,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(0.5),
                            topRight: Radius.circular(0.5),
                            bottomLeft: Radius.circular(0.5),
                            bottomRight: Radius.circular(0.5),
                          ),
                          child: byAuthor,
                        ),
                      ),
                      TextSpan(
                          children: [
                            WidgetSpan(
                              child: ExtendedText(
                                '${_byReplyBody}',
                                style: TextStyle(
                                    fontSize: GlobalStyleConst
                                        .CONTENT_BODY_FONT_SIZE),
                                textAlign: TextAlign.left,
                                specialTextSpanBuilder:
                                    GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
                                onSpecialTextTap: (dynamic value) {
                                  if (value.toString().startsWith('\$')) {
                                    //以$开头
                                    print("美元");
                                  } else if (value.toString().startsWith('@')) {
                                    //以@开头
                                    GlobalRouteTable.goUserPage(context,
                                        userName:
                                            value.toString().substring(1));
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

                /// 对方回复图片区域
                Container(
                  margin: EdgeInsets.only(
                    top: 10,
                  ),
                  child: GlobalImageBuilder.buildContentItemImgShowArea(
                      byReplyShowImg, byReplyShowImgCount),
                ),
              ],
            ),
          ),

          /// 回复区域
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                /// 执行回调
                widget.callBack();
              },
              child: Container(
                margin: EdgeInsets.only(left: 55),
                //设置 child 居中
                alignment: Alignment(0, 0),
                height: 25,
                width: 60,
                //边框设置
                decoration: new BoxDecoration(
                  //背景
                  color: new Color(GlobalColor.MAX_SHALLOW_GRAY),
                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //设置四周边框
                  border: new Border.all(
                      width: 1, color: new Color(GlobalColor.MAX_SHALLOW_GRAY)),
                ),
                child: Text(
                  "回复",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
