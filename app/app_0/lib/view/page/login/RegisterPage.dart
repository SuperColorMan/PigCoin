///-------------------------
/// des : 注册页面
/// -------------------------
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/model/user/UserMessageSettingModel.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/net/GlobalNetApiCall.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';

class RegisterPage extends StatefulWidget {
  RegisterPage({Key key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
  /// 网络接口
  GlobalNetApiCall _globalNetApiCall = GlobalNetApiCall();

  /// 用户通知设置数据模型
  UserMessageSettingModel _userMessageSettingModel;

  /// 操作项上下边距
  double _itemTopAndBottomPadding = 10;

  /// 账号控制
  TextEditingController _accountController=TextEditingController();

  /// 账号控制
  TextEditingController _uidController=TextEditingController();

  /// 密码控制
  TextEditingController _passController=TextEditingController();

  //构建页
  Widget _buildPage() {
    return Container(
      padding: EdgeInsets.only(left: 0, top: 0, right: 0, bottom: 0),
      child: Column(
        children: [
          new Flexible(
            child: ListView.builder(
                itemCount: 1,
                itemBuilder: (context, i) {
                  return new Column(
                    children: [
                      /// 密码登录标题
                      Container(
                        child: Text(
                          "注册",
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.w500),
                        ),
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 15, bottom: 15),
                      ),

                      /// 手机号
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 15),
                        child: TextField(
                          controller: _accountController,

                          /// 设置字体
                          style: TextStyle(),

                          /// 设置输入框样式
                          decoration: InputDecoration(
                            hintText: '手机号',

                            /// 边框
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(width: 10, color: Colors.red),
                            //   borderRadius: BorderRadius.all(
                            //     /// 里面的数值尽可能大才是左右半圆形，否则就是普通的圆角形
                            //     Radius.circular(50),
                            //   ),
                            // ),
                            // border: InputBorder.none, //去掉输入框的边框,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Color(GlobalColor.MAX_SHALLOW_GRAY))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Color(GlobalColor.MAX_SHALLOW_GRAY))),
                            // fillColor: Theme.of(context).disabledColor,
                            // fillColor: Colors.grey[200],
                            // 是否使用填充色
                            filled: false,

                            ///设置内容内边距
                            // contentPadding: EdgeInsets.only(
                            //   top: 0,
                            //   bottom: 0,
                            // ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                        ),
                      ),

                      /// 用户个性id
//                      Container(
//                        padding: EdgeInsets.only(
//                            left: 20, right: 20, top: 10, bottom: 15),
//                        child: TextField(
//                          controller: _uidController,
//
//                          /// 设置字体
//                          style: TextStyle(),
//
//                          /// 设置输入框样式
//                          decoration: InputDecoration(
//                            hintText: '用户个性id',
//
//                            /// 边框
//                            // border: OutlineInputBorder(
//                            //   borderSide: BorderSide(width: 10, color: Colors.red),
//                            //   borderRadius: BorderRadius.all(
//                            //     /// 里面的数值尽可能大才是左右半圆形，否则就是普通的圆角形
//                            //     Radius.circular(50),
//                            //   ),
//                            // ),
//                            // border: InputBorder.none, //去掉输入框的边框,
//                            border: OutlineInputBorder(
//                              borderSide: BorderSide.none,
//                            ),
//                            focusedBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(
//                                    color:
//                                    Color(GlobalColor.MAX_SHALLOW_GRAY))),
//                            enabledBorder: UnderlineInputBorder(
//                                borderSide: BorderSide(
//                                    color:
//                                    Color(GlobalColor.MAX_SHALLOW_GRAY))),
//                            // fillColor: Theme.of(context).disabledColor,
//                            // fillColor: Colors.grey[200],
//                            // 是否使用填充色
//                            filled: false,
//
//                            ///设置内容内边距
//                            // contentPadding: EdgeInsets.only(
//                            //   top: 0,
//                            //   bottom: 0,
//                            // ),
//                            contentPadding: const EdgeInsets.symmetric(
//                                vertical: 10, horizontal: 10),
//                          ),
//                        ),
//                      ),

                      /// 密码
                      Container(
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 15),
                        child: TextField(
                          controller: _passController,

                          /// 设置字体
                          style: TextStyle(),

                          /// 设置输入框样式
                          decoration: InputDecoration(
                            hintText: '密码',

                            /// 边框
                            // border: OutlineInputBorder(
                            //   borderSide: BorderSide(width: 10, color: Colors.red),
                            //   borderRadius: BorderRadius.all(
                            //     /// 里面的数值尽可能大才是左右半圆形，否则就是普通的圆角形
                            //     Radius.circular(50),
                            //   ),
                            // ),
                            // border: InputBorder.none, //去掉输入框的边框,
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Color(GlobalColor.MAX_SHALLOW_GRAY))),
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color:
                                        Color(GlobalColor.MAX_SHALLOW_GRAY))),
                            // fillColor: Theme.of(context).disabledColor,
                            // fillColor: Colors.grey[200],
                            // 是否使用填充色
                            filled: false,

                            ///设置内容内边距
                            // contentPadding: EdgeInsets.only(
                            //   top: 0,
                            //   bottom: 0,
                            // ),
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 10),
                          ),
                        ),
                      ),

                      /// 协议
                      Container(
                        padding: EdgeInsets.only(bottom: 20),
                        child: RichText(
                          text: TextSpan(
                            style: TextStyle(color: Color(0xffff0000), fontSize: 14.0),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "注册则表示默认同意  ",
                                  style: TextStyle(color: Color(GlobalColor.SHALLOW_GRAY))),
                              TextSpan(
                                  text: "${GlobalConst.APP_NAME}用户协议",
                                  style:
                                  TextStyle(color: Color(GlobalColor.APP_THEME_COLOR)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      /// 前往用户协议页面
                                      GlobalRouteTable.goUserProtocolPage(context);
                                    }),
                              TextSpan(
                                text: "  和  ",
                                style: TextStyle(color: Color(GlobalColor.SHALLOW_GRAY)),
                              ),
                              TextSpan(
                                  text: "隐私协议",
                                  style:
                                  TextStyle(color: Color(GlobalColor.APP_THEME_COLOR)),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () async {
                                      /// 前往隐私协议页面
                                      GlobalRouteTable.goPrivacyPolicyPage(context);
                                    }),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
          ),

          /// 注册按钮
          GestureDetector(
            onTap: () {
              /// 执行注册。
              _globalNetApiCall
                  .register(_accountController.value.text,
                      _passController.value.text,
                  _uidController.value.text)
                  .then((value) {
                    print("注册标识符----${value}");
                if (value['code'] == 0) {
                  GlobalToast.showToast("注册成功");
                } else {
                  GlobalToast.showToast("注册失败");
                }
              });
            },
            child: Container(
              padding: EdgeInsets.only(
                top: 10,
                bottom: 20,
              ),
              width: double.infinity,
              alignment: Alignment.center,
              color: Color(GlobalColor.APP_THEME_COLOR),
              child: Text(
                "注册",
                style: TextStyle(color: Color(0xffffffff), fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    /// -------------------------- 用户通知设置数据模型初始化 --------------------------
    _userMessageSettingModel = new UserMessageSettingModel();

    /// -------------------------------------------------------------------------
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color(0xffffffff),
        appBar: PreferredSize(
            child: AppBar(
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
                  ),
                  margin: EdgeInsets.only(left: 15),
                ),
              ),
            ),
            preferredSize: Size.fromHeight(50)),
        body: _buildPage());
  }
}
