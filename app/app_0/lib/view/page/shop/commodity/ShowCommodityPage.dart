import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:like_button/like_button.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/anim/PageRouteAnimation.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/media/GlobalCamera.dart';
import 'package:xhd_app/view/comm/media/GlobalPhotoAlbum.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';
import 'package:xhd_app/view/comm/utils/StringUtil.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/comment/CommentItem.dart';
import 'package:xhd_app/view/page/search/SearchHomePage.dart';
import 'package:xhd_app/view/page/user/EditUserInfoPage.dart';
import 'package:xhd_app/view/comm/text/type/emoji_text.dart' as emoji;
/// ----------------------------------
/// des: 商品详情页
/// ----------------------------------

class ShowCommodityPage extends StatefulWidget {
  /// 商品信息
  Map commodityInfo;

  ShowCommodityPage(this.commodityInfo);

  @override
  _ShowCommodityPageState createState() => _ShowCommodityPageState();
}

class _ShowCommodityPageState extends State<ShowCommodityPage> {
  ///  公共接口调用工具类
  GlobalNetApiCall _globalNetApiCall = GlobalNetApiCall();

  /// 是否显示表情标识符
  bool _isShowFaceSelect = false;

  ///-------------编辑标识符-------------
  bool _isEditeStatus = false;

  ///----------------------------------

  ///-------------编辑框相关配置-------------
  /// 输入框焦点对象
  final FocusNode _focusNode = FocusNode();

  ///---------------------------------------

  /// ---------------------- 评论条目列表 ----------------------
  List<Widget> _commentItemList = [];

  /// -----------------------------------------------------
  /// 全局key
  final GlobalKey _key = GlobalKey();

  /// 文本编辑器控制器
  final TextEditingController _textEditingController = TextEditingController();

  List list = [];

  ScrollController _scrollController;

  RefreshController _refreshController =
  RefreshController(initialRefresh: false);

  void _onRefresh() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    // monitor network fetch
    await Future.delayed(Duration(milliseconds: 1000));
    // if failed,use loadFailed(),if no data return,use LoadNodata()
    if (mounted) setState(() {});
    _refreshController.loadComplete();
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

  /// ------------------ 构建选择图片预览区域 start ------------------
  /// 是否显示图片选择预览区域
  bool _isShowSelectedImgPreView = false;

  /// 评论中已经选择图片
  List<String> _commentSelectedImgList = [];

