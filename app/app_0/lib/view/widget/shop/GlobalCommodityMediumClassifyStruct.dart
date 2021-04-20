import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'GlobalCommoditySmallClassifyStruct.dart';

/// -------------------------------
/// Des: 商品中类分类结构
/// -------------------------------
class GlobalCommodityMediumClassifyStruct extends StatefulWidget {
  /// 是否显示复选框
  bool isShowSelectBox;

  Map commodityMediumClassifyStruct;

  /// 小类点击回调
  Function smallClassifyClickCallBack;

  GlobalCommodityMediumClassifyStruct(this.commodityMediumClassifyStruct,
      {Key key, this.isShowSelectBox, this.smallClassifyClickCallBack})
      : super(key: key);

  @override
  _GlobalCommodityMediumClassifyStructState createState() {
    return _GlobalCommodityMediumClassifyStructState();
  }
}

class _GlobalCommodityMediumClassifyStructState
    extends State<GlobalCommodityMediumClassifyStruct> {
  @override
  Widget build(BuildContext context) {
    /// 所属中类小类分类列表
    List smallClassifyList =
        widget.commodityMediumClassifyStruct['smallClassifyList'];

    /// 不存在小类时,不显示中类
    if (smallClassifyList == null || smallClassifyList.length == 0) {
      return Container();
    }
    Widget mediumClassify = Container(
      color: Colors.white,
      child: Column(
        children: [
          /// 标题
          Container(
            padding: EdgeInsets.only(left: 10, right: 10, bottom: 8),
            child: Row(
              children: [
                Text(
                  "${widget.commodityMediumClassifyStruct['name'].toString()}",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
          ),

          /// 商品小类
          GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              //禁止滑动
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                //横轴元素个数
                crossAxisCount: 3,
                //纵轴间距
                mainAxisSpacing: 6.0,
                //横轴间距
                crossAxisSpacing: 6.0,
              ),
              itemCount: smallClassifyList.length,
              itemBuilder: (BuildContext context, int index) {
                //Widget Function(BuildContext context, int index)
                return GlobalCommoditySmallClassifyStruct(
                  smallClassifyList[index],
                  isShowSelectBox: widget.isShowSelectBox,
                  clickCallBack: widget.smallClassifyClickCallBack,
                );
              }),
        ],
      ),
    );
    return mediumClassify;
  }
}
