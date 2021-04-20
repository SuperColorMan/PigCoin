import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalStyleConst.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// --------------------------------------------------------------------------------------------------
/// Des: 构建点赞内容项,上方是点赞提示,下方是被点赞的内容(该结构一般用于的用户的通知消息提示内)
/// --------------------------------------------------------------------------------------------------
class GoodContentItem extends StatefulWidget {
  Map contentStructure;

  GoodContentItem(this.contentStructure, {Key key}) : super(key: key);

  @override
  _GoodContentItemState createState() {
    return _GoodContentItemState();
  }
}

class _GoodContentItemState extends State<GoodContentItem> {
  @override
  Widget build(BuildContext context) {
    Map contentStructure = widget.contentStructure;
    return GestureDetector(
      onTap: () {
        GlobalRouteTable.goShowContentPage(context, contentStructure);
      },
      child: Container(
        /// 下边框
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(
                bottom: BorderSide(
                    width: 5, color: Color(GlobalColor.MAX_SHALLOW_GRAY)))),
        padding: EdgeInsets.only(right: 10),
        margin: EdgeInsets.only(bottom: 10),
        child: Column(children: [
          /// 用户信息
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, top: 10, bottom: 10),
            child: Expanded(
              child: Row(
                children: [
                  ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                          'https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=1186169214,3324133379&fm=26&gp=0.jpg',
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
                        "且危及日脚气我额",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      )),
                ],
              ),
            ),
          ),

          /// 描述
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(left: 10, right: 10, top: 0, bottom: 10),
            child: ExtendedText(
              "赞了你",
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
                  /// 对方内容正文
                  Expanded(
                    flex: 9,
                    child: Container(
                        width: ScreenUtil.getInstance().screenWidth * 0.78,
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(
                          "我是彩色虾  :  沙嗲圣诞节覅哦啊近似的房价就是滴哦犯贱啊搜我几点覅OA世纪东方",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontSize: GlobalStyleConst.CONTENT_BODY_FONT_SIZE,
                          ),
                        )),
                  ),

                  /// 对方内容图片
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadiusDirectional.circular(4)),
                            clipBehavior: Clip.antiAlias,
                            child: CachedNetworkImage(
                              imageUrl:
                                  "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.5mcc.com.cn%2F5mcc_com_cn%2Fallimg%2F190214%2F03145V3c-40.jpg&refer=http%3A%2F%2Fimg.5mcc.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1612856567&t=9f234c92ce66970c0e85a1571464c6f9",
                              fit: BoxFit.fill,
                              placeholder: (context, url) => BallBeatIndicator(
                                  ballColor:
                                      Color(GlobalColor.APP_THEME_COLOR)),
                            ))),
                  ),
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
        ]),
      ),
    );
  }
}
