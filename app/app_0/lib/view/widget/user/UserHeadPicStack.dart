import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// -------------------------------
/// Des: 全局用户头像堆叠组件构建器
/// -------------------------------
class UserHeadPicStack extends StatefulWidget {
  /// 子组件宽度
  double sizeW = 50.0;
  double offsetW = 20.0;

  /// 堆叠头像方向标识符
  bool lOrR;

  /// 堆叠头像地址列表
  List<String> childImgList = List();

  UserHeadPicStack({
    Key key,
    this.lOrR = true,
    this.childImgList,
    this.sizeW = 35.0,
  }) : super(key: key);

  @override
  _UserHeadPicStackState createState() {
    return _UserHeadPicStackState();
  }
}

class _UserHeadPicStackState
    extends State<UserHeadPicStack> {
  @override
  Widget build(BuildContext context) {
    List<Widget> childImgList = List();
    for (int i = 0; i < widget.childImgList.length; i++) {
      double off = 20.0 * i;
      Widget child = Positioned(
        left: off,
        child: Container(
          width: widget.sizeW,
          height: widget.sizeW,
          decoration: new BoxDecoration(
            //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
            borderRadius: BorderRadius.all(Radius.circular(558.0)),
            //设置四周边框
            border: new Border.all(width: 2, color: Colors.white),
          ),
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: widget.childImgList[i],
              fit: BoxFit.cover,
              width: widget.sizeW + 2,
              height: widget.sizeW + 2,
              // color: Colors.black
            ),
          ),
        ),
      );
      childImgList.add(child);
    }
    return SizedBox(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: childImgList,
      ),
    );
  }
}
