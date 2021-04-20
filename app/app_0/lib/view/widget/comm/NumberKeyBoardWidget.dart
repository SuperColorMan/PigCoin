import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// -------------------------------
/// Des: 数字键盘组件
/// -------------------------------
class NumberKeyBoardWidget extends StatefulWidget {
  /// 数字字体大小
  double numberFontSize;

  /// 分割线颜色
  Color separateLineColor;

  /// 确定按钮颜色
  Color okBtnColor;

  /// 数字按钮点击时的颜色
  Color splashColor;

  /// 键盘关闭按钮显示组件
  Widget keyBoardCloseBtnShowWidget;

  /// 回推按钮显示组件
  Widget pushBackBtnShowWidget;

  /// 确定按钮显示组件
  Widget okBtnShowWidget;

  /// 数字按钮回调函数
  Function numberBtnCallBack = (String value) {};

  /// 回推按钮回调函数
  Function pushBackBtnBtnCallBack = () {};

  /// 关闭按钮回调函数
  Function closeBtnCallBack = () {};

  /// 确定按钮回调函数
  Function okBtnCallBack = () {};

  NumberKeyBoardWidget(
      {this.numberFontSize = 20,
      this.separateLineColor = Colors.grey,
      this.okBtnColor = Colors.redAccent,
      this.splashColor = Colors.grey,
      this.pushBackBtnShowWidget = const Icon(
        Icons.backspace_outlined,
      ),
      this.keyBoardCloseBtnShowWidget =
          const Icon(Icons.keyboard_hide_outlined),
      this.okBtnShowWidget = const Text(
        "确定",
        style: TextStyle(color: Colors.white, fontSize: 16),
      ),
      this.numberBtnCallBack,
      this.pushBackBtnBtnCallBack,
      this.closeBtnCallBack,
      this.okBtnCallBack});

  @override
  _NumberKeyBoardWidgetState createState() {
    return _NumberKeyBoardWidgetState();
  }
}

class _NumberKeyBoardWidgetState extends State<NumberKeyBoardWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          /// 数字区
          Expanded(
            flex: 7,
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// 分割线
                  Container(
                    height: 1,
                    color: widget.separateLineColor,
                  ),

                  /// 数字区
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("1");
                                },
                                child: Text(
                                  "1",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),

                        /// 分割线
                        Container(
                          width: 1,
                          color: widget.separateLineColor,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("2");
                                },
                                child: Text(
                                  "2",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),

                        /// 分割线
                        Container(
                          width: 1,
                          color: widget.separateLineColor,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("3");
                                },
                                child: Text(
                                  "3",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 分割线
                  Container(
                    height: 1,
                    color: widget.separateLineColor,
                  ),

                  /// 数字区
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("4");
                                },
                                child: Text(
                                  "4",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),

                        /// 分割线
                        Container(
                          width: 1,
                          color: widget.separateLineColor,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("5");
                                },
                                child: Text(
                                  "5",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),

                        /// 分割线
                        Container(
                          width: 1,
                          color: widget.separateLineColor,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("6");
                                },
                                child: Text(
                                  "6",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 分割线
                  Container(
                    height: 1,
                    color: widget.separateLineColor,
                  ),

                  /// 数字区
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("7");
                                },
                                child: Text(
                                  "7",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),

                        /// 分割线
                        Container(
                          width: 1,
                          color: widget.separateLineColor,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("8");
                                },
                                child: Text(
                                  "8",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),

                        /// 分割线
                        Container(
                          width: 1,
                          color: widget.separateLineColor,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("9");
                                },
                                child: Text(
                                  "9",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),

                  /// 分隔线
                  Container(
                    height: 1,
                    color: widget.separateLineColor,
                  ),

                  /// 数字区
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack(".");
                                },
                                child: Text(
                                  ".",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),

                        /// 分割线
                        Container(
                          width: 1,
                          color: widget.separateLineColor,
                        ),
                        Expanded(
                          child: SizedBox(
                            width: double.infinity,
                            height: double.infinity,
                            child: FlatButton(
                                splashColor: widget.splashColor,
                                onPressed: () {
                                  widget.numberBtnCallBack("0");
                                },
                                child: Text(
                                  "0",
                                  style: TextStyle(
                                      fontSize: widget.numberFontSize),
                                )),
                          ),
                        ),

                        /// 分割线
                        Container(
                          width: 1,
                          color: widget.separateLineColor,
                        ),
                        Expanded(
                            child: SizedBox(
                          width: double.infinity,
                          height: double.infinity,
                          child: FlatButton(
                            splashColor: widget.splashColor,
                            onPressed: () {
                              widget.closeBtnCallBack();
                            },
                            child: Center(
                                child: widget.keyBoardCloseBtnShowWidget),
                          ),
                        )),
                      ],
                    ),
                  ),
                  Container(
                    height: 1,
                    color: widget.separateLineColor,
                  ),
                ],
              ),
            ),
          ),

          /// 分割线
          Container(
            width: 1,
            color: widget.separateLineColor,
          ),

          /// 按钮区
          Expanded(
            flex: 2,
            child: Container(
              child: Column(
                children: [
                  /// 分割线
                  Container(
                    height: 1,
                    color: widget.separateLineColor,
                  ),

                  /// 回推键
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.white,
                      child: FlatButton(
                        splashColor: widget.splashColor,
                        onPressed: () {
                          widget.pushBackBtnBtnCallBack();
                        },
                        child: widget.pushBackBtnShowWidget,
                      ),
                    ),
                  ),

                  /// 分割线
                  Container(
                    height: 1,
                    color: widget.separateLineColor,
                  ),

                  /// 确定键
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      color: widget.okBtnColor,
                      child: SizedBox(
                        width: double.infinity,
                        height: double.infinity,
                        child: FlatButton(
                          splashColor: widget.splashColor,
                          onPressed: () {
                            widget.okBtnCallBack();
                          },
                          child: widget.okBtnShowWidget,
                        ),
                      ),
                    ),
                  ),

                  /// 分割线
                  Container(
                    height: 1,
                    color: widget.separateLineColor,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
