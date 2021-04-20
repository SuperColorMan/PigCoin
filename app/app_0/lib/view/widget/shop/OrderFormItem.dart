import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 订单项组件
/// -------------------------------
class OrderFormItem extends StatefulWidget {
  @override
  _OrderFormItemState createState() {
    return _OrderFormItemState();
  }
}

class _OrderFormItemState extends State<OrderFormItem> {
  /// 商品首张图片
  String imgUrl =
      'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=4077391885,613310756&fm=26&gp=0.jpg';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 10, right: 10),
      color: Colors.transparent,
      child: Slidable(
        key: Key("1"),
        dismissal: SlidableDismissal(
            child: SlidableDrawerDismissal(), onDismissed: (actionType) {}),
        actionPane: SlidableScrollActionPane(),
        //滑出选项的面板 动画
        actionExtentRatio: 0.25,
        child: Card(
          elevation: 4.0, //阴影
          color: Colors.white, //背景色
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Container(
            padding: EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 15),
            child: Column(
              children: [
                /// 商店卖家
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                          child: Row(
                        children: [
                          /// 用户头像
                          ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(258),
                              topRight: Radius.circular(258),
                              bottomLeft: Radius.circular(258),
                              bottomRight: Radius.circular(258),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: imgUrl,
                              fit: BoxFit.fill,
                              width: 30,
                              height: 30,
                              // color: Colors.black
                            ),
                          ),

                          /// 商品所属对象名称
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Text(
                                "去我家二教去我耳机哦人旗舰店",
                                textAlign: TextAlign.right,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ],
                      )),

                      /// 订单交易状态
                      Expanded(
                          child: Text(
                        "交易完成",
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )),
                    ],
                  ),
                ),

                /// 商品信息列表
                Container(
                  margin: EdgeInsets.only(bottom: 6),
                  child: Row(
                    children: [
                      /// 商品图片
                      Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(10),
                            topRight: Radius.circular(10),
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                          child: CachedNetworkImage(
                            imageUrl:
                                'https://gimg2.baidu.com/image_search/src=http%3A%2F%2Fi0.hdslb.com%2Fbfs%2Farchive%2F4ea7173bd3f2fc6a834ba8370edad43cdc32f7f3.jpg&refer=http%3A%2F%2Fi0.hdslb.com&app=2002&size=f9999,10000&q=a80&n=0&g=0n&fmt=jpeg?sec=1614863067&t=2e797f6d8f6f2ee5846eb83c4c592d24',
                            width: 100,
                            height: 100,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ),

                      /// 商品所属对象名称
                      Expanded(
                        child: Container(
                          padding: EdgeInsets.only(left: 15),
                          child: Column(
                            children: [
                              /// 商品描述
                              Container(
                                child: Text(
                                  "wqerioqwjeiorjowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijowqerioqwjeiorjoiqwjeorjiqwejorijqowiejrijoiqwjeorjiqwejorijqowiejrijo",
                                  textAlign: TextAlign.start,
                                  softWrap: true,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 3,
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.black,
                                  ),
                                ),
                              ),

                              /// 分割线
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                /// 价格区域
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// 价格
                      Container(
                        child: Row(
                          children: [
                            /// 单位icon
                            Icon(
                              FontAwesome.rmb,
                              color: Color(
                                GlobalColor.APP_THEME_COLOR,
                              ),
                              size: 15,
                            ),

                            /// 金额
                            Text(
                              "6666",
                              style: TextStyle(
                                  fontSize: 15,
                                  color: Color(GlobalColor.APP_THEME_COLOR)),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                /// 分隔线
                Container(
                  child: Container(
                    width: double.infinity,
                    height: 1,
                    color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                  ),
                ),

                /// 功能区域
                Container(
                  padding: EdgeInsets.only(top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      /// 删除订单
                      Container(
                        padding: EdgeInsets.only(
                            left: 10, right: 10, top: 3, bottom: 3),
                        //边框设置
                        decoration: new BoxDecoration(
                          color: Colors.white,
                          //设置四周圆角 角度 这里的角度应该为 父Container height 的一半
                          borderRadius: BorderRadius.all(Radius.circular(25.0)),
                          //设置四周边框
                          border: new Border.all(width: 1, color: Colors.red),
                        ),
                        child: Text("删除订单",
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.red,
                            ),
                            textAlign: TextAlign.left,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        secondaryActions: <Widget>[
          //右侧按钮列表
          IconSlideAction(
            caption: '删除',
            color: Colors.red,
            icon: Icons.delete,
            closeOnTap: false,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
