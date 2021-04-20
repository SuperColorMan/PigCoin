import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/enums/GlobalChatContentTypeEnum.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';

/// -------------------------------
/// Des: 对方私信条目
/// -------------------------------
class ByChatItem extends StatefulWidget {
  /// 私信内容类型
  int type;

  /// 纯文字内容
  String text;

  /// 本地图片文件信息
  File localImg;

  /// 网络图片id
  Map netImg;

  /// 商品信息
  Map commodity;

  /// 发送者用户信息
  Map userInfo;

  ByChatItem(this.type,
      {Key key,
      this.text,
      this.localImg,
      this.commodity,
      this.userInfo,
      this.netImg})
      : super(key: key);

  @override
  _ByChatItemState createState() {
    return _ByChatItemState();
  }
}

class _ByChatItemState extends State<ByChatItem> {
  @override
  Widget build(BuildContext context) {
    Widget _content = Container();
    if (widget.type == GlobalChatContentTypeEnum.TEXT.index) {
      /// ---------------- 纯文字内容 start ----------------
      _content = Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
        margin: EdgeInsets.only(
          left: 10,
        ),
        constraints: BoxConstraints(
          maxWidth: ScreenUtil.getInstance().screenWidth * 0.6,
        ),
        //边框设置
        decoration: new BoxDecoration(
          //背景
          color: Colors.white,
          //设置四周圆角 角度
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10.0),
            topRight: Radius.circular(10.0),
            bottomRight: Radius.circular(10.0),
            bottomLeft: Radius.circular(10.0),
          ),
        ),
        child: ExtendedText(
          '${widget.text}',
          textAlign: TextAlign.start,
          specialTextSpanBuilder: GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
          onSpecialTextTap: (dynamic value) {
            if (value.toString().startsWith('\$')) {
              //以$开头
              print("美元");
            } else if (value.toString().startsWith('@')) {
              //以@开头
              print("哈哈哈哈哈");
            }
          },
        ),
      );

      /// ---------------- 纯文字内容 end ----------------
    } else if (widget.type == GlobalChatContentTypeEnum.NETIMG.index) {
      /// ---------------- 网络图片内容 start ----------------
      _content = Container(
        padding: EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 10),
        margin: EdgeInsets.only(
          left: 10,
        ),
        constraints: BoxConstraints(
          maxWidth: ScreenUtil.getInstance().screenWidth * 0.6,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: CachedNetworkImage(
              imageUrl:
                  '${GlobalApiUrlTable.CHAT_IMG_BY_ID}?id=${widget.netImg['id']}'),
        ),
      );

      /// ---------------- 网络图片内容 end ----------------
    } else if (widget.type == GlobalChatContentTypeEnum.COMMODITY.index) {
      /// ---------------- 商品内容 start ----------------
      /// 商品首张图片
      String imgUrl =
          'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=2041146201,2504991939&fm=26&gp=0.jpg';
      _content = Container(
          padding: EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 10),
          margin: EdgeInsets.only(
            left: 10,
          ),
          constraints: BoxConstraints(
            maxWidth: ScreenUtil.getInstance().screenWidth * 0.6,
          ),
          child: Card(
            elevation: 4.0, //阴影
            color: Colors.white, //背景色
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Container(
              child: Column(
                children: [
                  /// 商品图片区域
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(10.0),
                          topRight: Radius.circular(10.0),
                        ),
                        child: CachedNetworkImage(
                          imageUrl: imgUrl,
                        ),
                      ),
                    ],
                  ),

                  /// 价格
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text("${GlobalConst.PAY_UNIT}1000",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600)),
                  ),

                  /// 商品描述区域
                  Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: Text(
                      "商品描述区域商品描述区域商商品描述区域商品商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 6,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black,
                      ),
                    ),
                  ),

                  /// 用户信息区域
                  Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 6, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        /// 用户头像
                        ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(258),
                            topRight: Radius.circular(258),
                            bottomLeft: Radius.circular(258),
                            bottomRight: Radius.circular(258),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: imgUrl,
                            fit: BoxFit.fill,
                            width: 30,
                            height: 30,
                            // color: Colors.black
                          ),
                        ),

                        /// 分隔区域
                        SizedBox(
                          width: 10,
                        ),

                        /// 用户名
                        Expanded(
                          child: Text(
                            "商品描述区域商品描述区域商商品描述区域商品商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域商品描述区域商品描述区域商商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域商品描述区域品描述区域",
                            textAlign: TextAlign.left,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ));

      /// ---------------- 商品内容 end ----------------
    } else if (widget.type == GlobalChatContentTypeEnum.LOCALIMG.index) {
      /// ---------------- 本地图片内容 start ----------------
      _content = Container(
        padding: EdgeInsets.only(left: 0, right: 10, top: 0, bottom: 10),
        margin: EdgeInsets.only(
          left: 10,
        ),
        constraints: BoxConstraints(
          maxWidth: ScreenUtil.getInstance().screenWidth * 0.6,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
            bottomLeft: Radius.circular(10),
            bottomRight: Radius.circular(10),
          ),
          child: Image.file(widget.localImg),
        ),
      );

      /// ---------------- 本地图片内容 end ----------------
    }

    return Container(
      padding: EdgeInsets.only(
        left: 10,
        right: 10,
        top: 10,
        bottom: 10,
      ),
      width: double.infinity,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 头像
          ClipOval(
            child: CachedNetworkImage(
              imageUrl:
                  '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=1&${GlobalDateUtil.getCurrentTimestamp()}',
              fit: BoxFit.fill,
              width: 40,
              height: 40,
              // color: Colors.black
            ),
          ),

          ///内容
          _content,
        ],
      ),
    );
  }
}
