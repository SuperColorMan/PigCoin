import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cached_network_image/cached_network_image.dart';

/// ----------------------------------
/// des: 私信对话框页
/// ----------------------------------
import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/model/im/ChatModel.dart';
import 'package:xhd_app/view/comm/enums/GlobalChatContentTypeEnum.dart';
import 'package:xhd_app/view/comm/im/ImCommManager.dart';
import 'package:xhd_app/view/comm/media/GlobalCamera.dart';
import 'package:xhd_app/view/comm/media/GlobalPhotoAlbum.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'dart:ui';

import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/text/type/emoji_text.dart' as emoji;
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';
import 'package:xhd_app/view/widget/card/CommodityCard_1.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/im/ByChatItem.dart';
import 'package:xhd_app/view/widget/im/ChatItem.dart';

class ChatDialogBoxPage extends StatefulWidget {
  /// 私信的对方用户信息
  Map byUserInfo;

  ChatDialogBoxPage(this.byUserInfo, {Key key}) : super(key: key);

  @override
  _ChatDialogBoxPageState createState() => _ChatDialogBoxPageState();
}

//页面状态配置,用于动态修改页面数据,页面事件等。
class _ChatDialogBoxPageState extends State<ChatDialogBoxPage>
    with TickerProviderStateMixin {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  ScrollController _scrollController = ScrollController();

  /// 下拉刷新
  void _onRefresh() async {
    /// 释放刷新状态
    _refreshController.refreshCompleted();
  }

  /// 上拉加载
  void _onLoading() async {
    /// 释放加载状态
    _refreshController.loadComplete();
  }

  /// 私信条目列表
  List<Widget> _chatItemList = [];

  /// 选择图片类表
  List<String> _selectedImgPathList = [];

  /// 文本编辑器控制器
  static final TextEditingController _textEditingController =
      TextEditingController();

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

  /// 获取刷新列表
  SmartRefresher _listView;

  Widget _getChatItemListWidget() {
    _listView = SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(
        waterDropColor: Color(GlobalColor.APP_THEME_COLOR),
      ),
      footer: CustomFooter(
        builder: (BuildContext context, LoadStatus mode) {
          Widget body;
          if (mode == LoadStatus.idle) {
            body = Text("pull up load");
          } else if (mode == LoadStatus.loading) {
            body = CircularProgressIndicator();
          } else if (mode == LoadStatus.failed) {
            body = Text("Load Failed!Click retry!");
          } else if (mode == LoadStatus.canLoading) {
            body = Text("release to load more");
          } else {
            body = Text("No more Data");
          }
          return Container(
            height: 55.0,
            child: Center(child: body),
          );
        },
      ),
      controller: _refreshController,
      onRefresh: _onRefresh,
      onLoading: _onLoading,
      child: ListView.builder(
          controller: _scrollController,
          itemCount: _chatItemList.length,
          itemBuilder: (context, i) {
            return _chatItemList[i];
          }),
    );
    return _listView;
  }

  ///-------------编辑框相关配置-------------
  /// 输入框焦点对象
  final FocusNode _focusNode = FocusNode();

  ///---------------------------------------
  ///------------- 是否显示功能区标识符 start -------------
  bool _isShowFunctionArea = false;

  ///------------- 是否显示功能区标识符 end -------------
  ///------------- 是否显示表情区标识符 start -------------
  bool _isShowFaceSelect = false;

  ///------------- 是否显示表情区标识符 start -------------

  /// 初始化
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 监听服务端的推送
    ImCommManager.channel.stream.listen((message) {
      setState(() {
        Map _messageMap = jsonDecode(message);
        print("私信内容类型-----${_messageMap['type'].toString()}");
        if (_messageMap['type'].toString() ==
            GlobalChatContentTypeEnum.TEXT.index.toString()) {
          Map messageMap = jsonDecode(message);

          /// 纯文字私信
          _chatItemList.add(ByChatItem(
            GlobalChatContentTypeEnum.TEXT.index,
            text: "${messageMap['content'].toString()}",
          ));
        } else if (_messageMap['type'].toString() ==
            GlobalChatContentTypeEnum.NETIMG.index.toString()) {
          Map messageMap = jsonDecode(message);

          /// 网络图片私信信息
          _chatItemList.add(ByChatItem(
            GlobalChatContentTypeEnum.NETIMG.index,
            netImg: messageMap['tImChatImage'],
          ));
        } else if (_messageMap['type'].toString() ==
            GlobalChatContentTypeEnum.COMMODITY.index.toString()) {
          Map messageMap = jsonDecode(message);

          /// 商品信息私信信息
          _chatItemList.add(ByChatItem(
            GlobalChatContentTypeEnum.COMMODITY.index,
            text: "${message}",
          ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    /// ------------------- 更多功能按钮 start -------------------
    List<Widget> _moreBtnList = [
      /// 相册
      GestureDetector(
        onTap: () {
          GlobalPhotoAlbum.open(context, (assetEntityList) async {
            print("相册回传---${assetEntityList}");
            List<File> _selectedFile = [];
            for (AssetEntity assetEntity in assetEntityList) {
              File file = await assetEntity.file;
              String id = await assetEntity.id;

              /// 文件码流
              Uint8List uint8List = file.readAsBytesSync();
              String _fileBase64 = base64.encode(uint8List);

              /// 私信数据模型
              ChatModel _chatModel = ChatModel(
                  "1",
                  "1",
                  GlobalChatContentTypeEnum.LOCALIMG.index.toString(),
                  _fileBase64);

              print("私信模型----${_chatModel}");

              /// 发送内容
              ImCommManager.channel.sink.add(_chatModel.toString());

              setState(() {
                _chatItemList.add(ChatItem(
                  GlobalChatContentTypeEnum.LOCALIMG.index,
                  localImg: file,
                ));
              });
            }
            setState(() {
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent + 20);
            });
          });
        },
        child: Container(
          decoration: new BoxDecoration(
            //背景
            color: Color(GlobalColor.MAX_SHALLOW_GRAY),
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(4.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.image_outlined,
                size: 28,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("相册"),
              ),
            ],
          ),
        ),
      ),

      /// 相机
      GestureDetector(
        onTap: () {
          /// 打开相机
          GlobalCamera.open(context, (assetEntity) async {
            File file = await assetEntity.file;
            String id = await assetEntity.id;
            _listView.createState().setState(() {
              _chatItemList.add(ChatItem(
                GlobalChatContentTypeEnum.LOCALIMG.index,
                localImg: file,
              ));
              _scrollController
                  .jumpTo(_scrollController.position.maxScrollExtent + 20);
            });
          });
        },
        child: Container(
          decoration: new BoxDecoration(
            //背景
            color: Color(GlobalColor.MAX_SHALLOW_GRAY),
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.camera_alt_outlined,
                size: 28,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("相机"),
              ),
            ],
          ),
        ),
      ),

      /// 商品
      GestureDetector(
        onTap: () {
          GlobalRouteTable.goCommoditySelectPage(context, (String result) {
            /// 选择商品的id列表
            List selectedCommodityIdList = json.decode(result).cast<String>();
            setState(() {
              for (String id in selectedCommodityIdList) {
                _chatItemList.add(ChatItem(
                  GlobalChatContentTypeEnum.COMMODITY.index,
                  commodity: Map(),
                ));
              }
            });
            print("已选择商品的id列表------${selectedCommodityIdList}");
          });
        },
        child: Container(
          decoration: new BoxDecoration(
            //背景
            color: Color(GlobalColor.MAX_SHALLOW_GRAY),
            //设置四周圆角 角度
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.shopping_bag_outlined,
                size: 28,
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text("商品"),
              ),
            ],
          ),
        ),
      ),
    ];

    /// ------------------- 更多功能按钮 end -------------------

    /// ------------------- 构建功能区域 start -------------------

    Widget _buildFunctionArea() {
      if (_isShowFunctionArea) {
        return Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 18, bottom: 10),
          height: 100,
          width: double.infinity,
          color: Colors.white,
          child: Expanded(
            child: GridView.builder(
                padding: EdgeInsets.only(top: 0),
                physics: NeverScrollableScrollPhysics(),
                //禁止滑动
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    //横轴元素个数
                    crossAxisCount: 5,
                    //纵轴间距
                    mainAxisSpacing: 15.0,
                    //横轴间距
                    crossAxisSpacing: 15.0,
                    //子组件宽高长度比例
                    childAspectRatio: 1.0),
                itemCount: _moreBtnList.length,
                itemBuilder: (BuildContext context, int index) {
                  //Widget Function(BuildContext context, int index)
                  return _moreBtnList[index];
                }),
          ),
        );
      } else {
        return Container();
      }
    }

    /// ------------------- 构建功能区域 end -------------------

    /// ------------------- 构建表情区域 start -------------------
    /// 表情区域构建
    Widget buildEmojiGird() {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 11, crossAxisSpacing: 8.0, mainAxisSpacing: 8.0),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            child: Image.asset(
                emoji.EmojiUitl.instance.emojiMap['[${index + 1}]']),
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

    Widget _buildCustomKeyBoard() {
      if (_isShowFaceSelect) {
        return buildEmojiGird();
      }
      return Container();
    }

    /// ------------------- 构建表情区域 end -------------------

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: ClipOval(
          child: CachedNetworkImage(
            imageUrl: '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=1',
            fit: BoxFit.fill,
            width: 35,
            height: 35,
            // color: Colors.black
          ),
        ),
        leading: GestureDetector(
          onTap: () {},
          child: Icon(
            Icons.arrow_back_ios,
            color: Color(GlobalColor.SHALLOW_GRAY),
          ),
        ),
      ),
      body: GestureDetector(
        onTap: () {
          setState(() {
            /// 关闭功能区
            _isShowFunctionArea = false;
            _isShowFaceSelect = false;
          });

          /// 关闭软键盘
          GlobalConst.hideSoftKeyBoard(() {
            print("关闭软键盘");
          });
        },
        child: Container(
          color: Color(GlobalColor.MAX_SHALLOW_GRAY),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Flexible(child: _getChatItemListWidget()),

              /// ----------------- 编辑框区域 start -----------------
              Container(
                color: Colors.white,
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 30,
                ),
                child: Column(
                  children: [
                    /// -------------- 操作栏 start --------------
                    Container(
                      padding: EdgeInsets.only(left: 10, right: 10),
                      child: Row(
                        children: [
                          /// 表情
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              if (_isShowFaceSelect) {
                                /// 关闭表情,打开软键盘
                                setState(() {
                                  _isShowFaceSelect = false;
                                  _isShowFunctionArea = false;
                                });
                                GlobalConst.showSoftKeyBoard(() {
                                  print("打开软件盘");
                                });
                              } else {
                                /// 打开表情,关闭软键盘
                                setState(() {
                                  _isShowFaceSelect = true;
                                  _isShowFunctionArea = false;
                                });
                                GlobalConst.hideSoftKeyBoard(() {
                                  print("隐藏软键盘");
                                });
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 5),
                              child: Icon(
                                Icons.sentiment_satisfied_alt,
                                size: 30,
                                color: Color(GlobalColor.SHALLOW_GRAY),
                              ),
                            ),
                          ),

                          /// 打开功能区
                          GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              print("打开功能区");
                              setState(() {
                                /// 打开功能区
                                _isShowFunctionArea = true;
                                _isShowFaceSelect = false;
                                GlobalConst.hideSoftKeyBoard(() {});
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.add_circle_outline_sharp,
                                size: 30,
                                color: Color(GlobalColor.SHALLOW_GRAY),
                              ),
                            ),
                          ),

                          /// 评论编辑
                          Expanded(
                            child: ExtendedTextField(
                              onTap: () {
                                /// 打开键盘
                                GlobalConst.showSoftKeyBoard(() {
                                  setState(() {
                                    /// 关闭功能区
                                    _isShowFunctionArea = false;
                                    _isShowFaceSelect = false;
                                  });
                                });
                              },
                              specialTextSpanBuilder:
                                  GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
                              controller: _textEditingController,
                              maxLines: null,
                              focusNode: _focusNode,
                              decoration: InputDecoration(
                                hintText: '',
                                border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                ),
                                // 是否使用填充色
                                filled: true,
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 10),
                                hintMaxLines: 20,
                              ),
                            ),
                          ),

                          /// 发送按钮
                          GestureDetector(
                            onTap: () {
                              /// 发送文本
                              String body = _textEditingController.value.text;
                              GlobalLocalCache.getLoginUserId()
                                  .then((loginUserId) {
                                setState(() {
                                  _chatItemList.add(ChatItem(
                                    GlobalChatContentTypeEnum.TEXT.index,
                                    text: body,
                                  ));
                                  _scrollController.jumpTo(_scrollController
                                          .position.maxScrollExtent +
                                      20);

                                  /// 清空内容
                                  _textEditingController.clear();
                                });

                                /// 私信数据模型
                                ChatModel _chatModel = ChatModel(
                                    "1",
                                    "1",
                                    GlobalChatContentTypeEnum.TEXT.index
                                        .toString(),
                                    body);

                                /// 发送内容
                                ImCommManager.channel.sink
                                    .add(_chatModel.toString());
                                if (loginUserId > 0) {
                                } else {
                                  GlobalToast.showToast("请先登录!");
                                }
                              });
                            },
                            child: Container(
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                              //设置 child 居中
                              alignment: Alignment(0, 0),
                              height: 38,
                              width: 78,
                              //边框设置
                              decoration: new BoxDecoration(
                                //背景
                                color: Color(GlobalColor.APP_THEME_COLOR),
                                //设置四周圆角 角度
                                borderRadius:
                                    BorderRadius.all(Radius.circular(4.0)),
                              ),
                              child: Text(
                                "发 送",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 15),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    /// -------------- 操作栏 end --------------

                    /// -------------- 功能区 start --------------
                    _buildFunctionArea(),

                    /// -------------- 功能区 end --------------
                    /// ----------------- 表情选择区域 start -----------------
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: EdgeInsets.only(top: 10),
                        height: _isShowFaceSelect
                            ? GlobalConst.FACE_SELECT_AREA_HEIGHT
                            : 0.0,
                        child: Expanded(
                          child: _buildCustomKeyBoard(),
                        ),
                      ),
                    ),

                    /// ----------------- 表情选择区域 end -----------------
                  ],
                ),
              ),

              /// ----------------- 编辑框区域 end -----------------
            ],
          ),
        ),
      ),
    );
  }
}
