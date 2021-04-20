import 'package:flutter/cupertino.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';


/// -------------------------------
/// Des: 构建内容加入话题的标签
/// -------------------------------
class ContentJoinGambitTag extends StatefulWidget {

  Map gambitStruct;

  ContentJoinGambitTag(this.gambitStruct,{Key key}) : super(key: key);

  @override
  _ContentJoinGambitTagState createState() {
    return _ContentJoinGambitTagState();
  }
}

class _ContentJoinGambitTagState extends State<ContentJoinGambitTag> {

  @override
  Widget build(BuildContext context) {
    /// 话题id
    String _gambitId = widget.gambitStruct['id'].toString();

    ///话题名称
    String _gambitName = widget.gambitStruct['name'].toString();

    /// 参与内容数
    String _gambitJoinContentCount = ['contentCount'].toString();
    return GestureDetector(
      onTap: () {
        GlobalRouteTable.goGambitHomePage(context, widget.gambitStruct);
      },
      child: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(100),
          topRight: Radius.circular(100),
          bottomLeft: Radius.circular(100),
          bottomRight: Radius.circular(100),
        ),
        child: Container(
          padding: EdgeInsets.only(left: 10, right: 10, top: 1, bottom: 1),
          color: Color(GlobalColor.MAX_SHALLOW_GRAY),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "#",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 18,
                  color: Color(GlobalColor.APP_THEME_COLOR),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 5),
                constraints: BoxConstraints(
                  maxWidth: 158,
                ),
                child: Text("${_gambitName}",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(GlobalColor.APP_THEME_COLOR),
                    ),
                    textAlign: TextAlign.left,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1),
              )
            ],
          ),
        ),
      ),
    );
  }
}