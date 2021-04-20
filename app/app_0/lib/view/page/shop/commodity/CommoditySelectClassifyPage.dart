import 'dart:convert';
/// -------------------------------
/// Des: 商品分类页
/// -------------------------------
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/shop/GlobalCommodityClassifyBuilder.dart';
import 'package:xhd_app/view/widget/shop/GlobalCommodityMediumClassifyStruct.dart';

class CommoditySelectClassifyPage extends StatefulWidget {
  /// 默认索引
  int defaultIndex;

  CommoditySelectClassifyPage({Key key, this.defaultIndex = 0})
      : super(key: key);

  @override
  _CommoditySelectClassifyPageState createState() =>
      _CommoditySelectClassifyPageState();
}

class _CommoditySelectClassifyPageState
    extends State<CommoditySelectClassifyPage> {
  /// ------------- 联动列表信息 -------------
  /// 选中项索引
  int selectItemIndex = 0;

  /// 选中项颜色
  Color selectItemColor = Color(GlobalColor.MAX_SHALLOW_GRAY);

  /// --------------------------------------

  /// ------------- 商品分类联动信息 -------------

  /// 商品分类大类
  List bigClassifyList = [];

  /// 商品分类中类
  List mediumClassifyList = [];

  /// 商品分类小类
  List smallClassifyList = [];

  /// --------------------------------------

  /// 已经选择的商品分类信息
  List selectedCommodityClassifyList = [];

  /// 初始化商品分类树
  void _initCommodityClassifyTree() {
    /// 初始化话题分类树CommodityClassify
    GlobalConst.NET_API_CALL.getCommodityClassifyTree().then((value) {
      if (value['code'] == 0) {
        setState(() {
          List list = value['data'];
          if (list.length > 0) {
            for (Map m in list) {
              if (m['lvl'].toString() == "0") {
                /// 处理中类列表
                List mClassifyList = m['mediumClassifyList'];

                /// 如果不存在中类,不显示大类
                if (mClassifyList != null && mClassifyList.length > 0) {
                  /// 处理大类列表
                  bigClassifyList.add(m);
                }
              }
            }

            /// 初始化
            selectItemIndex = widget.defaultIndex;
            mediumClassifyList =
                bigClassifyList[widget.defaultIndex]['mediumClassifyList'];
          }
        });
      } else if (value['code'] == 1) {
        GlobalToast.showToast(value['mess']);
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 初始化商品分类树
    _initCommodityClassifyTree();
  }

  /// ---------------------------- 商品大类列表构建 ----------------------------

  Widget _buildClassifyList() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
            itemCount: bigClassifyList.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectItemIndex = i;
                    mediumClassifyList =
                        bigClassifyList[i]['mediumClassifyList'];
                  });
                },
                child: Container(
                  color: selectItemIndex == i ? Colors.white : selectItemColor,
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        bigClassifyList[i]['name'].toString(),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  /// ----------------------------------------------------------------------

  /// ---------------------------- 商品中类列表构建 ----------------------------
  /// 构建商品中类列表
  Widget _buildMediumClassifyList() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
            itemCount: mediumClassifyList.length,
//            itemCount: smallClassifyList.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                  onTap: () {},
                  child: GlobalCommodityMediumClassifyStruct(
                    mediumClassifyList[i],
                    isShowSelectBox: true,
                    smallClassifyClickCallBack:
                        (commoditySmallClassifyStruct, isSelected) {
                      if (isSelected) {
                        setState(() {
                          selectedCommodityClassifyList
                              .add(commoditySmallClassifyStruct);
                        });

                        /// 小类点击:商品分类选择
                        print(
                            "小类点击:商品分类选择--${commoditySmallClassifyStruct.toString()}");
                      } else {
                        print("小类点击:商品分类选择取消");
                      }
                    },
                  ));
            }));
  }

  ///--------------------------------------------------------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Container(
            padding: EdgeInsets.only(top: 8, bottom: 8, right: 10),
            child: SizedBox(
              width: 70,
              child: RaisedButton(
                color: Color(GlobalColor.APP_THEME_COLOR),
                onPressed: () {
                  /// 发布商品
                  Navigator.pop(
                      context, json.encode(selectedCommodityClassifyList));
                },
                child: Text(
                  '确定',
                  style: TextStyle(fontSize: 16.0, color: Colors.white),
                ),

                ///圆角
                shape: RoundedRectangleBorder(
                    side: BorderSide.none,
                    borderRadius: BorderRadius.all(Radius.circular(5))),
              ),
            ),
          ),
        ],
        leading: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.pop(context);
          },
          child: Center(
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
              size: 25,
            ),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          "商品分类",
          style: TextStyle(color: Colors.black),
        ),
      ),
      backgroundColor: Colors.white,
      body: Column(
        children: [
          /// 内容区域
          Expanded(
            flex: 10,
            child: Container(
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                      child: _buildClassifyList(),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Container(
                      padding: EdgeInsets.only(top: 20),
                      child: _buildMediumClassifyList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
