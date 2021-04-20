import 'dart:convert';

/// ---------------------------------
/// @用户选择页
/// ---------------------------------
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';

/// ------------------------------------
///  全局话题选择页
/// ------------------------------------
class GlobalSelectGambitPage extends StatefulWidget {
  @override
  _GlobalSelectGambitPageState createState() => _GlobalSelectGambitPageState();
}

class _GlobalSelectGambitPageState extends State<GlobalSelectGambitPage> {
  /// 选中回传的话题信息
  Map _selectedGambitInfo = Map();

  /// ------------- 联动列表信息 -------------
  /// 选中项索引
  int selectItemIndex = 0;

  /// 选中项颜色
  Color selectItemColor = Color(GlobalColor.MAX_SHALLOW_GRAY);

  /// --------------------------------------

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

  /// 搜索话题结果数组
  List _searchGambitResultList = [];

  /// --------------------------------------

  /// 是否显示列表区域
  bool isSearchEditStatus = false;

  /// 编辑框高度
  double editBoxHeight = 70.0;

  /// 被选择用户信息
  Map _selectedUserInfo = Map();

  /// 输入框焦点对象
  final FocusNode _focusNode = FocusNode();

  /// 文本编辑器控制器
  final TextEditingController _textEditingController = TextEditingController();

  /// 初始化话题树
  void _initGambitTree() {
    /// 初始化话题分类树
    GlobalConst.NET_API_CALL.getGambitClassifyTree().then((value) {
      if (value['code'] == 0) {
        setState(() {
          List list = value['data'];
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
        });
      } else if (value['code'] == 1) {
        GlobalToast.showToast(value['mess']);
      }
    });
  }

