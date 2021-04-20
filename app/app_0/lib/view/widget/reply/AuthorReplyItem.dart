import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalStyleConst.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/img/GlobalImageBuilder.dart';

/// -------------------------------
/// Des: 构建作者回复评论项
/// -------------------------------
import 'package:flutter/cupertino.dart';

class AuthorReplyItem extends StatefulWidget {
  Map replyStructure;
  Function callBack;
  AuthorReplyItem(this.replyStructure, {Key key,this.callBack}) : super(key: key);

  @override
  _AuthorReplyItemState createState() {
    return _AuthorReplyItemState();
  }
}

class _AuthorReplyItemState extends State<AuthorReplyItem> {
  @override
  Widget build(BuildContext context) {
    Map replyStructure = widget.replyStructure;
    /// 所属内容id
    String contentId = replyStructure['contentId'].toString();

    /// 互动信息
    Map tCommInteractionInfo = replyStructure['tcInteractionInfo'];

    /// 所属评论id
    String commentId = replyStructure['commentId'].toString();

    /// 回复id
    String replyId = replyStructure['id'].toString();

    /// 回复正文
    String replyBody = replyStructure['body'].toString();

    /// 用户信息
    Map userInfo = replyStructure['userInfo'];

    /// 用户id
    String userId = userInfo['id'].toString();

    /// 用户名
    String userName = userInfo['name'].toString();

    /// 回复图片列表
    List<Map> replyShowImg = replyStructure['imgList'].cast<Map>();
    print("回复图片列表---${replyShowImg}");
    List<String> imgList = [];
    for (Map m in replyShowImg) {
      /// 添加内容的图片显示猎
      num imgId = m['id'];
      imgList.add('${GlobalApiUrlTable.GET_REPLY_IMG}?id=${imgId}');
    }

    return Container(
      padding: EdgeInsets.only(top: 5, bottom: 5),
      alignment: Alignment.centerLeft,
      child: Column(
        children: [
          /// 内容区域
          Container(
            padding: EdgeInsets.only(left: 12, right: 10),
            child: Container(
              alignment: Alignment.centerLeft,
              child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(
                  children: <InlineSpan>[
                    TextSpan(
                        text: "${userName}",
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize:
                          GlobalStyleConst.CONTENT_USER_NAME_FONT_SIZE,
                          fontWeight:
                          GlobalStyleConst.CONTENT_USER_NAME_FONT_WEIGHT,
                        )),
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: ClipRRect(
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
                          padding: EdgeInsets.only(
                              left: 5, right: 5, top: 1, bottom: 1),
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
                      ),
                    ),
                    TextSpan(
                      text: " : ",
                      style: TextStyle(color: Color(GlobalColor.SHALLOW_GRAY)),
                    ),
                    TextSpan(
                        text: "${replyBody}",
                        style: TextStyle(
                            fontSize: GlobalStyleConst.CONTENT_BODY_FONT_SIZE,
                            color: Colors.black87),
                        recognizer: TapGestureRecognizer()
                          ..onTap = () async {}),
                  ],
                ),
              ),
            ),
          ),

          /// 图片区域
          Container(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: GlobalImageBuilder.buildContentItemImgShowArea(imgList, 3),
          ),
        ],
      ),
    );
  }
}
