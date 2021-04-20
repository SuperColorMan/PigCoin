import 'dart:math';

import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCacheKey.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/chart/LineChart.dart';
import 'package:xhd_app/view/widget/chart/PieChart.dart';
import 'package:xhd_app/view/widget/comm/GroupButtons.dart';
import 'package:xhd_app/view/widget/comm/LineChartWidget.dart';
import 'package:xhd_app/view/widget/comm/PieChartWidget.dart';

/// ----------------------------------
/// des: 用户经营分析页面
/// ----------------------------------
class UserBusinessAnalysePage extends StatefulWidget {
  UserBusinessAnalysePage({Key key}) : super(key: key);

  @override
  _UserBusinessAnalysePageState createState() =>
      _UserBusinessAnalysePageState();
}

//页面状态配置,用于动态修改页面数据,页面事件等。
class _UserBusinessAnalysePageState extends State<UserBusinessAnalysePage> {
  /// 卖出商品总量
  String _saleCommoditySum = "0";

  /// 发布的商品总体分类
  List<PieSales> _sumCommodityClassifyDataList = [];

  /// 卖出量商品分类数据
  List<PieSales> _saleCommodityClassifyDataList = [];

  /// ------------- 卖出量与时间间隔 start -------------
  List<Linesales> _saleCommoditySumDataList = [];
  List<bool> _saleCommodityClickList = [true, false, false];

  /// ------------- 卖出量与时间间隔 end -------------

  /// ------------- 浏览量与时间间隔 start -------------
  List<Linesales> _lookCommoditySumDataList = [];
  List<bool> _lookCommodityClickList = [true, false, false];

  /// ------------- 浏览量与时间间隔 end -------------

  /// ------------- 加入购物车量与时间间隔 start -------------
  List<Linesales> _joinShopCarCommoditySumDataList = [];
  List<bool> _joinShopCarCommodityClickList = [true, false, false];

  /// ------------- 加入购物车量与时间间隔 end -------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 数据初始化
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      /// 卖出商品总量
      GlobalConst.NET_API_CALL
          .getSaleCommoditySumByUserId(loginUserId.toString())
          .then((value) {
        setState(() {
          _saleCommoditySum = value['data'].toString();
        });
      });

      /// 发布的商品总体分类
      GlobalConst.NET_API_CALL
          .getCommodityClassifyByUserId(loginUserId.toString())
          .then((value) {
        List dataList = value['data'];
        setState(() {
          for (Map m in dataList) {
            String name = m['name'].toString();
            int value = int.parse(m['count'].toString());
            PieSales item = PieSales(value, title: name);
            _sumCommodityClassifyDataList.add(item);
          }
        });
      });

      /// 已卖出分类数据初始化
      GlobalConst.NET_API_CALL
          .getSaleCommodityClassifyByUserId(loginUserId.toString())
          .then((value) {
        List dataList = value['data'];
        setState(() {
          for (Map m in dataList) {
            String name = m['name'].toString();
            int value = int.parse(m['count'].toString());
            PieSales item = PieSales(value, title: name);
            _saleCommodityClassifyDataList.add(item);
          }
        });
      });

      /// 卖出量数据初始化
      GlobalConst.NET_API_CALL
          .getSaleCommoditySumByWeekByUserId(loginUserId.toString())
          .then((value) {
        List dataList = value['data'];
        setState(() {
          for (Map m in dataList) {
            int index = int.parse(m['index'].toString());
            int value = int.parse(m['value'].toString());
            Linesales item = Linesales(index, value);
            _saleCommoditySumDataList.add(item);
          }
        });
      });

      /// 商品浏览量数据初始化
      GlobalConst.NET_API_CALL
          .getLookCommoditySumByWeekByUserId(loginUserId.toString())
          .then((value) {
        List dataList = value['data'];
        setState(() {
          for (Map m in dataList) {
            int index = int.parse(m['index'].toString());
            int value = int.parse(m['value'].toString());
            Linesales item = Linesales(index, value);
            _lookCommoditySumDataList.add(item);
          }
        });
      });

