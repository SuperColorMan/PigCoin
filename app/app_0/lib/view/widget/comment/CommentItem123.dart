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
import 'package:xhd_app/view/comm/utils/GlobalLikeButtonCallBack.dart';
import 'package:xhd_app/view/comm/utils/GlobalMathUtils.dart';
import 'package:xhd_app/view/widget/comm/GlobalReplyBox.dart';
import 'package:xhd_app/view/widget/img/GlobalImageBuilder.dart';
import 'package:xhd_app/view/widget/reply/AuthorReplyItem.dart';

/// -------------------------------
/// Des: 评论项组件,已废弃
/// -------------------------------
class CommentItem123 extends StatefulWidget {
  Map commentStructure;
  Function callBack;

  CommentItem123(this.commentStructure, {Key key, this.callBack})
      : super(key: key);

  @override
  _CommentItem123State createState() {
    return _CommentItem123State();
  }
}

class _CommentItem123State extends State<CommentItem123> {
  @override
  Widget build(BuildContext context) {
    Map commentStructure = widget.commentStructure;

    /// ------------ 参数准备 start ------------
    /// 评论id
    String commentId = commentStructure['id'].toString();

    /// 互动信息
    Map tCommInteractionInfo = commentStructure['tcInteractionInfo'];

    /// 所属内容id
    String contentId = commentStructure['contentId'].toString();

    /// 评论发送者用户信息
    Map userInfo = commentStructure['tuUser'];

    /// 评论发送者用户id
    String userId = userInfo['id'].toString();

    /// 评论发送者用户名称
    String userName = userInfo['name'];

    /// 评论内容
    String body = commentStructure['body'];

    /// 图片url列表
    /// 图片url列表
    List<Map> _imgInfoList = commentStructure['imgList'].cast<Map>();
    List<String> showContentList = [];
    for (Map m in _imgInfoList) {
      showContentList.add("${GlobalApiUrlTable.GET_COMMENT_IMG}?id=${m['id']}");
    }

    /// 神回复列表
    List<Map> hotReplyList = commentStructure['hotReplyList'].cast<Map>();
    print("神回复列表----${hotReplyList.toString()}");

    /// 作者回复列表
    List<Map> authorReplyList = commentStructure['authorReplyList'].cast<Map>();
    List<Widget> _authorReplyWidgetList = [];

    /// ------------ 作者回复区域 start ------------
    Widget _authorReplyArea = Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.only(left: 60, right: 15, top: 10, bottom: 10),
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(4),
          topRight: Radius.circular(4),
          bottomLeft: Radius.circular(4),
          bottomRight: Radius.circular(4),
        ),
        child: Container(
          color: Color(GlobalColor.MAX_SHALLOW_GRAY),
          padding: EdgeInsets.only(top: 10, bottom: 10),
          child: Column(
            children: _authorReplyWidgetList,
          ),
        ),
      ),
    );
    if (authorReplyList != null && authorReplyList.length > 0) {
      for (Map m in authorReplyList) {
        _authorReplyWidgetList.add(AuthorReplyItem(m));
      }
    } else {
      _authorReplyArea = Container(
        height: 0,
      );
    }

    /// ------------ 作者回复区域 end ------------

    /// ------------ 参数准备 end ------------

    /// 图片显示个数
    int imgShowCount = GlobalMatUtils.imgShowCountCal(showContentList.length);
    return Container(
      color: Colors.transparent,
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
                          imageUrl:
                              'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1056629638,148331236&fm=26&gp=0.jpg',
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
                            width: double.infinity,
                            child: Text(
                              "${userName}",
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
                            ),
                          ),

                          /// 发送时间
                          Container(
                            width: double.infinity,
                            child: Text(
                              "2020-12-12",
                              textAlign: TextAlign.left,
                              softWrap: true,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: TextStyle(
                                color: new Color(0xffa6a7a8),
                                fontSize: 15,
                              ),
                            ),
                          ),
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
                                  /// 评论点赞
                                  return GlobalLikeButtonCallBack.commentGood(
                                      isLiked, commentId, userId);
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
                                  /// 评论点踩
                                  return GlobalLikeButtonCallBack.commentDiss(
                                      isLiked, commentId, userId);
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

                  /// 作者回复区域
                  _authorReplyArea,
                ],
              ),
            ),
          ),

          /// 评论内容
          Container(
            width: double.infinity,
            margin: EdgeInsets.only(top: 10),
            padding: EdgeInsets.only(left: 60, right: 10, top: 0, bottom: 10),
            child: ExtendedText(
              '${body}',
              textAlign: TextAlign.left,
              style:
                  TextStyle(fontSize: GlobalStyleConst.CONTENT_BODY_FONT_SIZE),
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

          /// 评论图片区域
          Container(
            padding: EdgeInsets.only(left: 50, right: 10),
            child: GlobalImageBuilder.buildContentItemImgShowArea(
                showContentList, imgShowCount, callBack: () {
              GlobalRouteTable.goShowImagePage(context, showContentList);
            }),
          ),

          /// 回复区域
          Container(
            margin: EdgeInsets.only(top: 5),
            alignment: Alignment.centerLeft,
            child: GestureDetector(
              onTap: () {
                GlobalReplyBox.openReplyArea(context, commentStructure);
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
                  color: new Color(0xfff4f5f6),
                  //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                  borderRadius: BorderRadius.all(Radius.circular(25.0)),
                  //设置四周边框
                  border:
                      new Border.all(width: 1, color: new Color(0xfff4f5f6)),
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

          /// 热门回复区域
        ],
      ),
    );
  }
}
