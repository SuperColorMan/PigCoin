import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_indicator_view/loading_indicator_view.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 全局图片构建器
/// -------------------------------
class GlobalImageBuilder{
  /// 构建内容项(包含评论项与回复项)中图片显示区域
  /// showCount 图片显示个数
  /// showImgList 图片显示列表
  static Widget buildContentItemImgShowArea(
      List<String> showImgList, int showCount,
      {Function callBack}) {
    if (showImgList.length > 0) {
      return GridView.count(
        crossAxisCount: showCount,
        shrinkWrap: true,
        //增加
        physics: new NeverScrollableScrollPhysics(),
        //次轴的宽度
        padding: EdgeInsets.all(4.0),
        //上下左右的内边距
        mainAxisSpacing: 4.0,
        //主轴元素间距
        crossAxisSpacing: 4.0,
        //次轴元素间距
        children: bulidImgItem(showImgList, callBack: callBack), //添加
      );
    } else {
      /// 不存在图片
      return Container();
    }
  }

  /// 构建内容项(包含评论项与回复项)中图片显示区域图片项
  static List<Container> bulidImgItem(List<String> showImgList,
      {Function callBack}) {
    return List<Container>.generate(
      showImgList.length,
          (int index) => Container(
        child: GestureDetector(
          onTap: () {
            /// 前往图片查看页面
            callBack();
//            GlobalRouteTable.goShowImagePage(context, imgUrlList);
          },
          child: CachedNetworkImage(
            imageUrl: '${showImgList[index]}',
            fit: BoxFit.fill,
            errorWidget: (context, url, error) {
              return Image.asset('images/wallfy.png');
            },
            placeholder: (context, url) => BallBeatIndicator(
                ballColor: Color(GlobalColor.APP_THEME_COLOR)),
          ),
        ),
      ),
    );
  }

}