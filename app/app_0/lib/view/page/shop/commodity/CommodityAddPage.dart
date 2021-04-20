import 'dart:convert';

/// -------------------------------
/// Des: 商品新增类
/// -------------------------------
import 'dart:io';
import 'dart:ui';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/media/GlobalCamera.dart';
import 'package:xhd_app/view/comm/media/GlobalPhotoAlbum.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/text/type/emoji_text.dart' as emoji;
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/button/OKButton.dart';
import 'package:xhd_app/view/widget/card/CommodityClassifyCard_1.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/comm/NumberKeyBoardWidget.dart';

class CommodityAddPage extends StatefulWidget {
  CommodityAddPage({Key key}) : super(key: key);

  @override
  _CommodityAddPageState createState() => _CommodityAddPageState();
}

class _CommodityAddPageState extends State<CommodityAddPage>
    with TickerProviderStateMixin {
  var _imgPath;
  File _imageFile;

  /// ------------------ 价格文本编辑控制 start ------------------
  /// 商品名称编辑区域控制器
  TextEditingController _commodityNameTextEditingController =
      TextEditingController();

  /// 当前正在编辑的文本编辑区的控制器
  TextEditingController _presentTextEditingController = TextEditingController();

  /// 价格文本控制器
  final TextEditingController _priceTextEditingController =
      TextEditingController();

  /// 价格文本控制器焦点对象
  final FocusNode _priceFocusNode = FocusNode();

  /// 运费文本控制器
  final TextEditingController _freightTextEditingController =
      TextEditingController();

  /// 运费文本控制器焦点对象
  final FocusNode _freightFocusNode = FocusNode();

  /// ------------------ 价格文本编辑控制 end ------------------

  /// 商品价格
  String _price = "0.00";

  /// 运费
  String _freight = "0.00";

  /// 价格编辑器高度
  double _priceEditerHeight = ScreenUtil.getInstance().screenHeight * 0.5;

  /// 商品描述编辑区提示
  String _hint = "说一说商品的描述";

  /// 网络接口调用
  GlobalNetApiCall _globalNetApiCall = GlobalNetApiCall();

  /// 是否显示表情标识符
  bool isShowFaceSelect = false;

  /// 全局key
  final GlobalKey _key = GlobalKey();

  /// 文本编辑器控制器
  static final TextEditingController _textEditingController =
      TextEditingController();

  /// 输入框焦点对象
  final FocusNode _focusNode = FocusNode();

  /// 选择的图片列表
  List<String> _selectedImgPathList = [];

  /// 选择的商品分类列表
  List<Widget> _selectedClassifyList = [];

  /// 选择的商品分类信息列表
  List<Map> _selectedClassifyInfoList = [];

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
//          return Container(
//            child: Image.file(
//              new File(_selectedImgPathList[index]),
//              fit: BoxFit.fill,
//            ),
//          );
          });
    } else {
      return Container();
    }
  }

  /// 是否添加定位
  bool _isAddLocal = false;

  /// 构建页
  Widget _buildPage() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return new Column(
              children: [
                /// 商品名称编辑区域
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  color: Colors.white,
                  alignment: Alignment.topLeft,
                  child: TextField(
                    maxLines: 1,
                    autofocus: false,
                    controller: _commodityNameTextEditingController,
                    decoration: InputDecoration(
                      hintText: "商品名称",
                      contentPadding: const EdgeInsets.all(12.0),
                      hintMaxLines: 1,
                      border: InputBorder.none,
                    ),
                    obscureText: false,
                  ),
                ),

                /// 商品描述编辑区域
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
                      hintText: "${_hint}",
                      hintMaxLines: 20,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                /// 图片预览区域
                Container(
                    padding: EdgeInsets.only(
                        left: 10, right: 10, top: 10, bottom: 15),
                    child: _buildSelectedImgPreView()),

                /// 添加定位
                Container(
                  padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        decoration: new BoxDecoration(
                          //背景
                          color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                          //设置四周圆角 角度
                          borderRadius: BorderRadius.all(Radius.circular(558)),
                        ),
                        padding: EdgeInsets.only(
                            left: 18, right: 18, top: 5, bottom: 5),
                        alignment: Alignment.centerRight,
                        margin: EdgeInsets.only(right: 20),
                        child: Text("添加定位",
                            style: TextStyle(
                                fontSize: 14,
                                color: Color(GlobalColor.SHALLOW_GRAY))),
                      ),
                    ],
                  ),
                ),

                /// 分类编辑区域
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    GlobalRouteTable.goCommoditySelectClassifyPage(context,
                        (String result) {
                      setState(() {
                        List mList = json.decode(result);
                        for (Map m in mList) {
                          _selectedClassifyInfoList.add(m);
                          _selectedClassifyList.add(CommodityClassifyCard_1(m));
                        }
                      });
                      print("商品分类选择----已选择的商品分类----${result}");
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              GlobalFilePath.TITLE_LOGO_16,
                              width: 20,
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(left: 10),
                              child:
                                  Text("分类选择", style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Text("选择", style: TextStyle(fontSize: 16)),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(GlobalColor.SHALLOW_GRAY),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                /// 分类选择显示区域
                Container(
                  margin: EdgeInsets.only(top: 10, left: 10, right: 10),
                  width: double.infinity,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(children: _selectedClassifyList),
                  ),
                ),

                /// 价格编辑区域
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    openPriceEditer(context);
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 20,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Image.asset(
                              GlobalFilePath.TITLE_LOGO_17,
                              width: 20,
                              height: 20,
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              margin: EdgeInsets.only(left: 10),
                              child: Text("价格", style: TextStyle(fontSize: 16)),
                            ),
                          ],
                        ),

                        /// 价格显示
                        Container(
                          child: Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text("${GlobalConst.PAY_UNIT}${_price}",
                                    style: TextStyle(
                                        fontSize: 18,
                                        color:
                                            Color(GlobalColor.APP_THEME_COLOR),
                                        fontWeight: FontWeight.w600)),
                              ),
                              Container(
                                margin: EdgeInsets.only(right: 10),
                                child: Text(
                                    "运费:(${GlobalConst.PAY_UNIT}${_freight})",
                                    style: TextStyle(fontSize: 15)),
                              ),
                              Icon(
                                Icons.arrow_forward_ios,
                                size: 16,
                                color: Color(GlobalColor.SHALLOW_GRAY),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
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

    /// 初始化登录用户id
    Future<num> loginUserIdFuture = GlobalLocalCache.getLoginUserId();
    loginUserIdFuture.then((value) {
      _loginUserId = value;
    });

    /// ----------------- 商品名称编辑 start -----------------

    _commodityNameTextEditingController.addListener(() {
      if (_commodityNameTextEditingController.hasListeners) {
        /// 打开软键盘
        GlobalConst.showSoftKeyBoard(() {});

        /// 关闭表情选择框
        setState(() {
          isShowFaceSelect = false;
        });
      }
    });

    /// ----------------- 商品名称编辑 end -----------------

    /// ----------------- 价格编辑事件配置 start -----------------
    _priceFocusNode.addListener(() {
      if (_priceFocusNode.hasFocus) {
        setState(() {
          _presentTextEditingController = _priceTextEditingController;
        });
      }
    });
    _freightFocusNode.addListener(() {
      if (_freightFocusNode.hasFocus) {
        setState(() {
          _presentTextEditingController = _freightTextEditingController;
        });
      }
    });

    /// ----------------- 价格编辑事件配置 end -----------------
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffffffff),
      appBar: PreferredSize(
          child: AppBar(
            actions: [
              OKButton(
                text: "发布",
                clickCallBack: () {
                  /// 商品名称
                  String commodityName =
                      _commodityNameTextEditingController.value.text;

                  /// 商品描述
                  String commodityDes = _textEditingController.value.text;

                  /// 选择的图片不能为空
                  if(_selectedImgPathList.length==0){
                    GlobalToast.showToast("请选择图片");
                    return;
                  }
                  /// 发布商品
                  GlobalLocalCache.getLoginUserInfo().then((loginUserInfo) {
                    Map userInfo = json.decode(loginUserInfo);
                    GlobalConst.NET_API_CALL.commentReleaseByUser(
                        userInfo['id'].toString(),
                        commodityName,
                        _price,
                        _freight,
                        commodityDes,
                        _selectedImgPathList,
                        _selectedClassifyInfoList);
                  });
                },
              ),
            ],
            title: Text(
              '商品发布',
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

                /// 图片选择GestureDetector
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
    });
  }

  /// 价格编辑器
  void openPriceEditer(BuildContext context) {
    /// 显示弹窗
    showModalBottomSheet<void>(
        backgroundColor: Colors.white,

        /// 圆角
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        isScrollControlled: true,
        //一：设为true，此时为全屏展示
        context: context,
        builder: (BuildContext context) {
          return Container(
            child: StatefulBuilder(builder: (context, setBoxState) {
              WidgetsBinding.instance.addPostFrameCallback((mag) {
                /// 获取价格焦点
                FocusScope.of(context).requestFocus(_priceFocusNode);
              });
              return Container(
                padding: EdgeInsets.only(top: 30, bottom: 30),
                height: _priceEditerHeight,
                child: Column(
                  children: [
                    /// 价格编辑区域
                    Container(
                      padding: EdgeInsets.only(left: 13, right: 13),
                      child: Column(
                        children: [
                          /// 价格
                          Row(
                            children: [
                              Text(
                                "价格",
                                style: TextStyle(fontSize: 16),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  focusNode: _priceFocusNode,
                                  controller: _priceTextEditingController,
                                  maxLines: 1,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: "${GlobalConst.PAY_UNIT}0.00",
                                    hintMaxLines: 1,
                                    border: InputBorder.none,
                                  ),
                                  obscureText: false,
                                ),
                              ),
                            ],
                          ),

                          /// 分隔线
                          Container(
                            margin: EdgeInsets.only(top: 6, bottom: 6),
                            width: double.infinity,
                            height: 1,
                            color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                          ),

                          /// 运费
                          Row(
                            children: [
                              Text("运费", style: TextStyle(fontSize: 16)),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextField(
                                  focusNode: _freightFocusNode,
                                  controller: _freightTextEditingController,
                                  maxLines: 1,
                                  autofocus: false,
                                  decoration: InputDecoration(
                                    hintText: "${GlobalConst.PAY_UNIT}0.00",
                                    hintMaxLines: 1,
                                    border: InputBorder.none,
                                  ),
                                  obscureText: false,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    /// 分割线
                    Container(
                      width: double.infinity,
                      height: 20,
                    ),

                    /// 数字键盘区域
                    Expanded(
                      flex: 2,
                      child: NumberKeyBoardWidget(
                        okBtnCallBack: () {
                          /// 商品价格
                          String price = _priceTextEditingController.text;

                          /// 运费
                          String freight = _freightTextEditingController.text;
                          setState(() {
                            _price = price;
                            _freight = freight;
                          });
                          Navigator.pop(context);
                        },
                        pushBackBtnBtnCallBack: () {
                          String showNumber =
                              _presentTextEditingController.text;
                          showNumber =
                              showNumber.substring(0, showNumber.length - 1);
                          _presentTextEditingController.value =
                              TextEditingValue(
                                  text: showNumber,
                                  selection: TextSelection.fromPosition(
                                      TextPosition(offset: showNumber.length)));
                        },
                        closeBtnCallBack: () {
                          Navigator.pop(context);
                        },
                        numberBtnCallBack: (String number) {
                          String showNumber =
                              _presentTextEditingController.text +
                                  number.toString();
                          _presentTextEditingController.value =
                              TextEditingValue(
                                  text: showNumber,
                                  selection: TextSelection.fromPosition(
                                      TextPosition(offset: showNumber.length)));
                        },
                        separateLineColor: Color(GlobalColor.MAX_SHALLOW_GRAY),
                      ),
                    ),
                  ],
                ),
              );
            }),
          );
        });
  }
}
