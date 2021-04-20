import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/CommWidgetBuilder.dart';


/// -------------------------------
/// Des: 创建话题行级项2
/// -------------------------------
class RowGambitItem_2 extends StatefulWidget {

  Map gambitStruct;
  RowGambitItem_2(this.gambitStruct,{Key key}) : super(key: key);

  @override
  _RowGambitItem_2State createState() {
    return _RowGambitItem_2State();
  }
}

class _RowGambitItem_2State extends State<RowGambitItem_2> {

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        GlobalRouteTable.goGambitHomePage(context, widget.gambitStruct);
      },
      child: Container(
        padding: EdgeInsets.only(left: 20, right: 10),
        margin: EdgeInsets.only(bottom: 15),
        child: Row(
          children: [
            Container(
              child: CachedNetworkImage(
                imageUrl:
                '${GlobalApiUrlTable.GET_GAMBIT_HEAD_PIC}?id=${widget.gambitStruct['id']}',
                width: 60,
                height: 60,
                fit: BoxFit.fill,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(left: 10),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.gambitStruct['name'],
                      textAlign: TextAlign.left,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: 10, top: 5),
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '内容数: ${widget.gambitStruct['contentCount']}',
                      style: TextStyle(color: Color(GlobalColor.SHALLOW_GRAY)),
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                width: 60,
                height: 30,
                child: CommWidgetBuilder.gradientButton("关注", fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }
}