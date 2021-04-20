import 'dart:convert';
import 'dart:io';

/// -------------------------------
/// Des: 全局相册
/// -------------------------------

import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_manager/photo_manager.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalCheckBox.dart';


class GlobalPhotoAlbumPage extends StatefulWidget {
  GlobalPhotoAlbumPage({Key key}) : super(key: key);

  @override
  _GlobalPhotoAlbumPageState createState() => _GlobalPhotoAlbumPageState();
}

class _GlobalPhotoAlbumPageState extends State<GlobalPhotoAlbumPage>
    with TickerProviderStateMixin {
  /// 复选框
  GlobalCheckBox _globalCheckBox = GlobalCheckBox();

  /// 选择的图片列表
  List<String> _selectedImgList = [];

  /// 构建图片项根据网络url
  Widget _buildImgItenByUrl(String url) {
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: CachedNetworkImage(
              imageUrl:url,
              fit: BoxFit.fill,
            ),
          ),
          StatefulBuilder(builder: (context, setCheckStatus) {
            return Positioned(
              width: 24,
              height: 24,
              right: 5,
              top: 5,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setCheckStatus(() {
                    if (_globalCheckBox.statusRecord[url]) {
                      _globalCheckBox.statusRecord[url] = false;
                      _selectedImgList.remove(url);
                    } else {
                      _globalCheckBox.statusRecord[url] = true;
                      _selectedImgList.add(url);
                    }
                  });
                },
                child: _globalCheckBox.buildCheckBox(url),
              ),
            );
          }),
        ],
      ),
    );
  }
  /// 构建图片项根据本地图片路径
  Widget _buildImgItenByFile(String id, File file) {
    print("构建--"+file.toString());
    return Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            child: Image.file(
              file,
              fit: BoxFit.fill,
            ),
          ),
          StatefulBuilder(builder: (context, setCheckStatus) {
            return Positioned(
              width: 24,
              height: 24,
              right: 5,
              top: 5,
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  setCheckStatus(() {
                    if (_globalCheckBox.statusRecord[id]) {
                      _globalCheckBox.statusRecord[id] = false;
                      _selectedImgList.remove(file.path);
                    } else {
                      _globalCheckBox.statusRecord[id] = true;
                      _selectedImgList.add(file.path);
                    }
                  });
                },
                child: _globalCheckBox.buildCheckBox(id),
              ),
            );
          }),
        ],
      ),
    );
  }

  /// 构建拍摄按钮
  Widget _buildShoot() {
    return GestureDetector(
      child: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          children: [
            CachedNetworkImage(
              imageUrl:"https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.5mcc.com.cn%2F5mcc_com_cn%2Fallimg%2F190214%2F03145V3c-40.jpg&refer=http%3A%2F%2Fimg.5mcc.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1612415406&t=72cb2dc1656ef404bf8264d9950a2e7f",
              fit: BoxFit.fill,
            ),
            Center(
              child: BackdropFilter(
                //背景滤镜器
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                //图片模糊过滤，横向竖向都设置5.0
                child: Opacity(
                  //透明控件
                  opacity: 0.5,
                  child: Container(
                    // 容器组件
                    decoration: BoxDecoration(
                        color: Colors.grey.shade200), //盒子装饰器，进行装饰，设置颜色为灰色
                  ),
                ),
              ),
            ),
            Center(
              child: Icon(
                Icons.camera_alt_outlined,
                color: Colors.white,
                size: 45,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// 图片列表
  List<Widget> imgList = [];

  /// 构建图片选择预览区域
  Widget _buildImgPreView() {
    return GridView.builder(
        shrinkWrap: true,
        itemCount: imgList.length,
        //SliverGridDelegateWithFixedCrossAxisCount 构建一个横轴固定数量Widget
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            //横轴元素个数
            crossAxisCount: 4,
            //纵轴间距
            mainAxisSpacing: 5.0,
            //横轴间距
            crossAxisSpacing: 5.0,
            //子组件宽高长度比例
            childAspectRatio: 1.0),
        // ignore: missing_return
        itemBuilder: (BuildContext context, int index) {
          return imgList[index];
        });

//    Image.file(
//      new File(_selectedImgPathList[index]),
//      fit: BoxFit.fill,
//    ),
  }

  /// 构建页
  Widget _buildPage() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return new Column(
              children: [
                _buildImgPreView(),
              ],
            );
          }),
    );
  }

  /// 相册初始化
  Future<void> _initPhotoAlbum() async {
    try {
      List<AssetPathEntity> list = await PhotoManager.getAssetPathList(type:RequestType.image);
      for (AssetPathEntity assetPathEntity in list) {
        List<AssetEntity> assetEntityList = await assetPathEntity.getAssetListPaged(0, 10);
        for (AssetEntity assetEntity in assetEntityList) {
          File file = await assetEntity.file;
          String id = await assetEntity.id;
          setState(() {
            imgList.add(_buildImgItenByFile(id, file));
          });
        }
      }
    } on Exception {
      imgList.add(_buildImgItenByUrl(
          "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fimg.5mcc.com.cn%2F5mcc_com_cn%2Fallimg%2F190214%2F03145V3c-40.jpg&refer=http%3A%2F%2Fimg.5mcc.com.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1612415406&t=72cb2dc1656ef404bf8264d9950a2e7f"));
      imgList.add(_buildImgItenByUrl(
          "https://ss0.bdstatic.com/70cFvHSh_Q1YnxGkpoWK1HF6hhy/it/u=2406496040,187576390&fm=26&gp=0.jpg"));
      imgList.add(_buildImgItenByUrl(
          "https://gimg2.baidu.com/image_search/src=http%3A%2F%2Finews.gtimg.com%2Fnewsapp_match%2F0%2F10817659305%2F0.jpg&refer=http%3A%2F%2Finews.gtimg.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1612426028&t=697f2710b1bf06195ab44af57bff9ab4"));
      print("相册获取异常");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// 初始化拍摄按钮
    imgList.add(_buildShoot());

    /// 图片列表初始化
    _initPhotoAlbum();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff9fafb),
        appBar: PreferredSize(
            child: AppBar(
              title: Text(
                '图片选择',
                style: TextStyle(color: Colors.black87),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              brightness: Brightness.dark,
              actions: [
                Container(
                  padding: EdgeInsets.only(top: 8, bottom: 8, right: 10),
                  child: SizedBox(
                    width: 70,
                    child: RaisedButton(
                      color: Color(GlobalColor.APP_THEME_COLOR),
                      onPressed: () {
                        Navigator.pop(context, json.encode(_selectedImgList));
                      },
                      child: Text(
                        '确定',
                        style: TextStyle(fontSize: 16.0, color: Colors.white),
                      ),

                      ///圆角
                      shape: RoundedRectangleBorder(
                          side: BorderSide.none,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                    ),
                  ),
                ),
              ],
//        automaticallyImplyLeading: false,
              leading: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: Colors.black87,
                    ),
                    iconSize: 28,
                  ),
                  margin: EdgeInsets.only(left: 15),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(50)),
        body: _buildPage());
  }
}
