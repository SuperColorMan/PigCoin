import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/gambit/RowGambitItem_2.dart';

/// ----------------------------------
/// des: 全部话题展示页
/// ----------------------------------
class FindPage_2 extends StatefulWidget {
  FindPage_2({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _FindPage_2State createState() => _FindPage_2State();
}

//页面状态配置,用于动态修改页面数据,页面事件等。
class _FindPage_2State extends State<FindPage_2> {
  /// ------------- 话题联动信息 -------------
  /// 联动结构
  /// [
  ///    {
  ///      "classify": "话题1",
  ///      "contentList": [
  ///        {
  ///          "name": "奥特曼",
  ///          "contentCount": "12123123",
  ///        },
  ///      ],
  ///    },
  ///    {
  ///      "classify": "话题2",
  ///      "contentList": [
  ///        {
  ///          "name": "奥qwe特曼",
  ///          "contentCount": "12123123",
  ///        },
  ///      ],
  ///    },
  ///  ];
  List gambitList = [];

  /// 分类相应数组
  List gambitContentList = [];

  /// --------------------------------------

  /// ------------- 联动列表信息 -------------
  /// 选中项索引
  int selectItemIndex = 0;

  /// 选中项颜色
  Color selectItemColor = Color(GlobalColor.MAX_SHALLOW_GRAY);

  /// --------------------------------------

  /// ---------------------------- 分类列表构建 ----------------------------

  Widget _buildClassifyList() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
            itemCount: gambitList.length,
            itemBuilder: (context, i) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectItemIndex = i;
                    gambitContentList = gambitList[i]['contentList'];
                  });
                },
                child: Container(
                  color: selectItemIndex == i ? Colors.white : selectItemColor,
                  padding: EdgeInsets.only(top: 20, bottom: 20),
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Text(
                        gambitList[i]['classify'],
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              );
            }));
  }

  /// ----------------------------------------------------------------------

  /// ---------------------------- 分类相应内容列表构建 ----------------------------
  /// 构建话题项列表
  Widget _buildgambitContentList() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
            itemCount: gambitContentList.length,
            itemBuilder: (context, i) {
              return RowGambitItem_2(gambitContentList[i]);
            }));
  }

  ///--------------------------------------------------------------------------

  /// ---------------------------- 构建话题分类显示区域 start----------------------------
  Widget _buildContentArea() {
    /// 内容区域
    return Container(
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
              color: Colors.white,
              padding: EdgeInsets.only(top: 20),
              child: _buildgambitContentList(),
            ),
          ),
        ],
      ),
    );
  }

  /// ---------------------------- 构建话题分类显示区域 end----------------------------

  /// ---------------------------- 初始化话题树 start ----------------------------
  void _initGambitTree() {
    /// 初始化话题分类树
    GlobalConst.NET_API_CALL.getGambitClassifyTree().then((value) {
      if (value['code'] == 0) {
        setState(() {
          List list = value['data'];
          if (list.length > 0) {
            for (Map m in list) {
              Map classify = Map();
              classify['id'] = m['id'].toString();
              classify['classify'] = m['name'].toString();
              List list2 = m['tgGambitList'];
              List gList = List();
              for (Map mm in list2) {
                Map gM = Map();
                gM['id'] = mm['id'].toString();
                gM['name'] = mm['name'].toString();
                gM['contentCount'] = mm['contentCount'].toString();
                gList.add(gM);
              }
              classify['contentList'] = gList;
              print("逐个分类----${classify.toString()}");
              gambitList.add(classify);
            }
            print("话题分类列表----${gambitList.toString()}");

            /// 内容列表初始化
            gambitContentList = gambitList[0]['contentList'];
          }
        });
      } else if (value['code'] == 1) {
        GlobalToast.showToast(value['mess']);
      }
    });
  }

  /// ---------------------------- 初始化话题树 end ----------------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 初始化话题树
    _initGambitTree();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildContentArea(),
    );
  }
}