  /// ------------------ 构建话题分类 ------------------

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
                    color:
                        selectItemIndex == i ? Colors.white : selectItemColor,
                    padding: EdgeInsets.only(top: 20, bottom: 20),
                    child: Center(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Text(gambitList[i]['classify']),
                      ),
                    ),
                  ));
            }));
  }

  /// -----------------------------------------------
  /// ------------------ 构建话题项列表 ------------------

  Widget _buildClassifyContentList() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
            itemCount: gambitContentList.length,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.only(left: 20, right: 10),
                margin: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Container(
                      child: CachedNetworkImage(
                        imageUrl:'${GlobalApiUrlTable.GET_GAMBIT_HEAD_PIC}?id=${gambitContentList[i]['id']}',
                        width: 60,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              gambitContentList[i]['name'],
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              gambitContentList[i]['contentCount'],
                              style: TextStyle(
                                  color: Color(GlobalColor.SHALLOW_GRAY)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 30,
                      child: CommWidgetBuilder.gradientButton("选我",
                          fontSize: 14,callBack: (){
                            /// 话题id
                            _selectedGambitInfo["gambitId"] = gambitContentList[i]["id"];

                            /// 话题名
                            _selectedGambitInfo["gambitName"] = gambitContentList[i]["name"];
                            String selectedGambitInfoStr = json.encode(_selectedGambitInfo);
                            print("选我----${selectedGambitInfoStr}");
                            setState(() {
                              _selectedGambitInfo.clear();
                            });
                            Navigator.pop(context, selectedGambitInfoStr);
                          }),
                    ),
                  ],
                ),
              );
            }));
  }

  /// ------------------------------------------------------

  /// ------------------ 构建话题项列表 ------------------

  Widget _buildSearchGambitList() {
    return MediaQuery.removePadding(
        context: context,
        removeTop: true,
        removeBottom: true,
        child: ListView.builder(
            itemCount: _searchGambitResultList.length,
            itemBuilder: (context, i) {
              return Container(
                padding: EdgeInsets.only(left: 20, right: 10),
                margin: EdgeInsets.only(bottom: 15),
                child: Row(
                  children: [
                    Container(
                      child: CachedNetworkImage(
                        imageUrl:"https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=3504145682,2441617993&fm=26&gp=0.jpg",
                        width: 60,
                        height: 60,
                        fit: BoxFit.fill,
                      ),
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(left: 10),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _searchGambitResultList[i]['name'],
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(left: 10, top: 5),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              _searchGambitResultList[i]['contentCount'],
                              style: TextStyle(
                                  color: Color(GlobalColor.SHALLOW_GRAY)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      width: 60,
                      height: 30,
                      child:
                      CommWidgetBuilder.gradientButton("选我", fontSize: 14,callBack: (){
                        /// 话题id
                        _selectedGambitInfo["gambitId"] = _searchGambitResultList[i]["id"];
                        /// 话题名
                        _selectedGambitInfo["gambitName"] = _searchGambitResultList[i]["name"];
                        String selectedGambitInfoStr = json.encode(_selectedGambitInfo);
                        print("选我----${selectedGambitInfoStr}");
                        setState(() {
                          _selectedGambitInfo.clear();
                        });
                        Navigator.pop(context, selectedGambitInfoStr);
                      }),
                    ),
                  ],
                ),
              );
            }));
  }

  /// ------------------------------------------------------

  /// 构建列表区域
  Widget _buildListArea() {
    if (isSearchEditStatus) {
      return Container(
        color: Colors.white,
        height: double.infinity,
        child: MediaQuery.removePadding(
          context: context,
          removeTop: true,
          removeBottom: true,
          child: _buildSearchGambitList(),
        ),
      );
    } else {
      return Container(
        color: Colors.white,
        height: double.infinity,
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
                  child: _buildClassifyContentList(),
                ),
              ),
            ],
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _initGambitTree();

    /// 编辑区域监听
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        setState(() {
          isSearchEditStatus = true;
        });
      } else {
        setState(() {
          isSearchEditStatus = false;

          /// 清空数据
          _textEditingController.clear();
          _searchGambitResultList.clear();
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          /// 触摸收起键盘
          _focusNode.unfocus();
        },
        child: Container(
          padding: EdgeInsets.only(top: 30),
          child: Column(
            children: [
              /// 搜索区域
              Container(
                height: editBoxHeight,
                color: Colors.white,
                padding:
                    EdgeInsets.only(top: 20, bottom: 10, left: 10, right: 10),
                child: Row(
                  children: [
                    /// 返回按钮
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 15),
                      child: GestureDetector(
                          onTap: () {
                            /// 关闭页面
                            Navigator.pop(context);
                          },
                          child: Icon(Icons.arrow_back_ios)),
                    ),

                    /// 关键字输入区域
                    Expanded(
                      child: TextField(
                        controller: _textEditingController,
                        maxLines: 1,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: "内容编辑区域",
                          hintMaxLines: 20,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5),
                            borderSide: BorderSide.none,
                          ),
                          // 是否使用填充色
                          filled: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                        ),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: GestureDetector(
                        onTap: () {
                          /// 执行搜索话题
                          GlobalLocalCache.getLoginUserId().then((loginUserId) {
                            GlobalConst.NET_API_CALL
                                .searchGambit(_textEditingController.value.text,
                                    loginUserId.toString())
                                .then((value) {
                              print("话题搜索结果-----${value.toString()}");
                              if (value['code'] == 0) {
                                setState(() {
                                  List list = value['data'];
                                  for (Map mm in list) {
                                    Map gM = Map();
                                    gM['id'] = mm['id'].toString();
                                    gM['name'] = mm['name'].toString();
                                    gM['contentCount'] =
                                        mm['contentCount'].toString();
                                    _searchGambitResultList.add(gM);
                                  }
                                });
                              } else if (value['code'] == 1) {
                                GlobalToast.showToast(value['mess']);
                              }
                            });
                          });

                          /// 关闭页面
//                          Navigator.pop(context);

                          /// 清空编辑区域
//                          _textEditingController.clear();
                        },
                        child: Text(
                          "搜索",
                          style: TextStyle(color: Color(GlobalColor.DEEP_GRAY)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 列表区域
              Expanded(
                child: _buildListArea(),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: null,
    );
  }
}
