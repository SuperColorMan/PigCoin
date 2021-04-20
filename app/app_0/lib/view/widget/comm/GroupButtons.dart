import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 组合按钮
/// -------------------------------
class GroupButtons extends StatefulWidget {
  /// 按钮列表
  List<Widget> buttonList;

  /// 按钮选中句柄列表
  List<bool> clickList;

  /// 点击回调
  Function callBack;

  GroupButtons(this.buttonList, this.clickList, {Key key, this.callBack})
      : super(key: key);

  @override
  _GroupButtonsState createState() {
    return _GroupButtonsState();
  }
}

class _GroupButtonsState extends State<GroupButtons> {
  @override
  Widget build(BuildContext context) {
    Widget button = ToggleButtons(
      // renderB
      color: Colors.black87,

      /// 选中文字颜色
      selectedColor: Color(GlobalColor.APP_THEME_COLOR),

      /// 选中按钮的背景颜色
      fillColor: Colors.white,
      isSelected: widget.clickList,
      borderRadius: BorderRadius.circular(30),

      /// 边框的圆角半径
      borderColor: Color(GlobalColor.MAX_SHALLOW_GRAY),

      /// 边框的圆角颜色
      borderWidth: 1,

      /// 边框的圆角宽度
      splashColor: Color(GlobalColor.MAX_SHALLOW_GRAY),

      /// 水波纹颜色
      highlightColor: Color(GlobalColor.MAX_SHALLOW_GRAY),

      /// 按下时的高亮颜色// disabledColor: Colors.grey[300],禁用状态下按钮颜色// disabledBorderColor: Colors.blueGrey,禁用状态下边框的颜色
      selectedBorderColor: Color(GlobalColor.MAX_SHALLOW_GRAY),

      /// 选中边框的颜色
      children: widget.buttonList,
      onPressed: (index) {
        for (int i = 0; i < widget.clickList.length; i++) {
          if (i == index) {
            widget.clickList[i] = true;
          } else {
            widget.clickList[i] = false;
          }
        }

        /// 调用回调
        widget.callBack(index);
      },
    );
    return button;
  }
}
