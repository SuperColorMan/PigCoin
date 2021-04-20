import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/enums/GlobalUserContentTypeEnum.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';
import 'package:xhd_app/view/widget/content/CommentContentItem.dart';
import 'package:xhd_app/view/widget/content/ContentItem.dart';

/// -------------------------------
/// Des: 用户页内容区域
/// -------------------------------
class UserPageContentArea extends StatefulWidget {
  /// 用户id
  String userId;

  /// 用户内容分类
  String classify;

  UserPageContentArea(this.userId, this.classify, {Key key}) : super(key: key);

  @override
  _UserPageContentAreaState createState() {
    return _UserPageContentAreaState();
  }
}

class _UserPageContentAreaState extends State<UserPageContentArea> {
  /// 页号
  num _page = 1;

  /// 页大小
  num _pageSize = 10;

  /// 刷新组件控制器
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 内容项列表
  List<Widget> _contentItemList = [];

  /// 内容是否为空
  bool _contentIsNull = false;

  /// 构建用户页内容区背景
  Widget _buildUserBgImg() {
    if (_contentIsNull) {
      return Container(
        padding: EdgeInsets.only(top: 60),
        alignment: Alignment.topCenter,
        child: Opacity(
          opacity: 0.5,
          child: Image.asset(
            "${GlobalFilePath.USER_PAGE_NULL_CONTENT}",
            width: 200,
            height: 200,
          ),
        ),
      );
    } else {
      return Container();
    }
  }

