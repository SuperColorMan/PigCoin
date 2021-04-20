import 'package:cached_network_image/cached_network_image.dart';

/// -------------------------------
/// Des: 商品卡片1
/// -------------------------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';

class CommodityClassifyCard_1 extends StatefulWidget {

  /// 商品分类信息
  Map commodityClassifyStruct;

  CommodityClassifyCard_1(this.commodityClassifyStruct,{
    Key key,
  }) : super(key: key);

  @override
  _CommodityClassifyCard_1State createState() {
    return _CommodityClassifyCard_1State();
  }
}

class _CommodityClassifyCard_1State extends State<CommodityClassifyCard_1> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0, //阴影
      color: Colors.white, //背景色
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: new Container(
        padding: EdgeInsets.only(top: 5, bottom: 5, left: 10, right: 10),
        child: Row(
          children: [
            /// 商品图片
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              child: CachedNetworkImage(
                imageUrl:
                "${GlobalApiUrlTable.COMMODITY_CLASSIFY_HEAD_PIC}?id=${widget.commodityClassifyStruct['id'].toString()}",
                fit: BoxFit.fill,
                width: 30,
                height: 30,
                // color: Colors.black
              ),
            ),

            /// 商品基本信息
            Column(
              children: [
                /// 商品标题
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: 100,
                  child: Text(
                    "${widget.commodityClassifyStruct['name']}",
                    textAlign: TextAlign.start,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
