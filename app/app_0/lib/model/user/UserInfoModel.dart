import 'package:flutter/cupertino.dart';

///-------------------------
/// des : 用户信息数据模型
/// -------------------------

class UserInfoModel {
  ///用户id
  String id;

  /// 用户个性化id
  String uid;

  /// 用户名
  String userName;

  /// 性别,0:女;1:男;
  String sex;

  /// 生日,格式:yyyy-MM-dd
  String birthday;

  /// 所在地
  String local;

  /// 简介
  String intro;

  /// 关注数
  String attentionConut;

  /// 粉丝数
  String fansCount;

  /// 获赞
  String goodCount;

  /// 热评
  String hotCommentCount;

  /// 收藏数
  String collectCount;

  /// 被收藏数
  String byCollectCount;

  /// 用户头像
  String userHeadImg;

  /// 用户头像
  String userBgImg;

  /// 今日新增查看量
  String newAddLookCount;

  /// 今日新增获赞数
  String newAddGoodCount;

  /// 今日新增收藏数
  String newAddCollectCount;

  UserInfoModel(BuildContext context,
      {this.id = "-1",
      this.uid = "",
      this.userName = "",
      this.sex = "",
      this.birthday = "",
      this.local = "",
      this.intro = "",
      this.attentionConut = "0",
      this.fansCount = "0",
      this.goodCount = "0",
      this.hotCommentCount = "0",
      this.collectCount = "0",
      this.byCollectCount = "0",
      this.userHeadImg = "",
      this.userBgImg = "",
      this.newAddLookCount = "0",
      this.newAddGoodCount = "0",
      this.newAddCollectCount = "0"});
}
