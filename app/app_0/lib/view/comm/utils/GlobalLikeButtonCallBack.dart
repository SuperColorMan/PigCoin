import 'dart:async';

import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';

/// -------------------------------
/// Des: 全局喜欢按钮回调函数
/// -------------------------------
class GlobalLikeButtonCallBack {
  /// -------------------------------
  /// Des: 全局状态按钮异步回调
  /// -------------------------------
  static Future<bool> onLikeButtonTap(
      bool isLiked, Function(Completer<bool> completer) callBack) {
    final Completer<bool> completer = new Completer<bool>();
//    Timer(const Duration(milliseconds: 2000), () {
//      // if your request is failed,return null,
//    });
    return callBack(completer);
  }

  /// ------------------------------- 点赞处理区域 start -------------------------------
  /// -------------------------------
  /// Des: 点赞内容
  /// -------------------------------
  static Future<bool> contentGood(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        /// 修改状态
        completer.complete(isLiked ? false : true);
        if (isLiked) {
          ///  取消点赞内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelContentGood(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  点赞内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .contentGood(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast('请先登录');
      }
    });
    return completer.future;
  }

  /// -------------------------------
  /// Des: 点赞评论
  /// -------------------------------
  static Future<bool> commentGood(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        completer.complete(isLiked ? false : true);
        if (isLiked) {
          ///  取消点赞内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelCommentGood(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  点赞内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .commentGood(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast("请先登录");
      }
    });
    return completer.future;
  }

  /// -------------------------------
  /// Des: 点赞回复
  /// -------------------------------
  static Future<bool> replyGood(bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        completer.complete(isLiked ? false : true);
        if (isLiked) {
          ///  取消点赞内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelReplyGood(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  点赞内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .replyGood(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast("请先登录");
      }
    });
    return completer.future;
  }

  /// ------------------------------- 点赞处理区域 end -------------------------------

  /// ------------------------------- 点踩处理区域 start -------------------------------
  /// -------------------------------
  /// Des: 点踩内容
  /// -------------------------------
  static Future<bool> contentDiss(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        completer.complete(isLiked ? false : true);
        if (isLiked) {
          ///  取消点踩内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelContentDiss(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  点踩内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .contentDiss(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast("请先登录");
      }
    });
    return completer.future;
  }

  /// -------------------------------
  /// Des: 点踩评论
  /// -------------------------------
  static Future<bool> commentDiss(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        completer.complete(isLiked ? false : true);
        if (isLiked) {
          ///  取消点踩内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelCommentDiss(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  点踩内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .commentDiss(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast("请先登录");
      }
    });
    return completer.future;
  }

  /// -------------------------------
  /// Des: 点踩回复
  /// -------------------------------
  static Future<bool> replyDiss(bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        completer.complete(isLiked ? false : true);

        if (isLiked) {
          ///  取消点踩内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelReplyDiss(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  点踩内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .replyDiss(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast("请先登录");
      }
    });
    return completer.future;
  }

  /// ------------------------------- 点踩处理区域 end -------------------------------

  /// ------------------------------- 收藏处理区域 start -------------------------------
  /// -------------------------------
  /// Des: 收藏内容
  /// -------------------------------
  static Future<bool> contentCollect(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        completer.complete(isLiked ? false : true);
        if (isLiked) {
          ///  取消收藏内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelContentCollect(contentId.toString(),
                  loginUserId.toString(), byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  收藏内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .contentCollect(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast("请先登录");
      }
    });
    return completer.future;
  }

  /// -------------------------------
  /// Des: 收藏评论
  /// -------------------------------
  static Future<bool> commentCollect(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        completer.complete(isLiked ? false : true);

        if (isLiked) {
          ///  取消收藏内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelCommentCollect(contentId.toString(),
                  loginUserId.toString(), byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  收藏内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .commentCollect(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast("请先登录");
      }
    });
    return completer.future;
  }

  /// -------------------------------
  /// Des: 收藏回复
  /// -------------------------------
  static Future<bool> replyCollect(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        completer.complete(isLiked ? false : true);
        if (isLiked) {
          ///  取消收藏内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .cancelReplyCollect(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        } else {
          ///  收藏内容
          Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
              .replyCollect(contentId.toString(), loginUserId.toString(),
                  byUserId.toString());
          resMap.then((value) {
            /// 回传处理
          });
        }
      } else {
        GlobalToast.showToast("请先登录");
      }
    });
    return completer.future;
  }

  /// ------------------------------- 收藏处理区域 end -------------------------------

  /// ------------------------------- 查看处理区域 start -------------------------------
  /// -------------------------------
  /// Des: 查看内容
  /// -------------------------------
  static Future<bool> contentLook(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      completer.complete(isLiked ? false : true);

      if (isLiked) {
        ///  取消查看内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .cancelContentLook(contentId.toString(), loginUserId.toString(),
                byUserId.toString());
        resMap.then((value) {
          /// 回传处理
        });
      } else {
        ///  查看内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .contentLook(contentId.toString(), loginUserId.toString(),
                byUserId.toString());
        resMap.then((value) {
          /// 回传处理
        });
      }
    });
    return completer.future;
  }

  /// -------------------------------
  /// Des: 查看评论
  /// -------------------------------
  static Future<bool> commentLook(
      bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      completer.complete(isLiked ? false : true);

      if (isLiked) {
        ///  取消查看内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .cancelCommentLook(contentId.toString(), loginUserId.toString(),
                byUserId.toString());
        resMap.then((value) {
          /// 回传处理
        });
      } else {
        ///  查看内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .commentLook(contentId.toString(), loginUserId.toString(),
                byUserId.toString());
        resMap.then((value) {
          /// 回传处理
        });
      }
    });
    return completer.future;
  }

  /// -------------------------------
  /// Des: 查看回复
  /// -------------------------------
  static Future<bool> replyLook(bool isLiked, String contentId, String byUserId,
      {Function(Completer<bool> completer) callBack}) {
    final Completer<bool> completer = new Completer<bool>();
    Future<num> localCache =
        GlobalLocalCache.getLoginUserId().then((loginUserId) {
      completer.complete(isLiked ? false : true);
      if (isLiked) {
        ///  取消查看内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .cancelReplyLook(contentId.toString(), loginUserId.toString(),
                byUserId.toString());
        resMap.then((value) {
          /// 回传处理
        });
      } else {
        ///  查看内容
        Future<Map<String, dynamic>> resMap = GlobalConst.NET_API_CALL
            .replyLook(contentId.toString(), loginUserId.toString(),
                byUserId.toString());
        resMap.then((value) {
          /// 回传处理
        });
      }
    });
    return completer.future;
  }

  /// ------------------------------- 查看处理区域 end -------------------------------

}
