import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCacheKey.dart';

/// -------------------------------
/// Des: 全局本地缓存
/// -------------------------------
class GlobalLocalCache {
  /// ----------------- 缓存登录用户信息 start -----------------
  /// 缓存登录用户信息
  static Future<void> cacheLoginUserInfo(Map loginUserInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        GlobalLocalCacheKey.LOGIN_USER_INFO, jsonEncode(loginUserInfo));
  }

  /// 删除缓存登录用户信息
  static Future<void> delLoginUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(GlobalLocalCacheKey.LOGIN_USER_INFO);
  }

  /// 获取缓存登录用户信息
  static Future<String> getLoginUserInfo() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getString(GlobalLocalCacheKey.LOGIN_USER_INFO) == null
        ? null
        : prefs.getString(GlobalLocalCacheKey.LOGIN_USER_INFO);
  }

  /// 更新缓存登录用户信息
  static void updateLoginUserInfo(Map userInfo) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Map loginUserInfo =
        await prefs.getString(GlobalLocalCacheKey.LOGIN_USER_INFO) == null
            ? null
            : json.decode(prefs.getString(GlobalLocalCacheKey.LOGIN_USER_INFO));
    if (loginUserInfo != null) {
      userInfo.forEach((key, value) {
        loginUserInfo[key] = value;
      });

      /// 刷新缓存
      cacheLoginUserInfo(loginUserInfo);
    }
  }

  /// ----------------- 缓存登录用户信息 end -----------------

  /// ----------------- 缓存登录用户id start -----------------
  /// 缓存登录用户id
  static Future<void> cacheLoginUserId(num loginUserId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt(GlobalLocalCacheKey.LOGIN_USER_ID, loginUserId);
  }

  /// 删除缓存登录用户id
  static Future<void> delLoginUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove(GlobalLocalCacheKey.LOGIN_USER_ID);
  }

  /// 获取缓存登录用户id
  static Future<num> getLoginUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs.getInt(GlobalLocalCacheKey.LOGIN_USER_ID) == null
        ? 0
        : prefs.getInt(GlobalLocalCacheKey.LOGIN_USER_ID);
  }

  /// ----------------- 缓存登录用户id end -----------------

  /// ----------------- 缓存登录用户id start -----------------
  /// 缓存登录用户设置信息
  static Future<void> cacheLoginUserSetting(Map loginUserSetting) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(
        GlobalLocalCacheKey.LOGIN_USER_SETTING, jsonEncode(loginUserSetting));
  }

  /// ----------------- 缓存登录用户id end -----------------

  /// ----------------- 关键字缓存 start -----------------
  /// 缓存搜索关键字列表
  static void cacheSearchKeyWordList(String searchKeyWord) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchKeyWordList =
        await prefs.getStringList(GlobalLocalCacheKey.SEARCH_KEY_WORD_LIST);
    if (searchKeyWordList == null) {
      searchKeyWordList = List<String>();
    }
    if (!searchKeyWordList.contains(searchKeyWord)) {
      /// 不存在时缓存
      searchKeyWordList.add(searchKeyWord);
    }
    prefs.setStringList(
        GlobalLocalCacheKey.SEARCH_KEY_WORD_LIST, searchKeyWordList);
  }

  /// 缓存搜索关键字列表
  static Future<List<String>> getSearchKeyWordList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return await prefs
                .getStringList(GlobalLocalCacheKey.SEARCH_KEY_WORD_LIST) ==
            null
        ? List<String>()
        : prefs.getStringList(GlobalLocalCacheKey.SEARCH_KEY_WORD_LIST);
  }

  /// 清空搜索关键字缓存
  static void cleanSearchKeyWordList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List<String> searchKeyWordList =
        await prefs.getStringList(GlobalLocalCacheKey.SEARCH_KEY_WORD_LIST);
    searchKeyWordList = List<String>();
    prefs.setStringList(
        GlobalLocalCacheKey.SEARCH_KEY_WORD_LIST, searchKeyWordList);
  }

  /// ----------------- 关键字缓存 end -----------------

}
