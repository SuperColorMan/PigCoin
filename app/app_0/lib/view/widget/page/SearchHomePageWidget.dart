import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/enums/GlobalSearchRedultsContentTypeEnum.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/content/ContentItem.dart';
import 'package:xhd_app/view/widget/gambit/RowGambitItem.dart';
import 'package:xhd_app/view/widget/user/ColumnUserItem_1.dart';
import 'package:xhd_app/view/widget/user/RowUserItem_1.dart';

/// -------------------------------
/// Des: 搜索主页组件
/// -------------------------------
class SearchHomePageWidget extends StatefulWidget {
  /// 分类
  String classify;

  /// 文本编辑器控制器
  TextEditingController searchTextEditingController;

  SearchHomePageWidget(this.classify, this.searchTextEditingController,
      {Key key})
      : super(key: key);

  @override
  _SearchHomePageWidgetState createState() {
    return _SearchHomePageWidgetState();
  }
}

class _SearchHomePageWidgetState extends State<SearchHomePageWidget> {
  /// 页号
  num _page = 1;

  /// 页大小
  num _pageSize = 10;

  /// 刷新组件控制器
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  /// 推荐用户区域
  Widget _recommendUserArea = Container();

  /// 推荐话题区域
  Widget _recommendGambitArea = Container();

  /// 内容项列表
  List<Widget> _contentItemList = [];

  /// 内容初始化
  void _initContent() {
    /// --------------------- 内容初始化 start ---------------------
    if (GlobalSearchRedultsContentTypeEnum.ALL.index.toString() ==
        widget.classify) {
      /// 用户列表
      List<Map> _searchUserList = [];

      /// 话题列表
      List<Widget> _searchGambitList = [];

      /// 话题列表
      /// 全部内容
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
                loginUserId.toString(),
                "7",
                _page.toString(),
                _pageSize.toString(),
                GlobalSearchRedultsContentTypeEnum.ALL.index.toString(),
                widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];

            /// 内容列表
            List contentList = data['contentList'];

            /// 用户列表
            List userList = data['userList'];

            /// 话题列表
            List gambitList = data['gambitList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }

              /// 添加用户项
              if (userList.length > 0) {
                for (Map map in userList) {
                  _searchUserList.add(map);
                }
                _recommendUserArea = Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.infinity,
                  color: Colors.white,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _searchUserList.map((item) {
                            return Container(
                              child: ColumnUserItem_1(item),
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                );
              }

              /// 添加话题项
              if (gambitList.length > 0) {
                for (Map map in gambitList) {
                  _searchGambitList.add(RowGambitItem(map));
                }
                _recommendGambitArea = Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: _searchGambitList,
                  ),
                );
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.HOT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.HOT.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.NEWS.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.NEWS.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.IMG.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.IMG.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.TEXT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.TEXT.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.USER.index.toString() ==
        widget.classify) {
      for (int i = 0; i < 10; i++) {
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
          GlobalConst.NET_API_CALL
              .getSearchContent(
                  loginUserId.toString(),
                  "7",
                  _page.toString(),
                  _pageSize.toString(),
                  GlobalSearchRedultsContentTypeEnum.USER.index.toString(),
                  widget.searchTextEditingController.value.text)
              .then((value) {
            int code = value['code'];
            if (code == 0) {
              var data = value['data'];

              /// 用户列表
              List userList = data['userList'];

              for (Map map in userList) {
                setState(() {
                  _contentItemList.add(RowUserItem_1(map));
                });
              }
            }
          });
        });
      }
    }
    else if (GlobalSearchRedultsContentTypeEnum.GAMBIT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
                loginUserId.toString(),
                "7",
                _page.toString(),
                _pageSize.toString(),
                GlobalSearchRedultsContentTypeEnum.GAMBIT.index.toString(),
                widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];

            /// 用户列表
            List userList = data['userList'];

            /// 话题列表
            List gambitList = data['gambitList'];

