import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:xhd_app/model/gambit/GambitModel.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/media/GlobalCamera.dart';
import 'package:xhd_app/view/comm/media/GlobalPhotoAlbum.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/text/type/emoji_text.dart' as emoji;
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/card/CommodityCard_1.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';

class SendContentPage extends StatefulWidget {
  SendContentPage({Key key}) : super(key: key);

  @override
  _SendContentPageState createState() => _SendContentPageState();
}

class _SendContentPageState extends State<SendContentPage>
    with TickerProviderStateMixin {
  /// 已选择的话题
  GambitModel _selectedGambitModel;

  /// 是否显示表情标识符
  bool isShowFaceSelect = false;

  /// 全局key
  final GlobalKey _key = GlobalKey();

  /// 文本编辑器控制器
  static final TextEditingController _textEditingController =
      TextEditingController();

  /// 输入框焦点对象
  final FocusNode _focusNode = FocusNode();

  /// 内容发送的选择的图片列表
  List<String> _selectedImgPathList = [];

  /// @用户id列表
  List<String> _atUserIdList = [];

  /// 加入的话题id列表
  List<String> _joinGambitIdList = [];

  /// 关联商品id列表
  List<String> _relCommodityIdList = [];

  /// 关联商品组件列表
  List<Widget> _relCommodityList = [
    CommodityCard_1(Map()),
    CommodityCard_1(Map()),
    CommodityCard_1(Map()),
    CommodityCard_1(Map()),
  ];

  /// 构建图片选择预览区域
  Widget _buildSelectedImgPreView() {
    if (_selectedImgPathList.length > 0) {
      return GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: _selectedImgPathList.length,
          //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //横轴元素个数
              crossAxisCount: 3,
              //纵轴间距
              mainAxisSpacing: 20.0,
              //横轴间距
              crossAxisSpacing: 10.0,
              //子组件宽高长度比例
              childAspectRatio: 1.0),
          // ignore: missing_return
          itemBuilder: (BuildContext context, int index) {
            return Stack(
              fit: StackFit.expand,
              children: [
                Container(
                  child: Image.file(
                    new File(_selectedImgPathList[index]),
                    fit: BoxFit.fill,
                  ),
                ),
                StatefulBuilder(builder: (context, setCheckStatus) {
                  return Positioned(
                    width: 25,
                    height: 25,
                    right: 0,
                    child: GestureDetector(
                      onTap: () {
                        /// 删除指定对象
                        setState(() {
                          _selectedImgPathList.removeAt(index);
                        });
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 20,
                        height: 20,
                        color: Color(0x80000000),
                        child: Icon(
                          Icons.clear,
                          size: 25,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  );
                }),
              ],
            );
          });
    } else {
      return Container();
    }
  }

  /// 是否添加定位
  bool _isAddLocal = false;

  /// 构建商品关联区域
  Widget buildRelCommodityArea() {
    if (_relCommodityList.length > 0) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Column(
          children: [
            /// 标题
            Container(
              padding: EdgeInsets.only(
                left: 10,
                right: 10,
              ),
              child: Row(
                children: [
                  Image.asset(
                    GlobalFilePath.TITLE_LOGO_29,
                    width: 25,
                    height: 25,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 5),
                    child: Text(
                      "相关商品",
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),

            /// 内容区域
            Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              width: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(children: _relCommodityList),
              ),
            ),
          ],
        ),
      );
    } else {
      return Container();
    }
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
                /// ---------------------- 内容编辑区域 start ----------------------
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  constraints: BoxConstraints(
                    minHeight: 150,
                  ),
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  child: ExtendedTextField(
                    key: _key,
                    onTap: () {
                      /// 关闭表情选择
                      setState(() {
                        isShowFaceSelect = false;
                      });
                    },
                    specialTextSpanBuilder:
                        GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
                    controller: _textEditingController,
                    maxLines: null,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.all(12.0),
                      hintText: "内容编辑区域",
                      hintMaxLines: 20,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                /// ---------------------- 内容编辑区域 end ----------------------

                /// ---------------------- 话题选择 start ----------------------
                Container(
                  padding: EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            /// 前往话题选择页面
                            GlobalRouteTable.goGlobalSelectGambitPage(context,
                                (String result) {
                              /// 回传处理
                              Map selectedGambitInfo = json.decode(result);

                              /// 用户id
                              String gambitId = selectedGambitInfo["gambitId"];

                              /// 用户名
                              String gambitName =
                                  selectedGambitInfo["gambitName"];

                              /// 页面发生跳转会清空编辑区域,所以要加上之前的文本内容
                              String text = "#${gambitName}#";
                              setState(() {
                                _selectedGambitModel.name = gambitName;

                                /// 目前只支持加入单一话题
                                _joinGambitIdList.clear();
                                _joinGambitIdList.add(gambitId);
                              });
                            });
                          },
                          child: Container(
                            child: Row(
                              children: [
                                Container(
                                  child: Text(
                                    "#",
                                    style: TextStyle(
                                      fontSize: 25,
                                      color: Color(GlobalColor.APP_THEME_COLOR),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    !_selectedGambitModel.name.isEmpty
                                        ? _selectedGambitModel.name
                                        : "请选择话题",
                                    style: TextStyle(
                                      color: Color(GlobalColor.APP_THEME_COLOR),
                                    ),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(left: 10),
                                  child: Icon(
                                    Icons.arrow_forward_ios,
                                    size: 20,
                                    color: Color(GlobalColor.APP_THEME_COLOR),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            "在这里添加话题哦!",
                            textAlign: TextAlign.right,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// ---------------------- 话题选择 end ----------------------

                /// ---------------------- 添加定位 start ----------------------
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 20),
                        child: Text("添加定位", style: TextStyle(fontSize: 15)),
                      ),
                      Transform.scale(
                        scale: 1.2,
                        child: Switch(
                          value: _isAddLocal,
                          activeColor: Colors.red,
                          onChanged: (value) {
                            setState(() {
                              _isAddLocal = value;
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                /// ---------------------- 添加定位 end ----------------------

                /// ---------------------- 图片选择预览区域 start ----------------------
                Container(
                    padding: EdgeInsets.only(left: 10, right: 10, top: 10),
                    child: _buildSelectedImgPreView()),

                /// ---------------------- 图片选择预览区域 end ----------------------

                /// ---------------------- 商品选择预览区域 start ----------------------
                buildRelCommodityArea(),

                /// ---------------------- 商品选择预览区域 start ----------------------
              ],
            );
          }),
    );
  }

  /// --------------- 发送内容相关参数 ---------------
  num _loginUserId = null;

  /// ---------------------------------------------
  @override
  void initState() {
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        /// 有焦点,隐藏表情选择框
        setState(() {
          isShowFaceSelect = false;
        });
      }
    });
    // TODO: implement initState
    super.initState();

    /// 初始化话题
    _selectedGambitModel = new GambitModel(0, "", 0);

    /// 初始化登录用户id
    Future<num> loginUserIdFuture = GlobalLocalCache.getLoginUserId();
    loginUserIdFuture.then((value) {
      _loginUserId = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              Container(
                padding: EdgeInsets.only(top: 8, bottom: 8, right: 10),
                child: SizedBox(
                  width: 70,
                  child: RaisedButton(
                    color: Color(GlobalColor.APP_THEME_COLOR),
                    onPressed: () {
                      if (!_loginUserId.isNaN) {
                        /// 上传内容
                        GlobalConst.NET_API_CALL
                            .upContent(
                                _loginUserId.toString(),
                                _textEditingController.value.text,
                                _selectedImgPathList,
                                _atUserIdList,
                                _joinGambitIdList)
                            .then((value) {
                          if (value['code'] == 0) {
                            /// 清空操作
                            _cleanPage();

                            /// 上传成功
                            Navigator.pop(context);
                          } else {
                            /// 上传失败
                            GlobalToast.showToast('${value['mess']}');

                            /// 清空操作
                            _cleanPage();
                            Navigator.pop(context);
                          }
                        });
                      } else {
                        /// 未登录
                        GlobalToast.showToast("请先登录");
                      }
                      print('发送');
                    },
                    child: Text(
                      '发送',
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
            title: Text(
              '内容发送',
              style: TextStyle(color: Colors.black87),
            ),
            centerTitle: true,
            elevation: 0,
            backgroundColor: Colors.white,
            brightness: Brightness.dark,
//        automaticallyImplyLeading: false,
            leading: GestureDetector(
              onTap: () {
                /// 清空操作
                _cleanPage();

                /// 关闭页面
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
          preferredSize: Size.fromHeight(50)),
      body: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          /// 触摸收起键盘
          GlobalConst.hideSoftKeyBoard(() {
            print("隐藏软键盘");
          });

          /// 关闭表情选择框
          setState(() {
            isShowFaceSelect = false;
          });
        },
        child: new Column(children: <Widget>[
          new Flexible(child: _buildPage()),

          /// ----------------- 功能按钮区域 start -----------------
          Container(
            padding: EdgeInsets.only(
              top: 10,
              bottom: 30,
            ),
            child: Row(
              children: [
                /// 相机
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      /// 打开相机
                      GlobalCamera.open(context, (assetEntity) async {
                        print("相机选择....${assetEntity}");
                        File file = await assetEntity.file;
                        String id = await assetEntity.id;
                        setState(() {
                          _selectedImgPathList.add(file.path);
                        });
                      });
//                      _openCamera((String imgFilePath) {
//                        setState(() {
//                          _selectedImgPathList.add(imgFilePath);
//                        });
//                      });
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            Icons.camera_alt_outlined,
                            color: Color(0xff393a3b),
                            size: 29,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 图片选择
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      GlobalPhotoAlbum.open(context, (assetEntityList) async {
                        print("相册回传---${assetEntityList}");
                        for (AssetEntity assetEntity in assetEntityList) {
                          File file = await assetEntity.file;
                          String id = await assetEntity.id;
                          setState(() {
                            _selectedImgPathList.add(file.path);
                          });
                        }
                      });
//                      _openPhotoAlbum((String imgPathList) {
//                        print("回传---${imgPathList}");
//                        List<String> list =
//                        json.decode(imgPathList).cast<String>();
//                        for (String path in list) {
//                          setState(() {
//                            _selectedImgPathList.add(path);
//                          });
//                        }
//                        print("相册回传处理");
//                      });
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            FontAwesome.photo,
                            color: Color(0xff393a3b),
                            size: 23,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// @用户
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    onTap: () {
                      /// 前往@用户选择页
                      GlobalRouteTable.goSelectAtUserPage(context,
                          (String result) {
                        print("@回传数据--${result}");

                        /// 回传处理
                        Map selectedUserInfo = json.decode(result);

                        /// 用户id
                        String userId = selectedUserInfo["userId"].toString();

                        /// 用户名
                        String userName = selectedUserInfo["userName"];

                        ///注意加'空格'
                        setState(() {
                          /// 页面发生跳转会清空编辑区域,所以要加上之前的文本内容
                          String text = "@${userName} ";
                          insertText(_textEditingController.value.text + text);
                          _atUserIdList.add(userId);
                        });
                      });
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            FontAwesome.at,
                            color: Color(0xff393a3b),
                            size: 27,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 表情
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      if (isShowFaceSelect) {
                        /// 关闭表情,打开软键盘
                        setState(() {
                          isShowFaceSelect = false;
                        });
                        GlobalConst.showSoftKeyBoard(() {
                          print("打开软件盘");
                        });
                      } else {
                        /// 打开表情,关闭软键盘
                        setState(() {
                          isShowFaceSelect = true;
                        });
                        GlobalConst.hideSoftKeyBoard(() {
                          print("隐藏软键盘");
                        });
                      }
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            Icons.sentiment_satisfied_alt,
                            color: Color(0xff393a3b),
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 商品
                Expanded(
                  flex: 2,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      /// 前往商品选择页
                      GlobalRouteTable.goCommoditySelectPage(context, (result) {
                        print("选择的商品----${result}");
                      });
                    },
                    child: Column(
                      children: [
                        Center(
                          child: Icon(
                            Icons.shopping_bag_outlined,
                            color: Color(0xff393a3b),
                            size: 28,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          /// ---------------------------------------------------

          /// ----------------- 表情选择区域 start -----------------
          GestureDetector(
            onTap: () {},
            child: Container(
              height:
                  isShowFaceSelect ? GlobalConst.FACE_SELECT_AREA_HEIGHT : 0.0,
              child: Expanded(
                child: buildCustomKeyBoard(),
              ),
            ),
          ),

          /// ----------------- 表情选择区域 end -----------------
        ]),
      ),
    );
  }

  Widget buildCustomKeyBoard() {
    if (isShowFaceSelect) {
      return buildEmojiGird();
    }
    return Container();
  }

  /// 表情区域构建
  Widget buildEmojiGird() {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 11, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
          child:
              Image.asset(emoji.EmojiUitl.instance.emojiMap['[${index + 1}]']),
          behavior: HitTestBehavior.translucent,
          onTap: () {
            insertText('[${index + 1}]'); //添加文本
          },
        );
      },
      itemCount: emoji.EmojiUitl.instance.emojiMap.length,
      padding: const EdgeInsets.all(5.0),
    );
  }

  /// 插入文本
  void insertText(String text) {
    final TextEditingValue value = _textEditingController.value;
    final int start = value.selection.baseOffset;
    int end = value.selection.extentOffset;
    if (value.selection.isValid) {
      String newText = '';
      if (value.selection.isCollapsed) {
        if (end > 0) {
          newText += value.text.substring(0, end);
        }
        newText += text;
        if (value.text.length > end) {
          newText += value.text.substring(end, value.text.length);
        }
      } else {
        newText = value.text.replaceRange(start, end, text);
        end = start;
      }

      _textEditingController.value = value.copyWith(
          text: newText,
          selection: value.selection.copyWith(
              baseOffset: end + text.length, extentOffset: end + text.length));
    } else {
      _textEditingController.value = TextEditingValue(
          text: text,
          selection:
              TextSelection.fromPosition(TextPosition(offset: text.length)));
    }
  }

  /// 清空页面
  void _cleanPage() {
    setState(() {
      _textEditingController.clear();
      _selectedImgPathList.clear();
      _atUserIdList.clear();
      _joinGambitIdList.clear();
    });
  }
}
