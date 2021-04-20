import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/// -------------------------------
/// Des: 用户性别标签
/// -------------------------------
class UserSexLabel extends StatefulWidget {
  UserSexLabel({Key key}) : super(key: key);

  @override
  _UserSexLabelState createState() {
    return _UserSexLabelState();
  }
}

class _UserSexLabelState extends State<UserSexLabel> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(100),
        topRight: Radius.circular(100),
        bottomLeft: Radius.circular(100),
        bottomRight: Radius.circular(100),
      ),
      child: Container(
        padding: EdgeInsets.only(left: 10, right: 10, top: 3, bottom: 3),
        //边框设置
        decoration: new BoxDecoration(
          color: Color(0x806F6F6F),
          //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
          //设置四周边框
//          border: new Border.all(width: 1, color: Colors.white),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.only(left: 5),
              constraints: BoxConstraints(
                maxWidth: 158,
              ),
              child: Text("123123213",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.left,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1),
            )
          ],
        ),
      ),
    );
  }
}
