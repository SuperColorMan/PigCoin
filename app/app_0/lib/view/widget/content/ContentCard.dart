import 'package:flutter/cupertino.dart';

/// -------------------------------
/// Des: 内容卡片组件
/// -------------------------------

class ContentCard extends StatefulWidget {

  final double height;

  ContentCard({Key key, this.height = 36.0,}) : super(key: key);

  @override
  _ContentCardState createState() {
    return _ContentCardState();
  }
}

class _ContentCardState extends State<ContentCard> {

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,   /// 访问组件参数
    );}
}