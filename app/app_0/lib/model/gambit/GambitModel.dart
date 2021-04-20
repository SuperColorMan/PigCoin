///-------------------------
/// des : 话题数据模型
/// -------------------------
class GambitModel {
  ///话题id
  num _id ;

  /// 话题名称
  String _name;

  /// 话题内容数
  num _contentCount;

  GambitModel(this._id, this._name, this._contentCount);

  num get contentCount => _contentCount;

  set contentCount(num value) {
    _contentCount = value;
  }

  String get name => _name;

  set name(String value) {
    _name = value;
  }

  num get id => _id;

  set id(num value) {
    _id = value;
  }
}
