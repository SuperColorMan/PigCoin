/// -------------------------------
/// Des: 全局数学工具类
/// -------------------------------
class GlobalMatUtils {
  /// 图片显示矩阵个数计算
  /// sum : 图片总数
  static int imgShowCountCal(int sum) {
    if (sum <= 3) {
      return sum;
    } else if (sum > 3) {
      return 3;
    }
  }
}
