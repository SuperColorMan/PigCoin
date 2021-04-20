/// -------------------------------
/// Des: 全局函数
/// -------------------------------
class StringUtil {
  ///大陆手机号码11位数，匹配格式：前三位固定格式+后8位任意数
  /// 此方法中前三位格式有：
  /// 13+任意数 * 15+除4的任意数 * 18+除1和4的任意数 * 17+除9的任意数 * 147
  static bool isChinaPhoneLegal(String str) {
    return new RegExp(
            '^((13[0-9])|(15[^4])|(166)|(17[0-8])|(18[0-9])|(19[8-9])|(147,145))\\d{8}\$')
        .hasMatch(str);
  }

  /// 设置数字单位
  static String setNumberUnits(num number) {
    if(number==null){
      return "0";
    }
    String showNumber = number.toString();
    if (number >= 10000) {
      showNumber =
          number.toString().substring(0, number.toString().length - 4) + "万";
    }
    if (number >= 1000000) {
      showNumber =
          number.toString().substring(0, number.toString().length - 6) + "百万";
    }
    if (number >= 10000000) {
      showNumber =
          number.toString().substring(0, number.toString().length - 7) + "千万";
    }
    if (number >= 100000000) {
      showNumber =
          number.toString().substring(0, number.toString().length - 8) + "亿";
    }
    return showNumber;
  }
}
