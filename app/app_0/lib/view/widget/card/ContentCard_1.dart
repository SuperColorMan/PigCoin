import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// -------------------------------
/// Des: 构建内容卡片1
/// -------------------------------
class ContentCard_1 extends StatefulWidget {
  Map contentStructure;
  Function callBack;
  ContentCard_1(this.contentStructure, {Key key,Function callBack}) : super(key: key);

  @override
  _ContentCard_1State createState() {
    return _ContentCard_1State();
  }
}

class _ContentCard_1State extends State<ContentCard_1> {
  @override
  Widget build(BuildContext context) {
    Map contentStructure = widget.contentStructure;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(6.0),
            topRight: Radius.circular(6.0),
            bottomLeft: Radius.circular(6.0),
            bottomRight: Radius.circular(6.0)),
      ),
      clipBehavior: Clip.antiAlias,

      /// 阴影色
      elevation: 2.0,

      /// 背景色
      color: Colors.grey,
      child: Stack(
        alignment: AlignmentDirectional.bottomEnd,
        children: [
          /// 内容图片
          Container(
            width: 258,
            height: 158,
            color: Colors.white,
            child: Image.network(
              "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1547808534,2960848490&fm=26&gp=0.jpg",
              fit: BoxFit.fill,
            ),
          ),

          /// 用户信息蒙层
          Opacity(
            opacity: 0.3, //设置透明度
            child: Container(
              height: 40,
              width: 258,
              color: Colors.black,
            ),
          ),

          /// 用户信息
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
            ),
            height: 40,
            width: 258,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                /// 用户头像
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(360),
                    topRight: Radius.circular(360),
                    bottomLeft: Radius.circular(360),
                    bottomRight: Radius.circular(360),
                  ),
                  child: Image.network(
                    "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1547808534,2960848490&fm=26&gp=0.jpg",
                    fit: BoxFit.fill,
                    width: 30,
                    height: 30,
                    // color: Colors.black
                  ),
                ),

                /// 用户名
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(left: 10),
                    child: Text(
                      "sadfisadfiajsidfsadfiajsidfsadfiajsidfsadfiajsidfsadfiajsidfsadfiajsidfsadfiajsidfajsidf",
                      textAlign: TextAlign.left,
                      softWrap: true,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
