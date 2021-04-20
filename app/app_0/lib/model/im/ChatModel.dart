///-------------------------
/// des : 私信模型
/// -------------------------
class ChatModel {
  ///发送者用户id
  String _userId;

  ///发送对方用户id
  String _byUserId;

  /// 内容类型
  String _type;

  /// 内容
  String _content;

  ChatModel(this._userId, this._byUserId, this._type, this._content);

  String get content => _content;

  set content(String value) {
    _content = value;
  }

  String get type => _type;

  set type(String value) {
    _type = value;
  }

  String get byUserId => _byUserId;

  set byUserId(String value) {
    _byUserId = value;
  }

  String get userId => _userId;

  set userId(String value) {
    _userId = value;
  }

  @override
  String toString() {
    return '{"userId": "${_userId}", "byUserId": "${_byUserId}", "type": "${_type}", "content": "${_content}"}';
  }
}
