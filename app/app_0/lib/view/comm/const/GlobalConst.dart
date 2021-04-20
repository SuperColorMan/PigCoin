import 'package:flustars/flustars.dart';
import 'package:flutter/services.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/text/handler/my_special_text_span_builder.dart';

/// -------------------------------
/// Des: 全局常量类
/// -------------------------------

class GlobalConst {
  /// 网络请求接口类
  static GlobalNetApiCall NET_API_CALL = GlobalNetApiCall();

  /// 应用名称
  static String APP_NAME = "浪浪虾";

  /// 全局支付单位
  static String PAY_UNIT = "¥";

  /// 回复区域高度
  static num REPLY_AREA_HEIGHT = ScreenUtil.getInstance().screenHeight * 0.75;

  /// 选择区域高度
  static num SELECT_AREA_HEIGHT = ScreenUtil.getInstance().screenHeight * 0.25;

  /// 表情选择区域高度
  static num FACE_SELECT_AREA_HEIGHT =
      ScreenUtil.getInstance().screenHeight * 0.25;

  /// 特殊文本处理器
  static MySpecialTextSpanBuilder SPECIAL_TEXT_SPAN_BUILDER =
      MySpecialTextSpanBuilder();

  /// -------------- 隐藏软键盘 --------------
  /// callBack : 回调函数
  /// ------------------------------------------
  static Function hideSoftKeyBoard(Function callBack) {
    SystemChannels.textInput
        .invokeMethod<void>('TextInput.hide')
        .whenComplete(() {
      Future<void>.delayed(const Duration(milliseconds: 200)).whenComplete(() {
        callBack();
      });
    });
  }

  /// -------------- 显示软键盘 --------------
  /// callBack : 回调函数
  /// ------------------------------------------
  static Function showSoftKeyBoard(Function callBack) {
    SystemChannels.textInput
        .invokeMethod<void>('TextInput.show')
        .whenComplete(() {
      Future<void>.delayed(const Duration(milliseconds: 200)).whenComplete(() {
        callBack();
      });
    });
  }
}