            for (Map map in gambitList) {
              setState(() {
                _contentItemList.add(RowGambitItem(map));
              });
            }
          }
        });
      });
    }

    /// --------------------- 内容初始化 end ---------------------
  }

  /// 刷新
  void _refreshContent() {
    /// --------------------- 刷新处理 start ---------------------
    if (GlobalSearchRedultsContentTypeEnum.ALL.index.toString() ==
        widget.classify) {
      /// 用户列表
      List<Map> _searchUserList = [];

      /// 话题列表
      List<Widget> _searchGambitList = [];

      /// 话题列表
      /// 全部内容
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
                loginUserId.toString(),
                "7",
                _page.toString(),
                _pageSize.toString(),
                GlobalSearchRedultsContentTypeEnum.ALL.index.toString(),
                widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];

            /// 内容列表
            List contentList = data['contentList'];

            /// 用户列表
            List userList = data['userList'];

            /// 话题列表
            List gambitList = data['gambitList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }

              /// 添加用户项
              if (userList.length > 0) {
                _searchUserList.clear();
                for (Map map in userList) {
                  _searchUserList.add(map);
                }
                _recommendUserArea = Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(top: 10, bottom: 10),
                  width: double.infinity,
                  color: Colors.white,
                  child: LayoutBuilder(
                    builder:
                        (BuildContext context, BoxConstraints constraints) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: _searchUserList.map((item) {
                            return Container(
                              child: ColumnUserItem_1(item),
                              margin: EdgeInsets.only(
                                left: 10,
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                );
              }

              /// 添加话题项
              if (gambitList.length > 0) {
                _searchGambitList.clear();
                for (Map map in gambitList) {
                  _searchGambitList.add(RowGambitItem(map));
                }
                _recommendGambitArea = Container(
                  margin: EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.only(left: 10, top: 10, bottom: 10),
                  width: double.infinity,
                  color: Colors.white,
                  child: Column(
                    children: _searchGambitList,
                  ),
                );
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.HOT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.HOT.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              _contentItemList.clear();
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.NEWS.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.NEWS.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              _contentItemList.clear();
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.IMG.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.IMG.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              _contentItemList.clear();
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.TEXT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.TEXT.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              _contentItemList.clear();
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    }
    else if (GlobalSearchRedultsContentTypeEnum.USER.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.USER.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              _contentItemList.clear();
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
//            for(int i=0;i<10;i++){
//              setState((){
//                _contentItemList.add( buildRowUserItem());
//              });
//            }
    }
    else if (GlobalSearchRedultsContentTypeEnum.GAMBIT.index.toString() ==
        widget.classify) {
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.GAMBIT.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];

            /// 用户列表
            List userList = data['userList'];

            /// 话题列表
            List gambitList = data['gambitList'];
            setState(() {
            _contentItemList.clear();
            for (Map map in gambitList) {
                _contentItemList.add(RowGambitItem(map));
            }
            });
          }
        });
      });
//            for(int i=0;i<10;i++){
//              setState((){
//                _contentItemList.add(buildRowGambitItem());
//              });
//            }
    }

    /// 释放刷新状态
    _refreshController.refreshCompleted();

    /// --------------------- 刷新处理 end ---------------------
  }

  /// 加载
  void _loadContent() {
    /// --------------------- 加载处理 start ---------------------
    if (GlobalSearchRedultsContentTypeEnum.ALL.index.toString() ==
        widget.classify) {
      _page++;
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.ALL.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    } else if (GlobalSearchRedultsContentTypeEnum.HOT.index.toString() ==
        widget.classify) {
      _page++;
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.HOT.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    } else if (GlobalSearchRedultsContentTypeEnum.NEWS.index.toString() ==
        widget.classify) {
      _page++;
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.NEWS.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    } else if (GlobalSearchRedultsContentTypeEnum.IMG.index.toString() ==
        widget.classify) {
      _page++;
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.IMG.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    } else if (GlobalSearchRedultsContentTypeEnum.TEXT.index.toString() ==
        widget.classify) {
      _page++;
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.TEXT.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    } else if (GlobalSearchRedultsContentTypeEnum.USER.index.toString() ==
        widget.classify) {
      _page++;
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.USER.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];
            /// 内容列表
            List contentList = data['contentList'];
            setState(() {
              /// 添加内容项
              for (Map map in contentList) {
                _contentItemList.add(ContentItem(map));
              }
            });
          } else {}
        });
      });
    } else if (GlobalSearchRedultsContentTypeEnum.GAMBIT.index.toString() ==
        widget.classify) {
      _page++;
      GlobalLocalCache.getLoginUserId().then((loginUserId) {
        GlobalConst.NET_API_CALL
            .getSearchContent(
            loginUserId.toString(),
            "7",
            _page.toString(),
            _pageSize.toString(),
            GlobalSearchRedultsContentTypeEnum.GAMBIT.index.toString(),
            widget.searchTextEditingController.value.text)
            .then((value) {
          int code = value['code'];
          if (code == 0) {
            var data = value['data'];

            /// 用户列表
            List userList = data['userList'];

            /// 话题列表
            List gambitList = data['gambitList'];

            for (Map map in gambitList) {
              setState(() {
                _contentItemList.add(RowGambitItem(map));
              });
            }
          }
        });
      });
    }

    /// --------------------- 加载处理 end ---------------------
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    /// 内容初始化
    _initContent();
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(builder: (context, setState) {
      return SmartRefresher(
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
        onRefresh: _refreshContent,
        onLoading: _loadContent,
        child: ListView.builder(
            itemCount: 1,
            itemBuilder: (context, i) {
              return Container(
                child: Column(
                  children: [
                    // 推荐用户区域
                    _recommendUserArea,
                    // 话题区域
                    _recommendGambitArea,
                    Column(
                      children: _contentItemList,
                    )
                  ],
                ),
              );
            }),
      );
    });
  }
}
