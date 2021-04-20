import 'package:cached_network_image/cached_network_image.dart';

/// -------------------------------
/// Des: 商品卡片1
/// -------------------------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

class ActivityCard_1 extends StatefulWidget {
  ActivityCard_1({
    Key key,
  }) : super(key: key);

  @override
  _ActivityCard_1State createState() {
    return _ActivityCard_1State();
  }
}

class _ActivityCard_1State extends State<ActivityCard_1> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0, //阴影
      color: Colors.white, //背景色
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(5.0)),
      ),
      child: new Container(
        padding: EdgeInsets.only(top: 10, bottom: 10, left: 10, right: 10),
        child: Row(
          children: [
            /// 商品图片
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(5),
                topRight: Radius.circular(5),
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5),
              ),
              child: CachedNetworkImage(
                imageUrl:
                    'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fn.sinaimg.cn%2Fsinacn09%2F146%2Fw1083h663%2F20180329%2F2529-fyssmmc0726157.png&refer=http%3A%2F%2Fn.sinaimg.cn&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1615272989&t=403393e77413fb937620abb6b2a0619a',
                fit: BoxFit.fill,
                width: 68,
                height: 68,
                // color: Colors.black
              ),
            ),

            /// 商品基本信息
            Column(
              children: [
                /// 商品标题
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10),
                  width: 100,
                  child: Text(
                    "wqerioqwjeiorjowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijoiqwjeorjiqwejorijqowiejrijo",
                    textAlign: TextAlign.start,
                    softWrap: true,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black,
                    ),
                  ),
                ),

                /// 商品价格
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 5),
                  width: 100,
                  child: Row(
                    children: [
                      /// 金额
                      Text(
                        "前往",
                        style: TextStyle(
                            fontSize: 14,
                            color: Color(GlobalColor.SHALLOW_GRAY)),
                      ),
                      SizedBox(
                        width: 3,
                      ),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                        color: Color(GlobalColor.SHALLOW_GRAY),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