      /// 商品被加入购物车量数据初始化
      GlobalConst.NET_API_CALL
          .getJoinShopCarCommoditySumByWeekByUserId(loginUserId.toString())
          .then((value) {
        List dataList = value['data'];
        setState(() {
          for (Map m in dataList) {
            int index = int.parse(m['index'].toString());
            int value = int.parse(m['value'].toString());
            Linesales item = Linesales(index, value);
            _joinShopCarCommoditySumDataList.add(item);
          }
        });
      });
    });
  }

  /// 构建页
  Widget _buildPage() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return new Column(
              children: [
                /// 总体卖出量
                Container(
                  /// 下边框
                  decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          bottom: BorderSide(
                              width: 5,
                              color: Color(GlobalColor.MAX_SHALLOW_GRAY)))),
                  padding: EdgeInsets.only(top: 15, bottom: 15),
                  width: double.infinity,
                  child: Column(
                    children: [
                      Container(
                        child: Row(
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: 15,
                                ),
                                Image.asset(
                                  GlobalFilePath.TITLE_LOGO_36,
                                  width: 25,
                                  height: 25,
                                ),
                                Container(
                                  padding: EdgeInsets.only(left: 5),
                                  child: Text(
                                    "总体卖出量",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(
                                color: Color(GlobalColor.APP_THEME_COLOR),
                                fontSize: 20.0),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${_saleCommoditySum}',
                                style: TextStyle(
                                    fontSize: 30, fontWeight: FontWeight.w600),
                              ),
                              TextSpan(text: '  '),
                              TextSpan(
                                text: '件',
                                style: TextStyle(
                                    color: Color(GlobalColor.SHALLOW_GRAY)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 商品分类分布
                PieChartWidget(
                  _sumCommodityClassifyDataList,
                  title: "商品分类分布",
                  titleIcon: Image.asset(
                    GlobalFilePath.TITLE_LOGO_37,
                    width: 25,
                    height: 25,
                  ),
                ),

                /// 已卖出分类
                PieChartWidget(
                  _saleCommodityClassifyDataList,
                  title: "已卖出分类",
                  titleIcon: Image.asset(
                    GlobalFilePath.TITLE_LOGO_38,
                    width: 25,
                    height: 25,
                  ),
                ),

                /// 卖出量
                LineChartWidget(
                  _saleCommoditySumDataList,
                  [Text("本周"), Text("本月"), Text("本年")],
                  [true, false, false],
                  title: "卖出量",
                  titleIcon: Image.asset(
                    GlobalFilePath.TITLE_LOGO_39,
                    width: 33,
                    height: 33,
                  ),
                  callBack: (index) {
                    if (index == 0) {
                      /// 本周
                      /// 数据初始化
                      GlobalLocalCache.getLoginUserId().then((loginUserId) {
                        /// 卖出量数据初始化
                        GlobalConst.NET_API_CALL
                            .getSaleCommoditySumByWeekByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _saleCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _saleCommoditySumDataList.add(item);
                          }
                        });
                      });
                    } else if (index == 1) {
                      /// 本月
                      /// 数据初始化
                      GlobalLocalCache.getLoginUserId().then((loginUserId) {
                        /// 卖出量数据初始化
                        GlobalConst.NET_API_CALL
                            .getSaleCommoditySumByMonthByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _saleCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _saleCommoditySumDataList.add(item);
                          }
                        });
                      });
                    } else if (index == 2) {
                      /// 本年
                      /// 数据初始化
                      GlobalLocalCache.getLoginUserId().then((loginUserId) {
                        /// 卖出量数据初始化
                        GlobalConst.NET_API_CALL
                            .getSaleCommoditySumByYearByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _saleCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _saleCommoditySumDataList.add(item);
                          }
                        });
                      });
                    }
                  },
                ),

                /// 浏览量
                LineChartWidget(
                  _lookCommoditySumDataList,
                  [Text("本周"), Text("本月"), Text("本年")],
                  [true, false, false],
                  title: "浏览量",
                  titleIcon: Image.asset(
                    GlobalFilePath.TITLE_LOGO_40,
                    width: 33,
                    height: 33,
                  ),
                  callBack: (index) {
                    GlobalLocalCache.getLoginUserId().then((loginUserId) {
                      if (index == 0) {
                        GlobalConst.NET_API_CALL
                            .getLookCommoditySumByWeekByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _lookCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _lookCommoditySumDataList.add(item);
                          }
                        });
                      } else if (index == 1) {
                        GlobalConst.NET_API_CALL
                            .getLookCommoditySumByMonthByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _lookCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _lookCommoditySumDataList.add(item);
                          }
                        });
                      } else if (index == 2) {
                        GlobalConst.NET_API_CALL
                            .getLookCommoditySumByYearByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _lookCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _lookCommoditySumDataList.add(item);
                          }
                        });
                      }
                    });
                  },
                ),

                /// 被加入购物车次数
                LineChartWidget(
                  _joinShopCarCommoditySumDataList,
                  [Text("本周"), Text("本月"), Text("本年")],
                  [true, false, false],
                  title: "被加入购物车次数",
                  titleIcon: Image.asset(
                    GlobalFilePath.TITLE_LOGO_41,
                    width: 33,
                    height: 33,
                  ),
                  callBack: (index) {
                    GlobalLocalCache.getLoginUserId().then((loginUserId) {
                      if (index == 0) {
                        /// 商品被加入购物车量数据初始化
                        GlobalConst.NET_API_CALL
                            .getJoinShopCarCommoditySumByWeekByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _joinShopCarCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _joinShopCarCommoditySumDataList.add(item);
                          }
                        });
                      } else if (index == 1) {
                        /// 商品被加入购物车量数据初始化
                        GlobalConst.NET_API_CALL
                            .getJoinShopCarCommoditySumByMonthByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _joinShopCarCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _joinShopCarCommoditySumDataList.add(item);
                          }
                        });
                      } else if (index == 2) {
                        /// 商品被加入购物车量数据初始化
                        GlobalConst.NET_API_CALL
                            .getJoinShopCarCommoditySumByYearByUserId(
                                loginUserId.toString())
                            .then((value) {
                          List dataList = value['data'];
                          _joinShopCarCommoditySumDataList.clear();
                          for (Map m in dataList) {
                            int index = int.parse(m['index'].toString());
                            int value = int.parse(m['value'].toString());
                            Linesales item = Linesales(index, value);
                            _joinShopCarCommoditySumDataList.add(item);
                          }
                        });
                      }
                    });
                  },
                ),
              ],
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          '经营分析',
          style: TextStyle(color: Colors.black87),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
//        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios,
                color: Colors.black87,
              ),
              iconSize: 28,
            ),
            margin: EdgeInsets.only(left: 15),
          ),
        ),
      ),
      body: _buildPage(),
    );
  }
}