  /// 初始化内容
  void _initContent() {
    /// --------------------- 初始化处理 start ---------------------
    if (GlobalUserContentTypeEnum.ALL.index.toString() == widget.classify) {
      /// 全部内容
      // monitor network fetch
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserContentByClassify(widget.userId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            /// 结果集内容列表
            List dataList = value['data'];

            /// 判断内容是否为空
            if (dataList.length == 0) {
              _contentIsNull = true;
            } else {
              _contentIsNull = false;
            }
            for (Map m in dataList) {
              /// 用户内容分类
              num _userContentType = m['userContentType'];
              if (_userContentType == 1) {
                /// 发送的内容
                /// 构建内容项队列
                setState(() {
                  _contentItemList.add(ContentItem(m));
                });
              } else if (_userContentType == 2) {
                /// 点赞
                /// 构建内容项队列
                setState(() {
                  _contentItemList.add(ContentItem(m));
                });
              } else if (_userContentType == 3) {
                /// 发起的评论
                setState(() {
                  _contentItemList.add(CommentContentItem(m));
                });
              } else if (_userContentType == 4) {
                /// 收藏
                /// 构建内容项队列
                setState(() {
                  _contentItemList.add(ContentItem(m));
                });
              }
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 复位页号
          _page = 1;

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    } else if (GlobalUserContentTypeEnum.CONTENT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        /// 发送内容
        // monitor network fetch
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserContentByClassify(widget.userId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value['data'];

            /// 判断内容是否为空
            if (dataList.length == 0) {
              _contentIsNull = true;
            } else {
              _contentIsNull = false;
            }
            for (Map map in dataList) {
              /// 构建内容项队列
              setState(() {
                _contentItemList.add(ContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 复位页号
          _page = 1;

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    } else if (GlobalUserContentTypeEnum.GOOD.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        /// 点赞内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserContentByClassify(widget.userId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value['data'];

            /// 判断内容是否为空
            if (dataList.length == 0) {
              _contentIsNull = true;
            } else {
              _contentIsNull = false;
            }
            for (Map map in dataList) {
              /// 构建内容项队列
              setState(() {
                _contentItemList.add(ContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 复位页号
          _page = 1;

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    } else if (GlobalUserContentTypeEnum.COMMENT.index.toString() ==
        widget.classify) {
      /// 发起评论内容
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserCommentContentListByUserId(loginUserId.toString(),
                widget.userId, _page.toString(), _pageSize.toString());
        resMap.then((value) {
          print('发起的评论---${value}');
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value["data"];

            /// 判断内容是否为空
            if (dataList.length == 0) {
              _contentIsNull = true;
            } else {
              _contentIsNull = false;
            }
            for (Map map in dataList) {
              /// 构建内容项队列
              setState(() {
                _contentItemList.add(CommentContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 复位页号
          _page = 1;

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    } else if (GlobalUserContentTypeEnum.COLLECT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        /// 收藏内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserContentByClassify(widget.userId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value['data'];

            /// 判断内容是否为空
            if (dataList.length == 0) {
              _contentIsNull = true;
            } else {
              _contentIsNull = false;
            }
            for (Map map in dataList) {
              /// 构建内容项队列
              setState(() {
                _contentItemList.add(ContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 复位页号
          _page = 1;

          /// 释放刷新状态
          _refreshController.refreshCompleted();
        });
      });
    }

    /// --------------------- 初始化处理 end ---------------------
  }

  /// 内容加载
  void _loadContent() {
    /// --------------------- 加载处理 start ---------------------
    if (GlobalUserContentTypeEnum.ALL.index.toString() == widget.classify) {
      /// 全部内容
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserContentByClassify(widget.userId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            /// 结果集内容列表
            List dataList = value['data'];
            for (Map m in dataList) {
              /// 用户内容分类
              num _userContentType = m['userContentType'];
              if (_userContentType == 1) {
                /// 发送的内容
                /// 构建内容项队列
                setState(() {
                  _contentItemList.add(ContentItem(m));
                });
              } else if (_userContentType == 2) {
                /// 点赞
                /// 构建内容项队列
                setState(() {
                  _contentItemList.add(ContentItem(m));
                });
              } else if (_userContentType == 3) {
                /// 发起的评论
                /// 构建内容项队列
                setState(() {
                  _contentItemList.add(CommentContentItem(m));
                });
              } else if (_userContentType == 4) {
                /// 收藏
                /// 构建内容项队列
                setState(() {
                  _contentItemList.add(ContentItem(m));
                });
              }
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 自增页号
          _page++;

          /// 释放刷新状态
          _refreshController.loadComplete();
        });
      });
    } else if (GlobalUserContentTypeEnum.CONTENT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        /// 发送内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserContentByClassify(widget.userId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value['data'];
            for (Map map in dataList) {
              /// 构建内容项队列
              setState(() {
                _contentItemList.add(ContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 自增页号
          _page++;

          /// 释放刷新状态
          _refreshController.loadComplete();
        });
      });
    } else if (GlobalUserContentTypeEnum.GOOD.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        /// 点赞内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserContentByClassify(widget.userId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value['data'];
            for (Map map in dataList) {
              /// 构建内容项队列
              setState(() {
                _contentItemList.add(ContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 自增页号
          _page++;

          /// 释放刷新状态
          _refreshController.loadComplete();
        });
      });
    } else if (GlobalUserContentTypeEnum.COMMENT.index.toString() ==
        widget.classify) {
      /// 发起评论内容
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserCommentContentListByUserId(loginUserId.toString(),
                widget.userId, _page.toString(), _pageSize.toString());
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value["data"];
            for (Map map in dataList) {
              /// 评论内容

              /// 构建内容项队列
              setState(() {
                _contentItemList.add(CommentContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 自增页号
          _page++;

          /// 释放刷新状态
          _refreshController.loadComplete();
        });
      });
    } else if (GlobalUserContentTypeEnum.COLLECT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        /// 收藏内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .getUserContentByClassify(widget.userId, loginUserId.toString(),
                _page.toString(), _pageSize.toString(), widget.classify);
        resMap.then((value) {
          int code = value['code'];
          if (code == 0) {
            GlobalToast.showToast("请求成功");

            /// 结果集内容列表
            List dataList = value['data'];
            for (Map map in dataList) {
              /// 构建内容项队列
              setState(() {
                _contentItemList.add(ContentItem(map));
              });
            }
          } else if (code == 1) {
            GlobalToast.showToast("请求失败");
          }

          /// 复位页号
          _page++;

          /// 释放刷新状态
          _refreshController.loadComplete();
        });
      });
    }

    /// --------------------- 加载处理 end ---------------------
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _contentIsNull = true;

    /// 清空内容
    _contentItemList.clear();

    /// 初始化内容
    _initContent();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      /// 构建用户内容区
      return Container(
          color: Color(GlobalColor.MAX_SHALLOW_GRAY),
          child: Stack(
            children: [
              /// 背景图片
              _buildUserBgImg(),

              /// 内容区域
              SmartRefresher(
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
                onRefresh: () {
                  setState(() {
                    /// 清空内容
                    _contentItemList.clear();
                  });
                  _initContent();
                },
                onLoading: () {
                  /// 内容加载
                  _loadContent();
                },
                child: ListView.builder(
                    itemCount: _contentItemList.length,
                    itemBuilder: (context, i) {
                      if (_contentItemList.length > 0) {
                        return _contentItemList[i];
                      } else {
                        return Container();
                      }
                    }),
              ),
            ],
          ));
    });
  }
}
