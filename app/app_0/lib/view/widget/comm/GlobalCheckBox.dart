import 'dart:core';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 全局复选框
/// -------------------------------
class GlobalCheckBox {
  /// 未选中
  Widget _buildNotSelectedBtn() {
    return Container(
      //设置 child 居中
      alignment: Alignment(0, 0),
      height: 60,
      width: 60,
      //边框设置
      decoration: new BoxDecoration(
        //背景
        color: Colors.transparent,
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        //设置四周边框
        border:
            new Border.all(width: 2, color: Color(GlobalColor.APP_THEME_COLOR)),
      ),
    );
  }

  /// 选中
  Widget _buildSelectedBtn() {
    return Container(
      //设置 child 居中
      alignment: Alignment(0, 0),
      height: 60,
      width: 60,
      //边框设置
      decoration: new BoxDecoration(
        //背景
        color: Color(GlobalColor.APP_THEME_COLOR),
        //设置四周圆角 角度
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        //设置四周边框
        border: new Border.all(width: 2, color: Colors.red),
      ),
      child: Center(
        child: Icon(
          Icons.check,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  /// 构建复选框
  Widget buildCheckBox(String key) {
    if (_statusRecord['${key}'] == null) {
      _statusRecord['${key}'] = false;
      return _buildNotSelectedBtn();
    }
    if (_statusRecord['${key}']) {
      return _buildSelectedBtn();
    }
    return _buildNotSelectedBtn();
  }

  /// 状态标识符
  bool _checkSelectedStatus = false;

  /// 状态符记录
  Map<String, bool> _statusRecord = new Map();

  bool get checkSelectedStatus => _checkSelectedStatus;

  set checkSelectedStatus(bool value) {
    _checkSelectedStatus = value;
  }

  Map<String, bool> get statusRecord => _statusRecord;

  set statusRecord(Map<String, bool> value) {
    _statusRecord = value;
  }
}
