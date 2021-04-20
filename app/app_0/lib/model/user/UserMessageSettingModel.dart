///-------------------------
/// des : 用户通知设置数据模型
/// -------------------------
class UserMessageSettingModel {
  /// 用户id
  String userId;

  /// 是否推送热门内容,0:否,1:是
  bool isHotContentPush;

  /// 是否推送关注的人更新的内容,0:否,1:是
  bool isAttUserUpdatePush;

  /// 评论是否通知,0:否,1:是
  bool isCommentInform;

  ///  点赞是否通知,0:否,1:是
  bool isGoodInform;

  /// 关注该用户是否通知,0:否,1:是
  bool isAttInform;

  /// @该用户是否通知,0:否,1:是
  bool isAtInform;

  /// 私信是否通知,0:否,1:是
  bool isChatInform;

  UserMessageSettingModel(
      {this.userId="-1",
      this.isHotContentPush=false,
      this.isAttUserUpdatePush=false,
      this.isCommentInform=false,
      this.isGoodInform=false,
      this.isAttInform=false,
      this.isAtInform=false,
      this.isChatInform=false});
}
