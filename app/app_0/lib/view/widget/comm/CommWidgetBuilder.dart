import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

class CommWidgetBuilder {
  /// 构建渐变按钮
  static Widget gradientButton(String btnText,
      {double fontSize, double circularValue = 5, Function callBack}) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            Color(GlobalColor.APP_THEME_COLOR),
            Color(GlobalColor.APP_THEME_COLOR_IS_STATUS)
          ]), // 渐变色
          borderRadius: BorderRadius.circular(circularValue)),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(circularValue)),
        color: Colors.transparent,
        // 设为透明色
        elevation: 0,
        // 正常时阴影隐藏
        highlightElevation: 0,
        onPressed: () {
          if (callBack != null) {
            /// 调用回调
            callBack();
          }
        },
        child: Container(
          alignment: Alignment.center,
          child: Text(
            '${btnText}',
            style: TextStyle(
                color: Colors.white,
                fontSize: fontSize != null ? fontSize : 16),
          ),
        ),
      ),
    );
  }
}
