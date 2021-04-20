import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:extended_text/extended_text.dart';
import 'package:extended_text_field/extended_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/media/GlobalCamera.dart';
import 'package:xhd_app/view/comm/media/GlobalPhotoAlbum.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/text/type/emoji_text.dart' as emoji;
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';
import 'package:xhd_app/view/comm/utils/GlobalMathUtils.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/img/GlobalImageBuilder.dart';
import 'package:xhd_app/view/widget/reply/ReplyCommentItem.dart';
import 'package:xhd_app/view/widget/reply/ReplyReplyItem.dart';

/// -------------------------------
/// Des: 全局回复框
/// -------------------------------

class GlobalReplyBox {
  /// 打开回复区域
  /// m 回复的评论信息
  static void openReplyArea(BuildContext context, Map commentStruct) {
    /// ---------------------------- 滚动特性 start ----------------------------
    ScrollPhysics usePhysics = ClampingScrollPhysics();

    /// ---------------------------- 滚动特性 end ----------------------------

    /// 全局状态修改对象
    StateSetter _setReplyBoxState;

    /// -------------- 滚动控制器 start --------------
    ScrollController _scrollController = ScrollController();

    /// -------------- 滚动控制器 end --------------

    /// 是否显示表情标识符
    bool _isShowReplyFaceSelect = false;

    ///-------------编辑标识符-------------
    bool _isReplyEditeStatus = false;

    ///----------------------------------
    ///-------------回复条目列表-------------
    List<Widget> _replyItemList = [];

    ///----------------------------------
    ///------------- 回复相关信息 start-------------
    /// 表名是否处于回复回复的状态,1:表示正在回复一个回复,0表示正在回复一个评论
    int _isReplyReply = 0;

    ///------------- 回复相关信息 end-------------

    /// ------------------ 构建页面初始化参数 ------------------

    /// 评论id
    String _commentId = commentStruct['id'].toString();

    /// 评论正文
    String _commentBody = commentStruct['body'];

    /// 评论用户信息
    Map _commentUserInfo = commentStruct['tuUser'];

    /// 评论用户id
    String _commentUserId = _commentUserInfo['id'].toString();

    /// 评论用户名称
    String _commentUserName = _commentUserInfo['name'].toString();

    /// 评论时间
    String _commentTime = commentStruct['createTime'].toString();

    /// 评论差集时间
    String _commentDiffTimeTime = commentStruct['diffTime'].toString() + "前";

    /// 图片处理
    List<Map> _imgInfoList = commentStruct['imgList'].cast<Map>();

    /// 评论中图片列表
    List<String> _commentImgList = [];
    for (Map m in _imgInfoList) {
      _commentImgList.add("${GlobalApiUrlTable.GET_COMMENT_IMG}?id=${m['id']}");
    }

    /// 图片显示个数
    int _commentImgShowCount =
        GlobalMatUtils.imgShowCountCal(_commentImgList.length);

    /// 所属内容id
    String _contentId = commentStruct['contentId'].toString();

    num _page = 1;
    num _pageSize = 10;

    ///被回复的回复id
    String _byReplyId = "";

    ///被回复的用户id
    String _byUserId = "";

    ///被回复的用户名
    String _byUserName = "";

    /// ----------------------------------------------------

    /// ------------------ 回复发送参数 start------------------

    /// 回复中选择的@用户id列表
    List<String> _replyAtUserIdList = [];

    /// 回复中已经选择图片
    List<String> _replySelectedImgList = [];

    /// ------------------ 回复发送参数 end------------------

    GlobalNetApiCall _globalNetApiCall = GlobalNetApiCall();

    /// 文本编辑器控制器
    final TextEditingController _replyTextEditingController =
        TextEditingController();

    /// 全局key
    final GlobalKey _key = GlobalKey();

    RefreshController _refreshController =
        RefreshController(initialRefresh: false);

    /// ------------------ 页面初始化 ------------------
    void _initPage() {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap =
            _globalNetApiCall.getReplyListByCommentId(_contentId, _commentId,
                loginUserId.toString(), _page.toString(), _pageSize.toString());
        resMap.then((value) {
          print("回复列表回传-----${value}");
          if (value['code'] == 0) {
            List _replyList = value['data'];
            for (Map replyMap in _replyList) {
              /// 回复类型标识符
              String _byType = replyMap['byType'].toString();
              if (_byType == "0") {
                /// 回复评论
                _setReplyBoxState(() {
                  /// 新增回复评论条目
                  _replyItemList.add(ReplyCommentItem(replyMap, callBack: () {
                    /// 修改标识符
                    _setReplyBoxState(() {
                      /// 处于回复回复状态
                      _isReplyReply = 1;

                      /// 回复回复条目id
                      _byReplyId = replyMap['id'].toString();

                      /// 回复回复条目的发起者用户名
                      _byUserName = replyMap['userInfo']['name'].toString();
                    });

                    /// 打开软键盘
                    GlobalConst.showSoftKeyBoard(() {
                      _setReplyBoxState(() {
                        _isReplyEditeStatus = true;
                        _isShowReplyFaceSelect = false;
                      });
                    });
                  }));
                });
              } else if (_byType == "1") {
                /// 回复回复
                /// 新增回复回复条目
                _replyItemList.add(ReplyReplyItem(replyMap, callBack: () {
                  /// 修改标识符
                  _setReplyBoxState(() {
                    /// 处于回复回复状态
                    _isReplyReply = 1;

                    /// 回复回复条目id
                    _byReplyId = replyMap['id'].toString();

                    /// 回复回复条目的发起者用户名
                    _byUserName = replyMap['userInfo']['name'].toString();
                  });

                  /// 打开软键盘
                  GlobalConst.showSoftKeyBoard(() {
                    _setReplyBoxState(() {
                      _isReplyEditeStatus = true;
                      _isShowReplyFaceSelect = false;
                    });
                  });
                }));
              }
            }
          } else if (value['code'] == 1) {
            GlobalToast.showToast(value['mess']);
          }

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    }

    ///-----------------------------------------------

    /// 下拉刷新
    void _onRefresh() async {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap =
            _globalNetApiCall.getReplyListByCommentId(_contentId, _commentId,
                loginUserId.toString(), _page.toString(), _pageSize.toString());
        resMap.then((value) {
          print("回复列表回传-----${value}");
          if (value['code'] == 0) {
            List _replyList = value['data'];
            for (Map replyMap in _replyList) {
              /// 回复类型标识符
              String _byType = replyMap['byType'].toString();
              if (_byType == "0") {
                /// 回复评论
                _setReplyBoxState(() {
                  /// 新增回复评论条目
                  _replyItemList.add(ReplyCommentItem(replyMap, callBack: () {
                    /// 修改标识符
                    _setReplyBoxState(() {
                      /// 处于回复回复状态
                      _isReplyReply = 1;

                      /// 回复回复条目id
                      _byReplyId = replyMap['id'].toString();

                      /// 回复回复条目的发起者用户名
                      _byUserName = replyMap['userInfo']['name'].toString();
                    });

                    /// 打开软键盘
                    GlobalConst.showSoftKeyBoard(() {
                      _setReplyBoxState(() {
                        _isReplyEditeStatus = true;
                        _isShowReplyFaceSelect = false;
                      });
                    });
                  }));
                });
              } else if (_byType == "1") {
                /// 回复回复
                /// 新增回复回复条目
                _replyItemList.add(ReplyReplyItem(replyMap, callBack: () {
                  /// 修改标识符
                  _setReplyBoxState(() {
                    /// 处于回复回复状态
                    _isReplyReply = 1;

                    /// 回复回复条目id
                    _byReplyId = replyMap['id'].toString();

                    /// 回复回复条目的发起者用户名
                    _byUserName = replyMap['userInfo']['name'].toString();
                  });

                  /// 打开软键盘
                  GlobalConst.showSoftKeyBoard(() {
                    _setReplyBoxState(() {
                      _isReplyEditeStatus = true;
                      _isShowReplyFaceSelect = false;
                    });
                  });
                }));
              }
            }
          } else if (value['code'] == 1) {
            GlobalToast.showToast(value['mess']);
          }

          /// 清空页号
          _page = 0;

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    }

    /// 上拉加载
    void _onLoading() async {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap =
            _globalNetApiCall.getReplyListByCommentId(_contentId, _commentId,
                loginUserId.toString(), _page.toString(), _pageSize.toString());
        resMap.then((value) {
          print("回复列表回传-----${value}");
          if (value['code'] == 0) {
            List _replyList = value['data'];
            for (Map replyMap in _replyList) {
              /// 回复类型标识符
              String _byType = replyMap['byType'].toString();
              if (_byType == "0") {
                /// 回复评论
                _setReplyBoxState(() {
                  /// 新增回复评论条目
                  _replyItemList.add(ReplyCommentItem(replyMap, callBack: () {
                    /// 修改标识符
                    _setReplyBoxState(() {
                      /// 处于回复回复状态
                      _isReplyReply = 1;

                      /// 回复回复条目id
                      _byReplyId = replyMap['id'].toString();

                      /// 回复回复条目的发起者用户名
                      _byUserName = replyMap['userInfo']['name'].toString();
                    });

                    /// 打开软键盘
                    GlobalConst.showSoftKeyBoard(() {
                      _setReplyBoxState(() {
                        _isReplyEditeStatus = true;
                        _isShowReplyFaceSelect = false;
                      });
                    });
                  }));
                });
              } else if (_byType == "1") {
                /// 回复回复
                /// 新增回复回复条目
                _replyItemList.add(ReplyReplyItem(replyMap, callBack: () {
                  /// 修改标识符
                  _setReplyBoxState(() {
                    /// 处于回复回复状态
                    _isReplyReply = 1;

                    /// 回复回复条目id
                    _byReplyId = replyMap['id'].toString();

                    /// 回复回复条目的发起者用户名
                    _byUserName = replyMap['userInfo']['name'].toString();
                  });

                  /// 打开软键盘
                  GlobalConst.showSoftKeyBoard(() {
                    _setReplyBoxState(() {
                      _isReplyEditeStatus = true;
                      _isShowReplyFaceSelect = false;
                    });
                  });
                }));
              }
            }

            /// 自增页号
            _page++;
          } else if (value['code'] == 1) {
            GlobalToast.showToast(value['mess']);
          }

          /// 释放加载状态
          _refreshController.loadComplete();
        });
      });
    }

    /// 插入文本
    void insertText(String text) {
      final TextEditingValue value = _replyTextEditingController.value;
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

        _replyTextEditingController.value = value.copyWith(
            text: newText,
            selection: value.selection.copyWith(
                baseOffset: end + text.length,
                extentOffset: end + text.length));
      } else {
        _replyTextEditingController.value = TextEditingValue(
            text: text,
            selection:
                TextSelection.fromPosition(TextPosition(offset: text.length)));
      }
    }

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

    /// ------------------ 构建选择图片预览区域 ------------------
    /// 是否显示图片选择预览区域
    bool _isShowSelectedImgPreView = false;

    Widget _buildSelectedImgPreView(StateSetter setReplyBoxState) {
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
                    itemCount: _replySelectedImgList.length,
                    itemBuilder: (context, i) {
                      return Container(
                        width: 60,
                        height: 50,
                        margin: EdgeInsets.only(left: 10),
                        child: Stack(
                          children: [
                            Image.file(
                              File(_replySelectedImgList[i]),
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
                                  setReplyBoxState(() {
                                    _replySelectedImgList.removeAt(i);
                                  });
                                  if (_replySelectedImgList.length == 0) {
                                    setReplyBoxState(() {
                                      _isShowSelectedImgPreView = false;
                                    });
                                  }
                                },
                                child: Container(
                                  alignment: Alignment.center,
                                  width: 20,
                                  height: 20,
                                  color: Color(GlobalColor.LUCENCY_BLACK),
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

    /// ------------------------------------------------------------------------

    ///--------------------
    ///回复条目
    ///--------------------
    List<Widget> replyList = <Widget>[];

    Widget buildCustomKeyBoard() {
      if (_isShowReplyFaceSelect) {
        return buildEmojiGird();
      }
      return Container();
    }

    /// 构建内容页
    Widget _buildContentPage(StateSetter setReplyBoxState) {
      return Column(children: <Widget>[
        new Flexible(
          child: SmartRefresher(
            enablePullDown: false,
            enablePullUp: true,
            header: WaterDropHeader(
              waterDropColor: Color(GlobalColor.APP_THEME_COLOR),
            ),
            footer: CustomFooter(
              builder: (BuildContext context, LoadStatus mode) {
                //根据下方加载进度条加载完毕后执行
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
//            onRefresh: _onRefresh,
            onLoading: _onLoading,
            child: ListView.builder(
                controller: _scrollController,
                shrinkWrap: true,
                physics: usePhysics,
                itemCount: 1,
                itemBuilder: (context, i) {
                  return new Container(
                    padding: EdgeInsets.only(top: 10),
                    color: Colors.white,
                    child: Column(children: [
                      ///用户信息
                      Row(
                        children: [
                          ///头像
                          Expanded(
                              flex: 2,
                              child: Center(
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_commentUserId}',
                                    fit: BoxFit.cover,
                                    width: 35,
                                    height: 35,
                                    // color: Colors.black
                                  ),
                                ),
                              )),

                          /// 用户信息
                          Expanded(
                              flex: 10,
                              child: Column(
                                children: [
                                  /// 用户名
                                  Container(
                                    child: Row(
                                      children: [
                                        Text(
                                          "${_commentUserName}",
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      ],
                                    ),
                                  ),
                                  //发送时间等信息
                                  Container(
                                    child: Row(
                                      children: [
                                        Text("${_commentDiffTimeTime}",
                                            style: TextStyle(
                                              fontSize: 13,
                                              color: new Color(
                                                  GlobalColor.SHALLOW_GRAY),
                                            )),
                                      ],
                                    ),
                                  ),
                                ],
                              )),
                          //关注按钮
                          Expanded(
                              flex: 3,
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Center(
                                  child: FlatButton(
                                    splashColor: Colors.black87,
                                    child: Text(
                                      '关 注',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    onPressed: () {},
                                    color: Color(GlobalColor.APP_THEME_COLOR),
                                  ),
                                ),
                              )),
                        ],
                      ),

                      /// 评论内容文本
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 5, bottom: 10),
                        child: ExtendedText(
                          '${_commentBody}',
                          style: TextStyle(fontSize: 16),
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

                      /// 评论中图片列表
                      Container(
                        padding: EdgeInsets.only(left: 50, right: 10),
                        child: GlobalImageBuilder.buildContentItemImgShowArea(
                            _commentImgList, _commentImgShowCount,
                            callBack: () {
                          GlobalRouteTable.goShowImagePage(
                              context, _commentImgList);
                        }),
                      ), //
                      /// 分割线
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        height: 5,
                        color: new Color(GlobalColor.MAX_SHALLOW_GRAY),
                      ),

                      /// ---------------------- 评论区域标题 ----------------------
                      /// 评论区域标题
                      Container(
                        padding: EdgeInsets.only(
                            top: 10, bottom: 10, left: 10, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 8,
                              child: Text(
                                "100条回复",
                                style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// ----------------------------------------------------
                      //分割线
                      Container(
                        height: 1,
                        color: new Color(GlobalColor.MAX_SHALLOW_GRAY),
                      ),

                      /// 回复评论区域
                      Container(
                        padding: EdgeInsets.only(bottom: 28),
                        child: Column(children: _replyItemList),
                      )
                    ]),
                  );
                }),
          ),
        ),
        //分隔线
        new Divider(height: 1.0),

        /// ------------------ 底部编辑框区域 ------------------
        Container(
            padding: EdgeInsets.only(top: 6, bottom: 30),
            child: Column(
              children: [
                /// 选择发送图片预览区域
                _buildSelectedImgPreView(setReplyBoxState),

                /// -------------- 回复编辑区域 --------------
                Row(
                  children: [
                    Expanded(
                      flex: 9,
                      child: ExtendedTextField(
                        key: _key,
                        onTap: () {
                          setReplyBoxState(() {
                            _isShowReplyFaceSelect = false;
                            _isReplyEditeStatus = true;
                            if (_isReplyReply == 0) {
                              print("编辑区域点击----${_isReplyReply}");
                            }
                          });
                        },
                        specialTextSpanBuilder:
                            GlobalConst.SPECIAL_TEXT_SPAN_BUILDER,
                        controller: _replyTextEditingController,
                        maxLines: null,
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

                    ///点赞
                    Visibility(
                      visible: !_isReplyEditeStatus,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.thumb_up_alt_outlined,
                                color: Color(GlobalColor.DEEP_GRAY),
                                size: 20,
                              ),
                            ),
                            Center(
                                child: Text(
                              "点赞",
                              style: TextStyle(
                                color: Color(GlobalColor.DEEP_GRAY),
                                fontSize: 13,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),

                    ///收藏
                    Visibility(
                      visible: !_isReplyEditeStatus,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.star_border,
                                color: Color(GlobalColor.DEEP_GRAY),
                                size: 20,
                              ),
                            ),
                            Center(
                                child: Text(
                              "收藏",
                              style: TextStyle(
                                color: Color(GlobalColor.DEEP_GRAY),
                                fontSize: 13,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),

                    ///分享
                    Visibility(
                      visible: !_isReplyEditeStatus,
                      child: Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            Center(
                              child: Icon(
                                Icons.share_outlined,
                                color: Color(GlobalColor.DEEP_GRAY),
                                size: 20,
                              ),
                            ),
                            Center(
                                child: Text(
                              "分享",
                              style: TextStyle(
                                color: Color(GlobalColor.DEEP_GRAY),
                                fontSize: 13,
                              ),
                            )),
                          ],
                        ),
                      ),
                    ),

                    ///发送按钮
                    Visibility(
                      visible: _isReplyEditeStatus,
                      child: GestureDetector(
                        onTap: () {
                          String body = _replyTextEditingController.value.text;
                          print("回复标识符-----${_isReplyReply}");
                          if (_isReplyReply == 0) {
                            GlobalLocalCache.getLoginUserId()
                                .then((_loginUserId) {
                              /// 回复评论
                              _globalNetApiCall.replyComment(
                                  _loginUserId.toString(),
                                  _byUserId,
                                  _byUserName,
                                  _contentId,
                                  _commentId,
                                  body,
                                  _replySelectedImgList,
                                  _replyAtUserIdList);
                            });
                          } else if (_isReplyReply == 1) {
                            GlobalLocalCache.getLoginUserId()
                                .then((_loginUserId) {
                              /// 回复回复
                              _globalNetApiCall.replyReply(
                                  _loginUserId.toString(),
                                  _byUserId,
                                  _byUserName,
                                  _contentId,
                                  _commentId,
                                  _byReplyId,
                                  body,
                                  _replySelectedImgList,
                                  _replyAtUserIdList);
                            });
                          }
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

                ///------------------------------------------
                /// -------------- 回复功能按钮区域 --------------
                Visibility(
                  visible: _isReplyEditeStatus,
                  child: Container(
                    padding: EdgeInsets.only(
                        top: 15, bottom: 0, left: 10, right: 150),
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
                                  setReplyBoxState(() {
                                    _replySelectedImgList.add(file.path);
                                    if (_replySelectedImgList.length > 0) {
                                      _isShowSelectedImgPreView = true;
                                    }
                                  });
                                }
                              });
//                              _openPhotoAlbum((String imgPathList) {
//                                setReplyBoxState(() {
//                                  print("回传---${imgPathList}");
//                                  List<String> list =
//                                      json.decode(imgPathList).cast<String>();
//                                  for (String path in list) {
//                                    _replySelectedImgList.add(path);
//                                  }
//                                  print("回传选择图片个数----${_replySelectedImgList}");
//                                  if (_replySelectedImgList.length > 0) {
//                                    setReplyBoxState(() {
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
                          ),
                        ),

                        /// 相机
                        Expanded(
                          flex: 2,
                          child: GestureDetector(
                            onTap: () {
                              /// 相机选择
                              GlobalCamera.open(context, (assetEntity) async {
                                File file = await assetEntity.file;
                                String id = await assetEntity.id;
                                setReplyBoxState(() {
                                  _replySelectedImgList.add(file.path);
                                });
                              });
//                              _openCamera((String imgFilePath) {
//                                print("相机选择....${imgFilePath}");
//                                setReplyBoxState(() {
//                                  _replySelectedImgList.add(imgFilePath);
//                                });
//                              });
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
                                String userId =
                                    selectedUserInfo["userId"].toString();

                                /// 用户名
                                String userName =
                                    selectedUserInfo["userName"].toString();

                                /// 获取焦点

                                setReplyBoxState(() {
                                  ///注意加'空格'
                                  /// 页面发生跳转会清空编辑区域,所以要加上之前的文本内容
                                  String text = "@${userName} ";
                                  insertText(
                                      _replyTextEditingController.value.text +
                                          text);
                                  _replyAtUserIdList.add(userId);
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
                              if (_isShowReplyFaceSelect) {
                                setReplyBoxState(() {
                                  /// 隐藏表情选择区域
                                  _isShowReplyFaceSelect = false;
                                });

                                /// 显示软键盘
                                GlobalConst.showSoftKeyBoard(() {
                                  print("显示软键盘");
                                });
                              } else {
                                setReplyBoxState(() {
                                  /// 显示表情选择区域
                                  _isShowReplyFaceSelect = true;
                                });

                                /// 隐藏软键盘
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

                /// -------------------------------------------
              ],
            )),

        ///--------------------------------------------------

        /// ----------------- 表情选择区域 start -----------------
        GestureDetector(
          onTap: () {},
          child: Container(
            height: _isShowReplyFaceSelect
                ? GlobalConst.FACE_SELECT_AREA_HEIGHT
                : 0.0,
            child: Expanded(
              child: buildCustomKeyBoard(),
            ),
          ),
        ),

        /// ----------------- 表情选择区域 end -----------------
      ]);
    }

    /// 手指移动的位置
    double _lastMoveY = 0.0;

    /// 手指按下的位置
    double _downY = 0.0;

    /// 页面渲染完成后初始化
    WidgetsBinding.instance.addPostFrameCallback((mag) {
      /// 初始化页面
      _initPage();
    });

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
          return Listener(
            behavior: HitTestBehavior.opaque,
            onPointerDown: (PointerDownEvent event) {
              /// 手指按下的距离
              _downY = event.position.distance;
            },
            onPointerUp: (PointerUpEvent event) {
              if (_scrollController.offset == 0 &&
                  usePhysics is ClampingScrollPhysics) {
                _setReplyBoxState(() {
                  usePhysics = NeverScrollableScrollPhysics();
                });
              } else if (usePhysics is NeverScrollableScrollPhysics) {
                _setReplyBoxState(() {
                  usePhysics = ClampingScrollPhysics();
                });
              }
            },
            onPointerMove: (PointerMoveEvent event) {
              /// 手指移动的距离
              var position = event.position.distance;

              /// 判断距离差
              var detal = position - _lastMoveY;
              if (detal > 0) {
                /// 手指移动的距离
                double pos = (position - _downY);

//                print("================向下移动================");
              } else {
//                print("================向上移动================");
                // 所摸点长度 +滑动距离  = IistView的长度  说明到达底部
              }
              _lastMoveY = position;
            },
            child: Container(
              child: StatefulBuilder(builder: (context, setReplyBoxState) {
                /// 保存全局状态修改句柄
                _setReplyBoxState = setReplyBoxState;
                return Container(
                  height: GlobalConst.REPLY_AREA_HEIGHT,
                  child: Scaffold(
                    backgroundColor: Colors.transparent,
                    appBar: PreferredSize(
                        child: AppBar(
                          backgroundColor: Colors.transparent,
                          //设置标题栏的背景颜色
                          title: Text(
                            '评论详情',
                            style: TextStyle(color: Colors.black87),
                          ),
                          centerTitle: true,
                          elevation: 0,
                          brightness: Brightness.dark,
                          actions: [
                            GestureDetector(
                              onTap: () {
                                ///关闭弹窗
                                Navigator.of(context).pop();
                                setReplyBoxState(() {
                                  _isReplyEditeStatus = true;
                                  _isShowReplyFaceSelect = false;
                                  _isReplyReply = 0;
                                });

                                /// 关闭软键盘
                                GlobalConst.hideSoftKeyBoard(() {
                                  print("关闭弹窗,关闭软键盘");
                                });
                              },
                              child: Container(
                                child: IconButton(
                                  icon: Icon(
                                    Icons.close,
                                    color: Colors.black87,
                                  ),
                                  iconSize: 30,
                                ),
                                margin: EdgeInsets.only(right: 10),
                              ),
                            ),
                          ],
                        ),
                        preferredSize: Size.fromHeight(50)),
                    body: Stack(
                      children: [
                        /// 内容区域
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            /// 触摸收起键盘
                            GlobalConst.hideSoftKeyBoard(() {
                              setReplyBoxState(() {
                                _isShowReplyFaceSelect = false;
                                _isReplyEditeStatus = false;
                              });
                            });

                            /// 状态置空
                            _isReplyReply = 0;
                            setReplyBoxState(() {
                              _isShowReplyFaceSelect = false;
                            });
                          },
                          child: _buildContentPage(setReplyBoxState),
                        ),
                      ],
                    ),
                  ),
                );
              }),
            ),
          );
        });
  }
}
