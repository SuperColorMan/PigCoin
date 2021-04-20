import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 商品小类分类结构
/// -------------------------------
class GlobalCommoditySmallClassifyStruct extends StatefulWidget {
  /// 是否显示复选框
  bool isShowSelectBox;

  Map commoditySmallClassifyStruct;

  /// 点击事件
  Function clickCallBack;

  GlobalCommoditySmallClassifyStruct(this.commoditySmallClassifyStruct,
      {Key key, this.isShowSelectBox = false, this.clickCallBack})
      : super(key: key);

  @override
  _GlobalCommoditySmallClassifyStructState createState() {
    return _GlobalCommoditySmallClassifyStructState();
  }
}

class _GlobalCommoditySmallClassifyStructState
    extends State<GlobalCommoditySmallClassifyStruct> {
  bool _isSelected = false;

  /// 构建复选框
  Widget _buildSelectedBox() {
    if (widget.isShowSelectBox) {
      /// 复选框
      return Positioned(
        top: -10,
        right: 0,
        child: Checkbox(
          value: _isSelected,
          activeColor: Color(GlobalColor.APP_THEME_COLOR),
          onChanged: (bool val) {
            /// val 是布尔值
            setState(() {
              _isSelected = val;
            });
          },
        ),
      );
    } else {
      return Container();
    }
  }

  /// 构建信息区域
  Widget _buildInfoArea() {
    return Column(
      children: [
        Stack(
          children: [
            CachedNetworkImage(
              width: 60,
              height: 60,
              fit: BoxFit.fill,
              imageUrl:
                  "${GlobalApiUrlTable.COMMODITY_CLASSIFY_HEAD_PIC}?id=${widget.commoditySmallClassifyStruct['id'].toString()}",
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.only(top: 10),
          child: Text(
            "${widget.commoditySmallClassifyStruct['name'].toString()}",
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget smallClassify = Container(
      child: Stack(
        alignment: Alignment.center,
        children: [
          _buildInfoArea(),
          _buildSelectedBox(),
        ],
      ),
    );
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () {
        if (widget.isShowSelectBox) {
          setState(() {
            _isSelected = _isSelected ? false : true;
          });
        }

        /// 点击事件
        if (widget.clickCallBack != null) {
          widget.clickCallBack(widget.commoditySmallClassifyStruct,_isSelected);
        }
      },
      child: smallClassify,
    );
  }
}
