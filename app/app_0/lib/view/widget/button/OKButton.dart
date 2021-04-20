import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 公共确定按钮
/// -------------------------------
class OKButton extends StatefulWidget {
  /// 按钮文本
  String text;

  /// 点击回调
  Function clickCallBack;

  /// 按钮宽度
  double btnWidth;

  OKButton({Key key, this.text = "确定", this.btnWidth = 70, this.clickCallBack})
      : super(key: key);

  @override
  _OKButtonState createState() {
    return _OKButtonState();
  }
}

class _OKButtonState extends State<OKButton> {
  @override
  Widget build(BuildContext context) {
    /// 按钮
    Widget btn = Container(
      padding: EdgeInsets.only(top: 8, bottom: 8, right: 10),
      child: SizedBox(
        width: widget.btnWidth,
        child: RaisedButton(
          color: Color(GlobalColor.APP_THEME_COLOR),
          onPressed: () {
            if (widget.clickCallBack != null) {
              widget.clickCallBack();
            }
          },
          child: Text(
            '${widget.text}',
            style: TextStyle(fontSize: 16.0, color: Colors.white),
          ),

          ///圆角
          shape: RoundedRectangleBorder(
              side: BorderSide.none,
              borderRadius: BorderRadius.all(Radius.circular(5))),
        ),
      ),
    );
    return btn;
  }
}
