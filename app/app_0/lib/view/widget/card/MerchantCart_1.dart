import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

/// -------------------------------
/// Des: 商家卡片
/// -------------------------------
class MerchantCart_1 extends StatefulWidget {
  /// 头像地址
  String headPicUrl;

  /// 封面地址
  String bgPicUrl;

  MerchantCart_1(this.headPicUrl, this.bgPicUrl, {Key key}) : super(key: key);

  @override
  _MerchantCart_1State createState() {
    return _MerchantCart_1State();
  }
}

class _MerchantCart_1State extends State<MerchantCart_1> {
  @override
  Widget build(BuildContext context) {
    Widget card = Container(
      child: Stack(
        fit: StackFit.expand,
        children: [
          /// 封面
          CachedNetworkImage(
            imageUrl: widget.bgPicUrl,
            fit: BoxFit.cover,
          ),

          /// 蒙层
          /// 毛玻璃蒙层
          ClipRect(
              child: Center(
            child: Opacity(
              //透明控件
              opacity: 0.2,
              child: Container(
                // 容器组件
                width: 500.0,
                height: 500.0,
                decoration:
                    BoxDecoration(color: Colors.black), //盒子装饰器，进行装饰，设置颜色为灰色
              ),
            ),
          )),

          /// 用户信息区域
          Positioned(
            left: 10,
            top: 8,
            child: Container(
              width: 28,
              height: 28,
              decoration: new BoxDecoration(
                //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                borderRadius: BorderRadius.all(Radius.circular(558.0)),
                //设置四周边框
                border: new Border.all(width: 2, color: Colors.white),
              ),
              child: ClipOval(
                child: Image.network(
                  "https://ss0.bdstatic.com/70cFuHSh_Q1YnxGkpoWK1HF6hhy/it/u=1448162552,4038553254&fm=26&gp=0.jpg",
                  fit: BoxFit.fill,
                  width: 30,
                  height: 30,
                  // color: Colors.black
                ),
              ),
            ),
            width: 28,
            height: 28,
          ),

          /// 商家名称
          Positioned(
            left: 50,
            top: 11,
            child: Text(
              "wqerioqwjeiorjowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijoiqwjeorjiqwejorijqowiejrijo",
              textAlign: TextAlign.start,
              softWrap: true,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                fontSize: 17,
                color: Colors.white,
              ),
            ),
            width: 100,
          ),
        ],
      ),
    );
    return card;
  }
}
