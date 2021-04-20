import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/const/GlobalStyleConst.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalLikeButtonCallBack.dart';
import 'package:xhd_app/view/comm/utils/GlobalMathUtils.dart';
import 'package:xhd_app/view/widget/img/GlobalImageBuilder.dart';
import 'dart:math' as math;

/// -------------------------------
/// Des: 构建内容项中显示的神评论条目
/// -------------------------------
class InContentItemHotComment extends StatefulWidget {
  Map commentStructure;

  InContentItemHotComment(this.commentStructure, {Key key}) : super(key: key);

  @override
  _InContentItemHotCommentState createState() {
    return _InContentItemHotCommentState();
  }
}

class _InContentItemHotCommentState extends State<InContentItemHotComment> {
  @override
  Widget build(BuildContext context) {
    Map commentStructure = widget.commentStructure;

    /// ------------ 参数准备 start ------------
    /// 评论id
    String commentId = commentStructure['id'].toString();

    /// 所属内容id
    String contentId = commentStructure['contentId'].toString();

    /// 评论发送者用户信息
    Map userInfo = commentStructure['tuUser'];

    /// 评论发送者用户id
    String userId = userInfo['id'].toString();

    /// 评论发送者用户名称
    String userName = userInfo['name'];

    /// 评论内容
    String body = commentStructure['body'].toString();

    /// 图片url列表
    /// 图片url列表
    List<Map> _imgInfoList = commentStructure['imgList'].cast<Map>();
    List<String> showContentList = [];
    for (Map m in _imgInfoList) {
      showContentList.add("${GlobalApiUrlTable.GET_COMMENT_IMG}?id=${m['id']}");
    }

    /// 图片显示个数
    int imgShowCount = GlobalMatUtils.imgShowCountCal(showContentList.length);

    /// ------------ 参数准备 end ------------

    return Container(
      child: Stack(
        children: [
          Positioned(
            top: -10,
            right: 80,
            child: Transform.rotate(
                angle: -math.pi / 8,
                child: Opacity(
                  opacity: 0.5, //设置透明度
                  child: Image.asset(
                    GlobalFilePath.HOT_COMMENT_BADGE,
                    fit: BoxFit.fill,
                    width: 80,
                    height: 80,
                  ),
                )),
          ),
          Container(
            color: Colors.transparent,
            child: Column(
              children: [
                /// 用户信息
                Container(
                  padding: EdgeInsets.only(left: 10, right: 0, top: 20),
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
                                    "12341234",
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
                                        return GlobalLikeButtonCallBack
                                            .commentGood(
                                                isLiked, commentId, userId);
                                      },
                                      countBuilder: (int count, bool isLiked,
                                          String text) {
                                        var color = isLiked
                                            ? Color(
                                                GlobalColor.GOOD_PITCH_ON_COLOR)
                                            : Color(GlobalColor.SHALLOW_GRAY);
                                        Widget result;
                                        result = Text(
                                          text,
                                          style: TextStyle(
                                              color: color, fontSize: 15),
                                        );
                                        return result;
                                      },
                                      likeCount: 0,
                                      countPostion: CountPostion.left,
                                      likeBuilder: (bool isLiked) {
                                        return Icon(
                                          Icons.thumb_up_alt_outlined,
                                          color: isLiked
                                              ? Color(GlobalColor
                                                  .GOOD_PITCH_ON_COLOR)
                                              : Color(GlobalColor.SHALLOW_GRAY),
                                          size: 20,
                                        );
                                      },
                                      circleColor: CircleColor(
                                          start: Color(
                                              GlobalColor.GOOD_PITCH_ON_COLOR),
                                          end: Color(
                                              GlobalColor.GOOD_PITCH_ON_COLOR)),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: Color(GlobalColor
                                            .GOOD_PITCH_ON_TRAN_COLOR),
                                        dotSecondaryColor: Color(
                                            GlobalColor.GOOD_PITCH_ON_COLOR),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 15),
                                    child: LikeButton(
                                      onTap: (bool isLiked) {
                                        /// 评论点踩
                                        return GlobalLikeButtonCallBack
                                            .commentDiss(
                                                isLiked, commentId, userId);
                                      },
                                      countBuilder: (int count, bool isLiked,
                                          String text) {
                                        var color = isLiked
                                            ? Color(
                                                GlobalColor.GOOD_PITCH_ON_COLOR)
                                            : Color(GlobalColor.SHALLOW_GRAY);
                                        Widget result;
                                        result = Text(
                                          text,
                                          style: TextStyle(
                                              color: color, fontSize: 15),
                                        );
                                        return result;
                                      },
                                      likeCount: 0,
                                      countPostion: CountPostion.left,
                                      likeBuilder: (bool isLiked) {
                                        return Icon(
                                          Icons.thumb_down_alt_outlined,
                                          color: isLiked
                                              ? Color(GlobalColor
                                                  .GOOD_PITCH_ON_COLOR)
                                              : Color(GlobalColor.SHALLOW_GRAY),
                                          size: 20,
                                        );
                                      },
                                      circleColor: CircleColor(
                                          start: Color(
                                              GlobalColor.GOOD_PITCH_ON_COLOR),
                                          end: Color(
                                              GlobalColor.GOOD_PITCH_ON_COLOR)),
                                      bubblesColor: BubblesColor(
                                        dotPrimaryColor: Color(GlobalColor
                                            .GOOD_PITCH_ON_TRAN_COLOR),
                                        dotSecondaryColor: Color(
                                            GlobalColor.GOOD_PITCH_ON_COLOR),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),

                        //互动区域,点赞或点踩
                      ],
                    ),
                  ),
                ),

                /// 评论内容
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: 10),
                  padding:
                      EdgeInsets.only(left: 10, right: 0, top: 0, bottom: 10),
                  child: ExtendedText(
                    '${body}',
                    style: TextStyle(
                        fontSize: GlobalStyleConst.CONTENT_BODY_FONT_SIZE),
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
                            userName: value.toString().substring(1));
                        print("哈哈哈哈哈");
                      }
                    },
                  ),
                ),

                /// 评论图片区域
                Container(
                  padding: EdgeInsets.only(left: 10, right: 120),
                  child: GlobalImageBuilder.buildContentItemImgShowArea(
                      showContentList, imgShowCount, callBack: () {
                    GlobalRouteTable.goShowImagePage(context, showContentList);
                  }),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
