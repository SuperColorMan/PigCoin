/// ---------------------------------
/// des : 全局图片查看页面
/// ---------------------------------
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class GlobalShowImagePage extends StatefulWidget {
  List<String> imgList;

  GlobalShowImagePage(List<String> imgList, {Key key}) {
    this.imgList = imgList;
  }

  @override
  _GlobalShowImagePageState createState() => _GlobalShowImagePageState(imgList);
}

class _GlobalShowImagePageState extends State<GlobalShowImagePage>
    with TickerProviderStateMixin {
  /// 已选择图片下标
  int _selectedIndex = 0;

  /// 显示的图片列表
  List<String> _imgList = [];

  _GlobalShowImagePageState(List<String> imgList) {
    this._imgList = imgList;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.white, body: _buildPage());
  }

  /// ----------- 页面构建 -----------
  Widget _buildPage() {
    return Container(
      child: Stack(
        children: [
          /// 图片查看区域
          Container(
            padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
            color: Color(0xfffffffff),
            child: PhotoViewGallery.builder(
              onPageChanged: (index) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              scrollPhysics: const BouncingScrollPhysics(),
              builder: (BuildContext context, int index) {
                return PhotoViewGalleryPageOptions.customChild(
                  child: Container(
                    alignment: Alignment.center,
                    child: Scrollbar(
                        child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          child: CachedNetworkImage(
                            imageUrl:_imgList[index],
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.center,
                          ),
                        ),
                      ),
                    )),
                  ),
                  minScale: PhotoViewComputedScale.contained * 1,
                  maxScale: PhotoViewComputedScale.covered * 2,
                );
              },
              itemCount: _imgList.length,
              loadingBuilder: (context, event) => Center(
                child: Container(
                  width: 20.0,
                  height: 20.0,
                  child: CircularProgressIndicator(
                    value: event == null
                        ? 0
                        : event.cumulativeBytesLoaded /
                            event.expectedTotalBytes,
                  ),
                ),
              ),
            ),
          ),

          /// 标题区域
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 100),
            child: Text(
              "${_selectedIndex + 1} / ${_imgList.length}",
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
    );
  }

  ///--------------------------------------
}
