import 'package:cached_network_image/cached_network_image.dart';
/// ----------------------------------
/// des: 创建话题行级项
/// ----------------------------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';

class RowGambitItem extends StatefulWidget {

  Map gambitStruct;
  RowGambitItem(this.gambitStruct,{Key key}) : super(key: key);

  @override
  _RowGambitItemState createState() {
    return _RowGambitItemState();
  }
}

class _RowGambitItemState extends State<RowGambitItem> {

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: 10, top: 5, bottom: 5),
      child: Row(
        children: [
          /// 话题头像
          Expanded(
              flex: 2,
              child: Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5),
                    topRight: Radius.circular(5),
                    bottomLeft: Radius.circular(5),
                    bottomRight: Radius.circular(5),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                    '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=4&${GlobalDateUtil.getCurrentTimestamp()}',
                    fit: BoxFit.fill,
                    width: 55,
                    height: 55,
                    // color: Colors.black
                  ),
                ),
              )),

          /// 话题信息
          Expanded(
              flex: 8,
              child: Column(
                children: [
                  /// 话题名称
                  Container(
                      margin: EdgeInsets.only(left: 5),
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(right: 0),
                      child: Text(
                        "# ${widget.gambitStruct['name']}",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      )),
                  SizedBox(
                    height: 2,
                  ),
                  SizedBox(
                    height: 2,
                  ),

                  /// 内容数
                  Container(
                    margin: EdgeInsets.only(left: 5),
                    child: Row(
                      children: [
                        Text("${widget.gambitStruct['contentCount']}个内容",
                            style: TextStyle(
                              fontSize: 13,
                              color: new Color(0xffa6a7a8),
                            )),
                      ],
                    ),
                  ),
                ],
              )),

          /// 关注按钮
          Expanded(
              flex: 2,
              child: Container(
                padding: EdgeInsets.only(left: 5, right: 5),
                child: Center(
                  child: FlatButton(
                    height: 30,
                    splashColor: Colors.black87,
                    child: Text(
                      '关注',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 10),
                    ),
                    onPressed: () {
                      /// 执行关注
                    },
                    color: Color(GlobalColor.APP_THEME_COLOR),
                  ),
                ),
              )),
        ],
      ),
    );}
}