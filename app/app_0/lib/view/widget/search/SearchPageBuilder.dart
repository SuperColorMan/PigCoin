import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -----------------------
/// des: 搜索页相关结构构建
/// -----------------------
class SearchPageBuilder{
  /// 构建历史关键字条目结构
  static Widget buildHistorySearchKeyWordItem(String keyWord){
    return Container(child: Row(
      children: [
        Expanded(
            child: Container(
              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    width: 1,//宽度
                    color: Color(GlobalColor.MAX_SHALLOW_GRAY), //边框颜色
                  ),
                ),
              ),
              padding: EdgeInsets.only(top: 10, bottom: 10,left: 10, right: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 25,
                    color: Color(GlobalColor.SHALLOW_GRAY), //边框颜色
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        keyWord,
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    ),);
  }
  /// 构建热搜关键字条目结构
  static Widget buildHotSearchKeyWordItem(int index){
    return Row(
      children: [
        Expanded(
            child: Container(
              decoration: new BoxDecoration(
                color: Colors.white,
                //设置四周边框
                border: new Border(
                    bottom: BorderSide(
                      width: 1,//宽度
                      color: Color(GlobalColor.MAX_SHALLOW_GRAY), //边框颜色
                    ),
              )),
              padding: EdgeInsets.only(top: 10, bottom: 10,left: 10,right: 10),
              child: Row(
                children: [
                  Icon(
                    Icons.access_time,
                    size: 25,
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(left: 10),
                      child: Text(
                        "sadfisadfiajsidfsadfiajsidfsadfiajsidfsadfiajsidfsadfiajsidfsadfiajsidfsadfiajsidfajsidf",
                        textAlign: TextAlign.left,
                        softWrap: true,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        style: TextStyle(
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}