  Widget _buildSelectedImgPreView() {
    if (_isShowSelectedImgPreView) {
      return Container(
        height: 70,
        child: Container(
          height: 50,
          width: double.infinity,
          padding: EdgeInsets.only(top: 5, bottom: 5, right: 10),
          child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraints) {
              return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: _commentSelectedImgList.length,
                  itemBuilder: (context, i) {
                    return Container(
                      width: 60,
                      height: 50,
                      margin: EdgeInsets.only(left: 10),
                      child: Stack(
                        children: [
                          Image.file(
                            File(_commentSelectedImgList[i]),
                            width: 60,
                            height: 60,
                            fit: BoxFit.fill,
                          ),
                          Positioned(
                            width: 20,
                            height: 20,
                            right: 0,
                            child: GestureDetector(
                              onTap: () {
                                /// 删除指定对象
                                setState(() {
                                  _commentSelectedImgList.removeAt(i);
                                });
                                if (_commentSelectedImgList.length == 0) {
                                  setState(() {
                                    _isShowSelectedImgPreView = false;
                                  });
                                }
                              },
                              child: Container(
                                alignment: Alignment.center,
                                width: 20,
                                height: 20,
                                color: Color(0x80000000),
                                child: Icon(
                                  Icons.clear,
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  });
            },
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  /// ------------------ 构建选择图片预览区域 start ------------------

  /// ------------------ 表情区域构建 start ------------------
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

  /// ------------------ 表情区域构建 end ------------------
  
  /// -------------- 构建AppBar Title --------------
  bool _buildAppBarTitleStatus = false;

  Widget _buildAppBarTitle() {
    if (_buildAppBarTitleStatus) {
      /// 用户信息
      return Container(
        padding: EdgeInsets.only(right: 10),
        child: Row(
          children: [
            /// 头像
            Expanded(
                flex: 2,
                child: Center(
                  child: ClipOval(
                    child: CachedNetworkImage(
                      imageUrl:
                      'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=1056629638,148331236&fm=26&gp=0.jpg',
                      fit: BoxFit.cover,
                      width: 35,
                      height: 35,
                      // color: Colors.black
                    ),
                  ),
                )),

            ///用户信息
            Expanded(
                flex: 8,
                child: Column(
                  children: [
                    ///用户名
                    Container(
                        margin: EdgeInsets.only(left: 5),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(right: 0),
                        child: Text(
                          "${_userName}",
                          textAlign: TextAlign.left,
                          softWrap: true,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        )),

                    ///发送时间等信息
                    Container(
                      margin: EdgeInsets.only(left: 5),
                      child: Row(
                        children: [
                          Text("4小时前 · 9万次阅读量",
                              style: TextStyle(
                                fontSize: 13,
                                color: new Color(0xffa6a7a8),
                              )),
                        ],
                      ),
                    ),
                  ],
                )),

            /// 关注按钮
            Expanded(
                flex: 3,
                child: Container(
                  child: Center(
                    child: FlatButton(
                      height: 30,
                      splashColor: Colors.black87,
                      child: Text(
                        '购买',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      ),
                      onPressed: () {
                        /// 执行关注
                      },
                      color: Color(GlobalColor.APP_THEME_COLOR),
                    ),
                  ),
                )),
          ],
        ),
      );
    } else {
      /// 标题
      return Text(
        '${_userName}',
        style: TextStyle(color: Colors.black87),
      );
    }
  }

  /// ----------------------------------------------

  /// -------------- 网络请求相关参数 start --------------
  String page = "1";
  String pageSize = "10";

  /// -------------- 网络请求相关参数 end --------------

  ///------------- 评论上传相关参数-------------
  String _loginUserId = "1";
  List<num> _commentAtUserIdList = [];

  ///---------------------------------------

  /// --------------------- 页面初始化 start----------------------
  /// 页面初始化信息
  /// 内容发送者用户id
  String _userId = "";

  /// 内容发送者用户名称呢过
  String _userName = "";

  /// 内容发送者用户头像
  String _userHeadImg = "";

  /// 内容id
  String _contentId = "";

  /// 内容正文
  String _contentBody = "";

  /// 内容发送时间
  String _contentSendTime = "";

  /// 内容浏览次数
  String _contentLookCount = "0";

  /// 内容图片列表
  List<Widget> _contentImgList = [];

  /// 内容加入话题的标签列表
  List<Widget> _contentJoinGambitTagList = [];

  /// 关联商品区域
  Widget relCommodityArea = Container();

  /// 页面初始化方法
  void _initPage(StateSetter setState) {
    /// 初始化内容页信息
    /// 内容发送者用户信息
    setState(() {
      Map _userInfo = widget.commodityInfo['tuUser'];

      /// 内容发送者用户id
      _userId = _userInfo['id'].toString();

      /// 内容发送者用户名
      _userName = _userInfo['name'].toString();

      /// 内容id
      _contentId = widget.commodityInfo['id'].toString();

      /// 内容发送者用户头像url
      _userHeadImg =
      '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}';

      /// 内容正文
      _contentBody = widget.commodityInfo['body'].toString();

      /// 内容互动信息
      Map tcInteractionInfo = widget.commodityInfo['tcInteractionInfo'];

      /// 内容浏览次数
      int lookCount =
      tcInteractionInfo != null ? tcInteractionInfo['lookCount'] : 0;
      _contentLookCount = StringUtil.setNumberUnits(lookCount);

      /// 发送时间
      _contentSendTime = !TextUtil.isEmpty(widget.commodityInfo['diffTime'].toString())
          ? widget.commodityInfo['diffTime'].toString()
          : widget.commodityInfo['createTime'].toString();

      /// 内容中图片列表
      List<Map> _imgList = widget.commodityInfo['imgList'].cast<Map>();
      for (Map imgInfo in _imgList) {
        Widget imgItem = Container(
          padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
          child: CachedNetworkImage(
            imageUrl:
            '${GlobalApiUrlTable.GET_CONTENT_IMG}?id=${imgInfo['id']}',
          ),
        );
        _contentImgList.add(imgItem);
      }
    });

    /// 忽略评论id列表
    List<String> filter = [];

    /// -------------------- 初始化热门评论列表 start --------------------
    Future<Map<String, dynamic>> hotCommentResMap =
    _globalNetApiCall.getHotCommentListByContentId(
        _contentId.toString(), _contentId.toString());
    hotCommentResMap.then((value) {
      print('热门评论----${value['code']}');
      String code = value['code'].toString();
      if (code == '0') {
        List<Map> _hotCommentList = value['data'].cast<Map>();
        print("热门评论条目----${_hotCommentList.toString()}");
        setState(() {
          for (Map hotComment in _hotCommentList) {
            print("热门评论条目----${hotComment.toString()}");
            filter.add(hotComment['id'].toString());
            _commentItemList.add(CommentItem(
              hotComment,
              isShowHotCommentBadge: true,
            ));
          }
        });
      } else if (code == 1) {
        GlobalToast.showToast("热门评论加载失败");
      }

      /// -------------------- 初始化热门评论列表 end --------------------

      /// -------------------- 初始化评论列表 start --------------------
      Future<Map<String, dynamic>> resMap =
      _globalNetApiCall.getCommentListByContentId(_contentId.toString(),
          _userId.toString(), page, pageSize, filter);
      resMap.then((value) {
        print("评论列表-----${value}");

        int code = value['code'];
        if (code == 0) {
          GlobalToast.showToast("评论获取成功");

          /// 结果集内容列表
          List<Map> commentList = value['data'].cast<Map>();
          print("热门评论条目----${commentList.length}");

          setState(() {
            for (Map comment in commentList) {
              /// 构建评论项
              _commentItemList.add(CommentItem(comment));
            }
          });
        } else if (code == 1) {
          GlobalToast.showToast("评论获取失败");
        }
        print("评论响应结果集---${value.toString()}");
      });

      /// -------------------- 初始化评论列表 start --------------------
    });

    ///  -------------------- 查看内容计数 start --------------------
    Future<num> localCache =
    // ignore: missing_return
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
          .contentLook(_contentId, loginUserId.toString(), _userId);
      resMap.then((value) {
        /// 回传处理 ....
      });
    });

    ///  -------------------- 查看内容计数 start --------------------
  }

  /// --------------------- 页面初始化 end----------------------

  @override
  void dispose() {
    super.dispose();
    _scrollController.dispose();
  }

  Future _loadMore() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list.addAll(
            List.generate(Random().nextInt(5) + 1, (i) => 'more Item $i'));
      });
    });
  }

  Future<void> _refresh() async {
    await Future.delayed(Duration(seconds: 3), () {
      setState(() {
        list = List.generate(Random().nextInt(20) + 15, (i) => 'Item $i');
      });
    });
  }

  /// 构建内容页
  Widget _buildContentPage() {
    return StatefulBuilder(builder: (context, setState) {
      return new Column(children: <Widget>[
        /// ----------------- 页面主题区域 start -----------------
        new Flexible(
          child: SmartRefresher(
            enablePullDown: false,
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
                itemCount: 1,
                itemBuilder: (context, i) {
                  return new Container(
                    padding: EdgeInsets.only(top: 10),
                    color: Colors.white,
                    child: Column(children: [
                      ///用户信息
                      Container(
                        padding: EdgeInsets.only(right: 10),
                        child: Row(
                          children: [
                            /// 头像
                            Expanded(
                                flex: 2,
                                child: Center(
                                  child: ClipOval(
                                    child: CachedNetworkImage(
                                      imageUrl: '${_userHeadImg}',
                                      fit: BoxFit.fill,
                                      width: 35,
                                      height: 35,
                                      // color: Colors.black
                                    ),
                                  ),
                                )),

                            ///用户信息
                            Expanded(
                                flex: 9,
                                child: Column(
                                  children: [
                                    ///用户名
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        padding: EdgeInsets.only(right: 0),
                                        child: Text(
                                          "${_userName}",
                                          textAlign: TextAlign.left,
                                          softWrap: true,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          style: TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        )),

                                    ///发送时间等信息
                                    Container(
                                      child: Row(
                                        children: [
                                          Text(
                                              "${_contentSendTime} · ${_contentLookCount}次阅读量",
                                              style: TextStyle(
                                                fontSize: 13,
                                                color: new Color(0xffa6a7a8),
                                              )),
                                        ],
                                      ),
                                    ),
                                  ],
                                )),

                            /// 关注按钮
                            Expanded(
                                flex: 3,
                                child: Container(
                                  padding: EdgeInsets.only(left: 10, right: 0),
                                  child: Center(
                                    child: FlatButton(
                                      splashColor: Colors.black87,
                                      child: Text(
                                        '购买',
                                        style: TextStyle(color: Colors.white),
                                      ),
                                      onPressed: () {
                                        //跳转到个人页
                                        Navigator.push(
                                            context,
                                            CustomRouteJianBian(
                                                EditUserInfoPage()));
                                      },
                                      color: Color(GlobalColor.APP_THEME_COLOR),
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ),

                      ///内容文本
                      Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 10),
                        child: ExtendedText(
                          '${_contentBody}',
                          textAlign: TextAlign.left,
                          specialTextSpanBuilder:
                          GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
                          onSpecialTextTap: (dynamic value) {
                            if (value.toString().startsWith('\$')) {
                              //以$开头
                              print("美元");
                            } else if (value.toString().startsWith('@')) {
                              //以@开头
                              print("哈哈哈哈哈");
                            }
                          },
                        ),
                      ),

                      ///内容图片
                      Container(
                        child: Column(
                          children: _contentImgList,
                        ),
                      ),

                      /// ---------------------- 话题区域 ----------------------
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 10, bottom: 5),
                        child: Wrap(
                          alignment: WrapAlignment.start,
                          //布局方向
                          direction: Axis.horizontal,
                          spacing: 10,
                          runSpacing: 10,
                          children: _contentJoinGambitTagList,
                        ),
                      ),

                      /// ----------------------------------------------------
                      /// ---------------------- 绑定的关联商品区域 start----------------------
                      relCommodityArea,
                      /// ---------------------- 绑定的关联商品区域 end----------------------

                      /// 分割线
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 5,
                        color: new Color(0xfff4f5f6),
                      ),

                      /// ---------------------- 评论区域标题 ----------------------
                      /// 评论区域标题
                      Container(
                        padding: EdgeInsets.only(
                            top: 15, bottom: 15, left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              child: Text(
                                "评论",
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w600),
                              ),
                            ),
                            Container(
                              child: Row(
                                children: [
                                  /// 点赞人数
                                  Container(
                                    child: Row(
                                      children: [
                                        Image.asset(
                                          GlobalFilePath.TITLE_LOGO_6,
                                          width: 25,
                                          height: 25,
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(left: 6),
                                          child: Text("10000点赞"),
                                        ),
                                      ],
                                    ),
                                  ),

                                  /// 分割线
                                  Container(
                                    margin:
                                    EdgeInsets.only(left: 10, right: 10),
                                    child: Container(
                                      width: 1,
                                      height: 20,
                                      color:
                                      Color(GlobalColor.MAX_SHALLOW_GRAY),
                                    ),
                                  ),

                                  /// 收藏人数
                                  Container(
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Image.asset(
                                              GlobalFilePath.TITLE_LOGO_7,
                                              width: 25,
                                              height: 25,
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(left: 6),
                                              child: Text("10000收藏"),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// ----------------------------------------------------
                      /// 分割线
                      Container(
                        height: 1,
                        color: new Color(0xfff4f5f6),
                      ),

                      /// 评论区域
                      Container(
                        padding: EdgeInsets.only(bottom: 28),
                        child: Column(children: _commentItemList),
                      )
                    ]),
                  );
                }),
          ),
        ),

        /// ----------------- 页面主题区域 start -----------------
        /// 分隔线
        new Divider(height: 1.0),

        /// ----------------- 编辑框区域 start -----------------
        Container(
          padding: EdgeInsets.only(bottom: 10),
          child: Column(
            children: [
              /// 选择发送图片预览区域
              _buildSelectedImgPreView(),

              /// 操作栏
              Container(
                padding:
                EdgeInsets.only(top: 6, bottom: 0, left: 10, right: 10),
                child: Row(
                  children: [
                    /// 评论编辑
                    Expanded(
                      flex: 9,
                      child: ExtendedTextField(
                        key: _key,
                        onTap: () {
                          /// 关闭表情选择
                          setState(() {
                            _isShowFaceSelect = false;
                            _isEditeStatus = true;
                          });

                          /// 打开键盘
                          GlobalConst.showSoftKeyBoard(() {
                            print("打开键盘");
                          });
                        },
                        specialTextSpanBuilder:
                        GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
                        controller: _textEditingController,
                        maxLines: null,
                        focusNode: _focusNode,
                        decoration: InputDecoration(
                          hintText: '说点什么......',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(35),
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

                    /// 点赞按钮
                    Visibility(
                      visible: !_isEditeStatus,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Center(
                              child: LikeButton(
                                onTap: (bool isLiked) {
                                  final Completer<bool> completer =
                                  new Completer<bool>();
                                  completer.complete(isLiked ? false : true);
                                  return completer.future;
                                },
                                countBuilder:
                                    (int count, bool isLiked, String text) {
                                  var color = isLiked
                                      ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
                                      : Color(
                                      GlobalColor.GOOD_NOT_PITCH_ON_COLOR);
                                  Widget result;
                                  result = Text(
                                    text,
                                    style:
                                    TextStyle(color: color, fontSize: 15),
                                  );
                                  return result;
                                },
                                likeCount: 0,
                                countPostion: CountPostion.bottom,
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.thumb_up_alt_outlined,
                                    size: 25,
                                    color: isLiked
                                        ? Color(GlobalColor.GOOD_PITCH_ON_COLOR)
                                        : Color(GlobalColor
                                        .GOOD_NOT_PITCH_ON_COLOR),
                                  );
                                },
                                circleColor: CircleColor(
                                    start:
                                    Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                                    end:
                                    Color(GlobalColor.GOOD_PITCH_ON_COLOR)),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: Color(
                                      GlobalColor.GOOD_PITCH_ON_TRAN_COLOR),
                                  dotSecondaryColor:
                                  Color(GlobalColor.GOOD_PITCH_ON_COLOR),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// 收藏按钮
                    Visibility(
                      visible: !_isEditeStatus,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Center(
                              child: LikeButton(
                                countBuilder:
                                    (int count, bool isLiked, String text) {
                                  var color = isLiked
                                      ? Color(GlobalColor.COLL_PITCH_ON_COLOR)
                                      : Color(
                                      GlobalColor.COLL_NOT_PITCH_ON_COLOR);
                                  Widget result;
                                  result = Text(
                                    text,
                                    style:
                                    TextStyle(color: color, fontSize: 15),
                                  );
                                  return result;
                                },
                                likeCountPadding: EdgeInsets.only(top: 1),
                                likeCount: 0,
                                countPostion: CountPostion.bottom,
                                likeBuilder: (bool isLiked) {
                                  return Icon(
                                    Icons.star_border,
                                    color: isLiked
                                        ? Color(GlobalColor.COLL_PITCH_ON_COLOR)
                                        : Color(GlobalColor
                                        .COLL_NOT_PITCH_ON_COLOR),
                                    size: 28,
                                  );
                                },
                                circleColor: CircleColor(
                                    start:
                                    Color(GlobalColor.COLL_PITCH_ON_COLOR),
                                    end:
                                    Color(GlobalColor.COLL_PITCH_ON_COLOR)),
                                bubblesColor: BubblesColor(
                                  dotPrimaryColor: Color(
                                      GlobalColor.COLL_PITCH_ON_TRAN_COLOR),
                                  dotSecondaryColor:
                                  Color(GlobalColor.COLL_PITCH_ON_COLOR),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// 分享按钮
                    Visibility(
                      visible: !_isEditeStatus,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.share_outlined,
                                color: Color(0xff393a3b),
                                size: 25,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(top: 3),
                              child: Center(
                                  child: Text(
                                    "分享",
                                    style: TextStyle(
                                      color: Color(0xff393a3b),
                                      fontSize: 13,
                                    ),
                                  )),
                            ),
                          ],
                        ),
                      ),
                    ),

                    /// 发送按钮
                    Visibility(
                      visible: _isEditeStatus,
                      child: GestureDetector(
                        onTap: () {
                          String body = _textEditingController.value.text;
                          GlobalLocalCache.getLoginUserId().then((loginUserId) {
                            if (loginUserId > 0) {
                              GlobalConst.NET_API_CALL.commentContent(
                                  loginUserId.toString(),
                                  _userId,
                                  _userName,
                                  _contentId,
                                  body,
                                  _commentSelectedImgList,
                                  _commentAtUserIdList);
                            } else {
                              GlobalToast.showToast("请先登录!");
                            }
                          });
                        },
                        child: Container(
                          margin: EdgeInsets.only(left: 10, right: 10),
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
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// 评论时功能栏
              Visibility(
                visible: _isEditeStatus,
                child: Container(
                  padding:
                  EdgeInsets.only(top: 15, bottom: 0, left: 10, right: 150),
                  child: Row(
                    children: [
                      /// 图片选择
                      Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              GlobalPhotoAlbum.open(context,
                                      (assetEntityList) async {
                                    print("相册回传---${assetEntityList}");
                                    for (AssetEntity assetEntity
                                    in assetEntityList) {
                                      File file = await assetEntity.file;
                                      String id = await assetEntity.id;
                                      setState(() {
                                        _commentSelectedImgList.add(file.path);
                                        if (_commentSelectedImgList.length > 0) {
                                          _isShowSelectedImgPreView = true;
                                        }
                                      });
                                    }
                                  });
//                              _openPhotoAlbum((String imgPathList) {
//                                setState(() {
//                                  List<String> list =
//                                      json.decode(imgPathList).cast<String>();
//                                  for (String path in list) {
//                                    _commentSelectedImgList.add(path);
//                                  }
//                                  if (_commentSelectedImgList.length > 0) {
//                                    setState(() {
//                                      _isShowSelectedImgPreView = true;
//                                    });
//                                  }
//                                  print("相册回传处理");
//                                });
//                              });
                            },
                            child: Column(
                              children: [
                                Center(
                                  child: Icon(
                                    Icons.photo,
                                    color: Color(0xff393a3b),
                                    size: 25,
                                  ),
                                ),
                              ],
                            ),
                          )),

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
                                _commentSelectedImgList.add(file.path);
                              });
                            });
//                            _openCamera((String imgFilePath) {
//                              setState(() {
//                                _commentSelectedImgList.add(imgFilePath);
//                              });
//                            });
                          },
                          child: Column(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color(0xff393a3b),
                                  size: 25,
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
                                  /// 回传处理
                                  Map selectedUserInfo = json.decode(result);

                                  /// 用户id
                                  num userId = selectedUserInfo["userId"];

                                  /// 用户名
                                  String userName = selectedUserInfo["userName"];

                                  ///注意加'空格'
                                  setState(() {
                                    /// 页面发生跳转会清空编辑区域,所以要加上之前的文本内容
                                    String text = "@${userName} ";
                                    insertText(
                                        _textEditingController.value.text + text);

                                    /// 添加@用户列表
                                    _commentAtUserIdList.add(userId);
                                  });
                                });
                          },
                          child: Column(
                            children: [
                              Center(
                                child: Icon(
                                  FontAwesome.at,
                                  color: Color(0xff393a3b),
                                  size: 25,
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
                          onTap: () {
                            if (_isShowFaceSelect) {
                              setState(() {
                                /// 隐藏表情选择区域
                                _isShowFaceSelect = false;
                              });

                              /// 打开软键盘
                              GlobalConst.showSoftKeyBoard(() {
                                print("打开软键盘");
                              });
                            } else {
                              setState(() {
                                /// 显示表情选择区域
                                _isShowFaceSelect = true;
                              });

                              /// 关闭软键盘
                              GlobalConst.hideSoftKeyBoard(() {
                                print("关闭软键盘");
                              });
                            }
                          },
                          child: Column(
                            children: [
                              Center(
                                child: Icon(
                                  Icons.sentiment_satisfied_alt,
                                  color: Color(0xff393a3b),
                                  size: 25,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        /// ----------------- 编辑框区域 end -----------------

        /// ----------------- 表情选择区域 start -----------------
        GestureDetector(
          onTap: () {},
          child: Container(
            height:
            _isShowFaceSelect ? GlobalConst.FACE_SELECT_AREA_HEIGHT : 0.0,
            child: Expanded(
              child: buildCustomKeyBoard(),
            ),
          ),
        ),

        /// ----------------- 表情选择区域 end -----------------
      ]);
    });
  }

  ///打开相册
  void _openPhotoAlbum(Function callBack) async {
    /// 相册的选择返回结果
    /// 选择成功与取消都会回调
    GlobalRouteTable.goGlobalPhotoAlbumPage(context, (String imgPathList) {
      callBack(imgPathList);
    });
//    CameraResultInfo resultInfo =
//        await FlutterCustomCameraPugin.openPhotoAlbum();
//    print(resultInfo.toString());
//    if (resultInfo.code == 200) {
//      String imgFilePath = resultInfo.data["lImageUrl"];
//      _selectedImgPathList.add(imgFilePath);
//    }
//    _cameraResultInfo = resultInfo;
//    setState(() {});
  }

  /// 构建自定义键盘区域
  Widget buildCustomKeyBoard() {
    if (_isShowFaceSelect) {
      return buildEmojiGird();
    }
    return Container();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Widget imgItem = Container(
        padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
        child: CachedNetworkImage(
          imageUrl:
          'https://ss2.bdstatic.com/70cFvnSh_Q1YnxGkpoWK1HF6hhy/it/u=4183732210,4138230452&fm=11&gp=0.jpg',
        ),
      );
      _contentImgList.add(
          imgItem
      );
    });
    /// 页面初始化
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      _initPage(setState);
    });
//    _refresh();
    /// 页面滚动处理
    _scrollController = ScrollController()
      ..addListener(() {
        /// 滚动长度监听
        if (_scrollController.offset >= 50 && !_buildAppBarTitleStatus) {
          setState(() {
            _buildAppBarTitleStatus = true;
          });
        } else if (_scrollController.offset <= 50 && _buildAppBarTitleStatus) {
          setState(() {
            _buildAppBarTitleStatus = false;
          });
        }
      });
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: _buildAppBarTitle(),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        brightness: Brightness.dark,
        actions: [
          GestureDetector(
            onTap: () {
              //跳转到用户搜索页
              Navigator.push(context, CustomRouteJianBian(SearchHomePage()));
            },
            child: Container(
              child: IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.black87,
                ),
                iconSize: 30,
              ),
              margin: EdgeInsets.only(right: 10),
            ),
          ),
        ],
//        automaticallyImplyLeading: false,
        leading: GestureDetector(
          onTap: () {
            setState(() {
              _textEditingController.clear();
            });
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
      body: GestureDetector(
        onTap: () {
          /// 关闭软键盘
          GlobalConst.hideSoftKeyBoard(() {
            print("关闭软键盘");
          });
          setState(() {
            /// 是否显示表情标识符
            _isShowFaceSelect = false;

            /// 编辑标识符
            _isEditeStatus = false;
          });
        },
        child: _buildContentPage(),
      ),
      bottomNavigationBar: null,
    );
  }
}

class SliverTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar widget;
  final Color color;

  const SliverTabBarDelegate(this.widget, {this.color})
      : assert(widget != null);

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return new Container(
      child: widget,
      color: color,
    );
  }

  @override
  bool shouldRebuild(SliverTabBarDelegate oldDelegate) {
    return false;
  }

  @override
  double get maxExtent => widget.preferredSize.height;

  @override
  double get minExtent => widget.preferredSize.height;
}

class MyButton extends StatelessWidget {
  final String text;

  const MyButton(this.text, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // RaisedButton用于实现按钮
    return RaisedButton(
      child: Text(this.text),
      textColor: Theme.of(context).accentColor,
      onPressed: () {},
    );
  }
}
