import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

import 'GlobalApiUrlTable.dart';

/// -------------------------------
/// Des: 全局网络api调用
/// -------------------------------

class GlobalNetApiCall {
  ///测试结构
  Future<String> testApi() async {
    String url = GlobalApiUrlTable.TEST_API;
    // post 请求 body 数据
    String jsonstr = (await http.get(url)).body;
    return jsonstr;
  }

  /// -------------------------------------------- 消息模块 start --------------------------------------------
  ///获取指定用户的消息列表
  Future<Map<String, dynamic>> getMessageByUserId(String userId) async {
    const url = GlobalApiUrlTable.SYS_MESSAGE_OR_CHAT;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// -------------------------------------------- 消息模块 end --------------------------------------------

  /// ------------------ 互动区域 start ------------------

  /// --------- 点赞区域 start ---------

  ///内容点赞接口
  Future<Map<String, dynamic>> contentGood(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CONTENT_GODD_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///内容点赞接口
  Future<Map<String, dynamic>> cancelContentGood(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_CONTENT_GODD_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///评论点赞接口
  Future<Map<String, dynamic>> commentGood(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.COMMENT_GODD_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///取消评论点赞接口
  Future<Map<String, dynamic>> cancelCommentGood(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_COMMENT_GODD_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///回复点赞接口
  Future<Map<String, dynamic>> replyGood(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.REPLY_GODD_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///取消回复点赞接口
  Future<Map<String, dynamic>> cancelReplyGood(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_REPLY_GODD_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// --------- 点赞区域 end ---------

  /// --------- 点踩区域 start ---------

  ///内容点踩接口
  Future<Map<String, dynamic>> contentDiss(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CONTENT_DISS_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///内容点踩接口
  Future<Map<String, dynamic>> cancelContentDiss(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_CONTENT_DISS_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///评论点踩接口
  Future<Map<String, dynamic>> commentDiss(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.COMMENT_DISS_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///取消评论点踩接口
  Future<Map<String, dynamic>> cancelCommentDiss(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_COMMENT_DISS_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///回复点踩接口
  Future<Map<String, dynamic>> replyDiss(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.REPLY_DISS_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///取消回复点踩接口
  Future<Map<String, dynamic>> cancelReplyDiss(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_REPLY_DISS_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// --------- 点踩区域 end ---------

  /// --------- 收藏区域 start ---------

  ///内容收藏接口
  Future<Map<String, dynamic>> contentCollect(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CONTENT_COLLECT_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///内容收藏接口
  Future<Map<String, dynamic>> cancelContentCollect(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_CONTENT_COLLECT_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///评论收藏接口
  Future<Map<String, dynamic>> commentCollect(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.COMMENT_COLLECT_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///取消评论收藏接口
  Future<Map<String, dynamic>> cancelCommentCollect(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_COMMENT_COLLECT_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///回复收藏接口
  Future<Map<String, dynamic>> replyCollect(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.REPLY_COLLECT_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///取消回复收藏接口
  Future<Map<String, dynamic>> cancelReplyCollect(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_REPLY_COLLECT_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// --------- 收藏区域 end ---------

  /// --------- 查看区域 start ---------

  ///内容查看接口
  Future<Map<String, dynamic>> contentLook(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CONTENT_LOOK_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///内容查看接口
  Future<Map<String, dynamic>> cancelContentLook(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_CONTENT_LOOK_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///评论查看接口
  Future<Map<String, dynamic>> commentLook(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.COMMENT_LOOK_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///取消评论查看接口
  Future<Map<String, dynamic>> cancelCommentLook(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_COMMENT_LOOK_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///回复查看接口
  Future<Map<String, dynamic>> replyLook(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.REPLY_LOOK_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///取消回复查看接口
  Future<Map<String, dynamic>> cancelReplyLook(
      String contentId, String loginUserId, String byUserId) async {
    const url = GlobalApiUrlTable.CANCEL_REPLY_LOOK_API;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
      'loginUserId': loginUserId,
      'byUserId': byUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// --------- 查看区域 end ---------

  /// ------------------ 互动区域 end ------------------

  /// ------------------ 登录区域 start ------------------

  /// 登录
  Future<Map> login(String account, String pass) async {
    const url = GlobalApiUrlTable.LOGIN_API;
    // post 请求 body 数据
    var data = {
      'account': account,
      'pass': pass,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 注册
  Future<Map<String, dynamic>> register(
      String account, String pass, String uid) async {
    const url = GlobalApiUrlTable.REGISTER_API;
    // post 请求 body 数据
    var data = {'account': account, 'pass': pass, 'uid': uid};
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// ------------------ 登录区域 end ------------------

  /// ------------------ 用户区域 start ------------------

  ///上传用户头像
  Future<Map<String, dynamic>> upUserHeadPic(
      String userId, Uint8List img) async {
    const url = GlobalApiUrlTable.UP_USER_HEAD_PIC;
    var dio = new Dio();
    FormData formData = FormData();
    formData.fields.add(MapEntry("userId", userId));
    formData.fields.add(MapEntry("headPicBase64", base64.encode(img)));
    var response = await dio.post(url, data: formData);
    Map<String, dynamic> resMap = response.data;
    return resMap;
  }

  ///上传用户背景
  Future<Map<String, dynamic>> upUserBgPic(String userId, Uint8List img) async {
    const url = GlobalApiUrlTable.UP_USER_BG_PIC;
    var dio = new Dio();
    FormData formData = FormData();
    formData.fields.add(MapEntry("userId", userId));
    formData.fields.add(MapEntry("gbPicBase64", base64.encode(img)));
    var response = await dio.post(url, data: formData);
    Map<String, dynamic> resMap = response.data;
    return resMap;
  }

  ///编辑用户信息
  Future<Map<String, dynamic>> editUserInfo(Map userInfo) async {
    const url = GlobalApiUrlTable.USER_EDIT_INFO;
    // post 请求 body 数据
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: userInfo)).bodyBytes));
    return map;
  }

  ///编辑用户设置
  Future<Map<String, dynamic>> editUserSetting(Map userSetting) async {
    const url = GlobalApiUrlTable.USER_EDIT_SETTING;
    // post 请求 body 数据
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: userSetting)).bodyBytes));
    return map;
  }

  ///获取指定用户名的信息
  Future<Map<String, dynamic>> getUserInfoByName(String userName) async {
    const url = GlobalApiUrlTable.GET_USER_INFO_BY_NAME;
    // post 请求 body 数据
    var data = {
      'userName': userName,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///搜索用户
  Future<Map<String, dynamic>> searchUser(
      String keyWord, String page, String pageSize) async {
    const url = GlobalApiUrlTable.SEARCH_USER;
    // post 请求 body 数据
    var data = {
      'keyWord': keyWord,
      'page': page,
      'pageSize': pageSize,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取指定用户关注的用户列表
  Future<Map<String, dynamic>> getUserAttentionListById(
      String userId, String page, String pageSize) async {
    const url = GlobalApiUrlTable.GET_USER_ATTENTION_LIST;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'page': page,
      'pageSize': pageSize,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取指定用户关注的用户列表
  Future<Map<String, dynamic>> getFansListByUserId(
      String userId, String page, String pageSize) async {
    const url = GlobalApiUrlTable.GET_FANS_LIST_BY_USER_ID;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'page': page,
      'pageSize': pageSize,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取指定用户被点赞与收藏的内容
  Future<Map<String, dynamic>> getByCollectAndGoodContentListByUserId(
      String userId, String loginUserId, String page, String pageSize) async {
    const url =
        GlobalApiUrlTable.GET_BY_COLLECT_AND_GOOD_CONTENT_LIST_BY_USER_ID;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'loginUserId': loginUserId,
      'page': page,
      'pageSize': pageSize,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取指定用户被评论与@的内容
  Future<Map<String, dynamic>> getByCommentAndAtContentListByUserId(
      String userId, String loginUserId, String page, String pageSize) async {
    const url = GlobalApiUrlTable.GET_BY_COMMENT_AND_AT_CONTENT_LIST_BY_USER_ID;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'loginUserId': loginUserId,
      'page': page,
      'pageSize': pageSize,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// ------------------ 用户区域 end ------------------

  /// ------------------ 话题区域 start ------------------
  /// 获取话题分类树
  Future<Map<String, dynamic>> getGambitClassifyTree() async {
    const url = GlobalApiUrlTable.GET_GAMBIT_TREE;
    Map<String, dynamic> map = json
        .decode(await Utf8Decoder().convert((await http.post(url)).bodyBytes));
    return map;
  }

  /// 搜索话题
  Future<Map<String, dynamic>> searchGambit(
      String keyWord, String loginUserId) async {
    const url = GlobalApiUrlTable.SEARCH_GAMBIT;
    // post 请求 body 数据
    var data = {
      'keyWord': keyWord,
      'loginUserId': loginUserId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// ------------------ 话题区域 end ------------------

  /// ------------------ 内容区域 start ------------------

  ///获取指定用户的全部的内容
  Future<Map<String, dynamic>> getUserContentByClassify(String userId,
      String loginUserId, String page, String pageSize, String classify) async {
    const url = GlobalApiUrlTable.GET_USER_CONTNET_BY_CLASSIFY_API;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'loginUserId': loginUserId,
      'page': page,
      'pageSize': pageSize,
      'contentClassify': classify
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取指定分类的内容
  Future<Map<String, dynamic>> getHotCommentListByContentId(
      String contentId, String loginUserId) async {
    const url = GlobalApiUrlTable.GET_HOT_COMMENT_LIST_API;
    // post 请求 body 数据
    var data = {'contentId': contentId, 'loginUserId': loginUserId};
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取指定内容加入的话题列表
  Future<Map<String, dynamic>> getJoinGambitListByContentId(
      String contentId) async {
    const url = GlobalApiUrlTable.GET_JOIN_GAMBIT_LIST_BY_CONTENT_ID;
    // post 请求 body 数据
    var data = {'contentId': contentId};
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取指定分类的内容
  Future<Map<String, dynamic>> getContentByType(
      Map<String, String> reqParam) async {
    const url = GlobalApiUrlTable.GET_CONTENT_BY_TYPE_API;
    // post 请求 body 数据
//    var data = {
//      'loginUserId': loginUserId,
//      'contentClassify': contentClassify,
//      'page': page,
//      'pageSize': pageSize
//    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: reqParam)).bodyBytes));
    return map;
  }

  ///获取指定用户的查看内容历史
  Future<Map<String, dynamic>> getLookContentHistoryByUserId(
      Map<String, String> reqParam) async {
    const url = GlobalApiUrlTable.GET_LOOK_CONTENT_HISTORY_BY_USER_ID;
    // post 请求 body 数据
//    var data = {
//      'loginUserId': loginUserId,
//      'contentClassify': contentClassify,
//      'page': page,
//      'pageSize': pageSize
//    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: reqParam)).bodyBytes));
    return map;
  }

  ///获取指定用户发起评论的内容
  Future<Map<String, dynamic>> getUserCommentContentListByUserId(
      String loginUserId, String userId, String page, String pageSize) async {
    const url = GlobalApiUrlTable.GET_USER_COMMENT_CONTENT_LIST;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'loginUserId': loginUserId,
      'page': page,
      'pageSize': pageSize
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取指定内容下的评论列表
  Future<Map<String, dynamic>> getCommentListByContentId(String contentId,
      String userId, String page, String pageSize, List filter) async {
    const url = GlobalApiUrlTable.GET_COMMENT_List_API;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'contentId': contentId,
      'page': page,
      'pageSize': pageSize,
      'filter': filter.toString()
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取指定评论下的回复列表
  Future<Map<String, dynamic>> getReplyListByCommentId(
      String contentId,
      String commentId,
      String loginUserId,
      String page,
      String pageSize) async {
    const url = GlobalApiUrlTable.GET_REPLY_LIST_API;
    // post 请求 body 数据
    var data = {
      'loginUserId': loginUserId,
      'contentId': contentId.toString(),
      'commentId': commentId.toString(),
      'page': page,
      'pageSize': pageSize
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取指定分类的内容
  Future<Map<String, dynamic>> getSearchResultType() async {
    const url = GlobalApiUrlTable.GET_SEARCH_RESULT_TYPE_API;
    Map<String, dynamic> map = json
        .decode(await Utf8Decoder().convert((await http.post(url)).bodyBytes));
    return map;
  }

  ///搜索内容接口URI
  Future<Map<String, dynamic>> getSearchContent(
      String loginUserId,
      String userId,
      String page,
      String pageSize,
      String searchType,
      String keyWord) async {
    const url = GlobalApiUrlTable.SEARCH_CONTENT;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'loginUserId': loginUserId,
      'page': page,
      'pageSize': pageSize,
      'searchType': searchType,
      'keyWord': keyWord
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  ///获取话题下的内容列表
  Future<Map<String, dynamic>> getContentListByGambitId(String gambitId,
      String loginUserId, String page, String pageSize, String type) async {
    const url = GlobalApiUrlTable.GET_CONTENT_LIST_BY_GAMBIT_ID;
    // post 请求 body 数据
    var data = {
      'gambitId': gambitId,
      'loginUserId': loginUserId,
      'page': page,
      'pageSize': pageSize,
      'type': type,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// ------------------ 内容区域 end ------------------

  /// -------------------------- 数据计算相关 start--------------------------
  /// 获取用户今日新增数据信息
  Future<Map<String, dynamic>> getToDayInfo(String userId) async {
    const url = GlobalApiUrlTable.CAL_USER_TO_DAY_INFO;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取指定用户总体卖出商品量
  Future<Map<String, dynamic>> getSaleCommoditySumByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.GET_SALE_COMMODITY_SUM;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取指定用户发布的商品的总体分类
  Future<Map<String, dynamic>> getCommodityClassifyByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_COMMODITY_CLASSIFY;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 卖出分类数据初始化
  Future<Map<String, dynamic>> getSaleCommodityClassifyByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_SALE_COMMODITY_CLASSIFY;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// ---------------------------- 商品周卖出量 start ----------------------------
  /// 获取用户周卖出量
  Future<Map<String, dynamic>> getSaleCommoditySumByWeekByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_SALE_COMMODITY_SUM_BY_WEEK;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取用户月卖出量
  Future<Map<String, dynamic>> getSaleCommoditySumByMonthByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_SALE_COMMODITY_SUM_BY_MONTH;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取用户年卖出量
  Future<Map<String, dynamic>> getSaleCommoditySumByYearByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_SALE_COMMODITY_SUM_BY_YEAR;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// ---------------------------- 商品周卖出量 end ----------------------------

  /// ---------------------------- 商品周浏览量 start ----------------------------
  /// 获取用户周浏览量
  Future<Map<String, dynamic>> getLookCommoditySumByWeekByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_LOOK_COMMODITY_SUM_BY_WEEK;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取用户月浏览量
  Future<Map<String, dynamic>> getLookCommoditySumByMonthByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_LOOK_COMMODITY_SUM_BY_MONTH;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取用户年浏览量
  Future<Map<String, dynamic>> getLookCommoditySumByYearByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_LOOK_COMMODITY_SUM_BY_YEAR;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// ---------------------------- 商品周浏览量 end ----------------------------

  /// ---------------------------- 商品周加入购物车量 start ----------------------------
  /// 获取用户商品周加入购物车量
  Future<Map<String, dynamic>> getJoinShopCarCommoditySumByWeekByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_JOIN_SHOP_CAR_COMMODITY_SUM_BY_WEEK;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取用户商品月加入购物车量
  Future<Map<String, dynamic>> getJoinShopCarCommoditySumByMonthByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_JOIN_SHOP_CAR_COMMODITY_SUM_BY_MONTH;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取用户商品年加入购物车量
  Future<Map<String, dynamic>> getJoinShopCarCommoditySumByYearByUserId(
      String userId) async {
    const url = GlobalApiUrlTable.CAL_JOIN_SHOP_CAR_COMMODITY_SUM_BY_YEAR;
    // post 请求 body 数据
    var data = {
      'userId': userId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// ---------------------------- 商品周加入购物车量 end ----------------------------

  /// -------------------------- 数据计算相关 start--------------------------

  /// -------------------------- 内容上传处理区域 start--------------------------

  ///上传内容
  Future<Map<String, dynamic>> upContent(
      String userId,
      String body,
      List<String> imgs,
      List<String> atUserIdListStr,
      List<String> joinGambitIdList) async {
    const url = GlobalApiUrlTable.UP_CONTENT_API;
    var dio = new Dio();
    FormData formData = FormData();
    formData.fields.add(MapEntry("userId", userId));
    formData.fields.add(MapEntry("body", body));
    formData.fields
        .add(MapEntry("atUserIdListStr", json.encode(atUserIdListStr)));
    formData.fields
        .add(MapEntry("joinGambitIdListStr", json.encode(joinGambitIdList)));
    for (String path in imgs) {
      formData.files.add(MapEntry("imgs", await MultipartFile.fromFile(path)));
    }
    var response = await dio.post(url, data: formData);
    Map<String, dynamic> resMap = response.data;
    return resMap;
  }

  ///评论内容
  Future<Map<String, dynamic>> commentContent(
      String userId,
      String byUserId,
      String byUserName,
      String contentId,
      String body,
      List<String> imgs,
      List<num> atUserIdListStr) async {
    const url = GlobalApiUrlTable.COMMENT_CONTENT_API;
    var dio = new Dio();
    FormData formData = FormData();
    formData.fields.add(MapEntry("userId", userId));
    formData.fields.add(MapEntry("contentId", contentId));
    formData.fields.add(MapEntry("byUserId", byUserId));
    formData.fields.add(MapEntry("byUserName", byUserName));
    formData.fields.add(MapEntry("body", body));
    formData.fields
        .add(MapEntry("atUserIdListStr", json.encode(atUserIdListStr)));
    for (String path in imgs) {
      formData.files.add(MapEntry("imgs", await MultipartFile.fromFile(path)));
    }
    var response = await dio.post(url, data: formData);
    Map<String, dynamic> resMap = response.data;
    return resMap;
  }

  ///回复评论
  Future<Map<String, dynamic>> replyComment(
      String userId,
      String byUserId,
      String byUserName,
      String contentId,
      String commentId,
      String body,
      List<String> imgs,
      List<String> atUserIdListStr) async {
    const url = GlobalApiUrlTable.REPLY_API;
    var dio = new Dio();
    FormData formData = FormData();
    formData.fields.add(MapEntry("contentId", contentId.toString()));
    formData.fields.add(MapEntry("commentId", commentId.toString()));
    formData.fields.add(MapEntry("userId", userId.toString()));
    formData.fields.add(MapEntry("byUserId", byUserId.toString()));
    formData.fields.add(MapEntry("byUserName", byUserName));
    formData.fields.add(MapEntry("body", body));
    formData.fields.add(MapEntry("byType", "0"));
    formData.fields
        .add(MapEntry("atUserIdListStr", json.encode(atUserIdListStr)));
    for (String path in imgs) {
      formData.files.add(MapEntry("imgs", await MultipartFile.fromFile(path)));
    }
    var response = await dio.post(url, data: formData);
    Map<String, dynamic> resMap = response.data;
    return resMap;
  }

  ///回复回复
  Future<Map<String, dynamic>> replyReply(
      String userId,
      String byUserId,
      String byUserName,
      String contentId,
      String commentId,
      String replyId,
      String body,
      List<String> imgs,
      List<String> atUserIdListStr) async {
    const url = GlobalApiUrlTable.REPLY_API;
    var dio = new Dio();
    FormData formData = FormData();
    formData.fields.add(MapEntry("contentId", contentId.toString()));
    formData.fields.add(MapEntry("commentId", commentId.toString()));
    formData.fields.add(MapEntry("userId", userId.toString()));
    formData.fields.add(MapEntry("byUserId", byUserId.toString()));
    formData.fields.add(MapEntry("byUserName", byUserName));
    formData.fields.add(MapEntry("body", body));
    formData.fields.add(MapEntry("byType", "1"));
    formData.fields.add(MapEntry("replyId", replyId.toString()));
    formData.fields
        .add(MapEntry("atUserIdListStr", json.encode(atUserIdListStr)));
    for (String path in imgs) {
      formData.files.add(MapEntry("imgs", await MultipartFile.fromFile(path)));
    }
    var response = await dio.post(url, data: formData);
    Map<String, dynamic> resMap = response.data;
    return resMap;
  }

  /// -------------------------- 内容上传处理区域 end--------------------------

  /// ------------------ 商城区域 start ------------------

  /// 获取指定用户的商品
  Future<Map<String, dynamic>> getCommodityListByUserId(
      String userId,
      String page,
      String pageSize) async {
    const url = GlobalApiUrlTable.GET_COMMODITY_LIST_BY_USER_ID;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'page': page,
      'pageSize': pageSize
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取指定多个分类的商品
  Future<Map<String, dynamic>> getCommodityListByClassifys(
      String commodityClassifyIds,
      String page,
      String pageSize) async {
    const url = GlobalApiUrlTable.GET_COMMODITY_LIST_BY_CLASSIFYS;
    // post 请求 body 数据
    var data = {
      'commodityClassifyIds': commodityClassifyIds,
      'page': page,
      'pageSize': pageSize
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取指定用户关注的用户发布的商品
  Future<Map<String, dynamic>> getCommodityListByUserAttentionUser(
      String userId,
      String page,
      String pageSize) async {
    const url = GlobalApiUrlTable.GET_COMMODITY_LIST_BY_USER_ATTENTION_USER;
    // post 请求 body 数据
    var data = {
      'userId': userId,
      'page': page,
      'pageSize': pageSize
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取用户商品年加入购物车量
  Future<Map<String, dynamic>> getRelCommodityByContentId(
      String contentId) async {
    const url = GlobalApiUrlTable.GET_REL_COMMODITY_BY_CONTENT_ID;
    // post 请求 body 数据
    var data = {
      'contentId': contentId,
    };
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: data)).bodyBytes));
    return map;
  }

  /// 获取推荐商品
  Future<Map<String, dynamic>> getRecommendCommodityList(
      Map<String, String> reqParam) async {
    const url = GlobalApiUrlTable.GET_RECOMMEND_COMMODITY_LIST;
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: reqParam)).bodyBytes));
    return map;
  }

  /// 获取指定大类下的商品
  Future<Map<String, dynamic>> getCommodityListByBigClassifyId(
      Map<String, String> reqParam) async {
    const url = GlobalApiUrlTable.GET_COMMODITY_LIST_BY_BIG_CLASSIFY_ID;
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: reqParam)).bodyBytes));
    return map;
  }

  /// 获取商品分类树
  Future<Map<String, dynamic>> getBigClassifyList() async {
    const url = GlobalApiUrlTable.GET_BIG_CLASSIFY_LIST;
    Map<String, dynamic> map = json
        .decode(await Utf8Decoder().convert((await http.post(url)).bodyBytes));
    return map;
  }

  /// 获取商品分类树
  Future<Map<String, dynamic>> getCommodityClassifyTree() async {
    const url = GlobalApiUrlTable.GET_COMMODITY_CLASSIFY_TREE;
    Map<String, dynamic> map = json
        .decode(await Utf8Decoder().convert((await http.post(url)).bodyBytes));
    return map;
  }

  /// 获取指定大类下的小类列
  Future<Map<String, dynamic>> getSmallClassifyListByBigId(
      Map<String, String> reqParam) async {
    const url = GlobalApiUrlTable.GET_SMALL_CLASSIFY_LIST_BY_BIG_CLASSIFY_ID;
    Map<String, dynamic> map = json.decode(await Utf8Decoder()
        .convert((await http.post(url, body: reqParam)).bodyBytes));
    return map;
  }


  ///评论商品
  Future<Map<String, dynamic>> commentCommodity(
      String userId,
      String byUserId,
      String byUserName,
      String contentId,
      String body,
      List<String> imgs,
      List<num> atUserIdListStr) async {
    const url = GlobalApiUrlTable.COMMENT_COMMODITY_API;
    var dio = new Dio();
    FormData formData = FormData();
    formData.fields.add(MapEntry("userId", userId));
    formData.fields.add(MapEntry("contentId", contentId));
    formData.fields.add(MapEntry("byUserId", byUserId));
    formData.fields.add(MapEntry("byUserName", byUserName));
    formData.fields.add(MapEntry("body", body));
    formData.fields
        .add(MapEntry("atUserIdListStr", json.encode(atUserIdListStr)));
    for (String path in imgs) {
      formData.files.add(MapEntry("imgs", await MultipartFile.fromFile(path)));
    }
    var response = await dio.post(url, data: formData);
    Map<String, dynamic> resMap = response.data;
    return resMap;
  }

  ///以用户身份发布商品
  Future<Map<String, dynamic>> commentReleaseByUser(
      String userId,
      String name,
      String price,
      String freight,
      String describe,
      List<String> imgs,
      List<Map> classifyList) async {
    const url = GlobalApiUrlTable.COMMODITY_RELEASE_BY_USER;
    var dio = new Dio();
    FormData formData = FormData();

    /// 商品来源id
    formData.fields.add(MapEntry("commoditySrcId", userId));

    /// 商品描述
    formData.fields.add(MapEntry("name", name));

    /// 商品单价
    formData.fields.add(MapEntry("price", price));

    /// 运费
    formData.fields.add(MapEntry("freight", price));

    /// 商品描述
    formData.fields.add(MapEntry("describe", describe));

    /// 商品所属分类
    formData.fields.add(MapEntry("classifyList", json.encode(classifyList)));
    for (String path in imgs) {
      formData.files.add(MapEntry("imgs", await MultipartFile.fromFile(path)));
    }
    var response = await dio.post(url, data: formData);
    Map<String, dynamic> resMap = response.data;
    return resMap;
  }

  /// ------------------ 商城区域 end ------------------

}
