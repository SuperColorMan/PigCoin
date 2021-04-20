import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';

/// -------------------------------
/// Des: 商品项
/// -------------------------------
class CommodityItem extends StatefulWidget {
  /// 商品数据结构
  Map commodityStrcut;

  CommodityItem(this.commodityStrcut, {Key key}) : super(key: key);

  @override
  _CommodityItemState createState() {
    return _CommodityItemState();
  }
}

class _CommodityItemState extends State<CommodityItem> {
  @override
  Widget build(BuildContext context) {
    /// 图片列表
    List imgList = widget.commodityStrcut['tshopImgInfoList'];

    /// 首张图片url
    String imgUrl =
        '${GlobalApiUrlTable.GET_COMMODITY_PIC}?id=${imgList[0]['id'].toString()}';

    /// 商品名称
    String name = widget.commodityStrcut['name'].toString();

    /// 商品描述
    String intro = widget.commodityStrcut['intro'].toString();

    /// 商品用户信息
    Map userInfo = widget.commodityStrcut['tuUser'];

    /// 用户id
    String userId = userInfo['id'].toString();

    /// 用户名
    String userName = userInfo['name'].toString();

    Widget _commodityItem = Card(
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

            /// 商品名称区域
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                "${name}",
                textAlign: TextAlign.left,
                softWrap: true,
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  fontWeight: FontWeight.w600
                ),
              ),
            ),

            /// 商品描述区域
            Container(
              width: double.infinity,
              padding: EdgeInsets.only(left: 10, right: 10, top: 10),
              child: Text(
                "${intro}",
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
              padding: EdgeInsets.only(left: 10, right: 10, top: 6, bottom: 10),
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
                      imageUrl:
                          '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${userId}',
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
                      "${userName}",
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
    );
    return _commodityItem;
  }
}
