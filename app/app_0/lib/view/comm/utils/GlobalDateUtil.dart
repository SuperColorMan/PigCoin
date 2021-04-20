/// -------------------------------
/// Des: 全局时间工具
/// -------------------------------
class GlobalDateUtil {
  /// 获取当前时间戳
  static int getCurrentTimestamp() {
    return new DateTime.now().microsecondsSinceEpoch;
  }
}
