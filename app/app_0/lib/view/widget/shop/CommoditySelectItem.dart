import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 商品选择项
/// -------------------------------
class CommoditySelectItem extends StatefulWidget {
  /// 选择项回调
  Function selectItemCallBack;

  CommoditySelectItem({Key key, this.selectItemCallBack}) : super(key: key);

  @override
  _CommoditySelectItemState createState() {
    return _CommoditySelectItemState();
  }
}

class _CommoditySelectItemState extends State<CommoditySelectItem> {
  /// 选中标识符
  bool _isSelected = false;

  @override
  Widget build(BuildContext context) {
    /// 商品首张图片
    String imgUrl =
        'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4077391885,613310756&fm=26&gp=0.jpg';
    Widget _CommoditySelectItem = Card(
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
    );
    Widget item = GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = _isSelected ? false : true;
        });

        /// 选择项回调
        widget.selectItemCallBack(_isSelected, "1");
      },
      child: Container(
        child: Stack(
          children: [
            _CommoditySelectItem,

            /// 复选框
            Checkbox(
              value: _isSelected,
              activeColor: Color(GlobalColor.APP_THEME_COLOR),
              onChanged: (bool val) {
                /// val 是布尔值
                setState(() {
                  _isSelected = val;
                });
              },
            ),
          ],
        ),
      ),
    );
    return item;
  }
}
