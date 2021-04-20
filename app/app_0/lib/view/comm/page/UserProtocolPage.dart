import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
/// ---------------------------------
/// 用户协议页面
/// ---------------------------------
class UserProtocolPage extends StatefulWidget {
  UserProtocolPage({Key key}) : super(key: key);

  @override
  _UserProtocolPageState createState() => _UserProtocolPageState();
}

class _UserProtocolPageState extends State<UserProtocolPage>
    with TickerProviderStateMixin {

  List<String> _picsList=[
    "images/comm/user_protocol.jpeg"
  ];

  //构建页
  Widget _buildPage() {
    return Container(
        color: Colors.white,
        child: PhotoViewGallery.builder(
          scrollPhysics: const BouncingScrollPhysics(),
          builder: (BuildContext context, int index) {
            return PhotoViewGalleryPageOptions.customChild(
              child: Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: Scrollbar(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Container(
                        color: Colors.white,
                        alignment: Alignment.center,
                        child: Image.asset(
                          _picsList[index],
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.center,
                        ),
                      ),
                    )),
              ),
              minScale: PhotoViewComputedScale.contained * 1,
              maxScale: PhotoViewComputedScale.covered * 2,
            );
          },
          itemCount: _picsList.length,
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
        )
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xfff9fafb),
        appBar: PreferredSize(
            child: AppBar(
              title: Text(
                '用户协议',
                style: TextStyle(color: Colors.black87),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              brightness: Brightness.dark,
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
                    onPressed: (){
                      Navigator.pop(context);
                    },
                  ),
                  margin: EdgeInsets.only(left: 15),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(50)),
        body: _buildPage());
  }
}
