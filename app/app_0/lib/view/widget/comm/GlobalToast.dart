import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

class GlobalToast {
  /// 全局消息提示框
  static void showToast(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIos: 1,
        backgroundColor: Color(GlobalColor.LUCENCY_BLACK),
        textColor: Colors.white,
        fontSize: 15.0);
  }
}
