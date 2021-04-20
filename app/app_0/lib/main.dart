import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/im/ImCommManager.dart';
import 'package:xhd_app/view/comm/utils/GlobalLocalUtil.dart';
import 'package:xhd_app/view/page/content/SendContentPage.dart';
import 'package:xhd_app/view/page/im/ChatDialogBoxPage.dart';
import 'package:xhd_app/view/page/search/HotSeachPage.dart';
import 'package:xhd_app/view/page/search/SearchHomePage.dart';
import 'package:xhd_app/view/page/shop/commodity/CommodityAddPage.dart';
import 'package:xhd_app/view/page/shop/commodity/CommodityClassifyPage.dart';
import 'package:xhd_app/view/page/shop/commodity/CommoditySelectClassifyPage.dart';
import 'package:xhd_app/view/page/shop/commodity/CommoditySelectPage.dart';
import 'package:xhd_app/view/page/shop/commodity/ShowCommodityPage.dart';
import 'package:xhd_app/view/page/shop/index/ShopIndexHomePage.dart';
import 'package:xhd_app/view/page/user/UserLookContentHistoryPage.dart';
import 'package:xhd_app/view/page/user/shop/UserBusinessAnalysePage.dart';
import 'package:xhd_app/view/page/welcome/WelComePage.dart';

void main() {
  /// 初始化设备地理信息
  GlobalLocalUtil.init();

  /// 初始化即时通讯连接
  ImCommManager.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GlobalLocalCache.cleanSearchKeyWordList();
    return MaterialApp(
      theme: ThemeData(
        platform: TargetPlatform.iOS,
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WelComePage(),
//      home: ShowCommodityPage(Map()),
//      home: ShopIndexHomePage(),
//      home: UserLookContentHistoryPage("1"),
//      home: SendContentPage(),
//      home: UserBusinessAnalysePage(),
//      home: CommodityClassifyPage(),
//      home: CommoditySelectClassifyPage(),
//      home: CommodityAddPage(),
//      home: ChatDialogBoxPage(Map()),
//      home: CommoditySelectPage(),
//      home: SearchHomePage(),
//      home: HotSeachPage(),
//      home: HotSeachPage(),
//      home: CommodityAddPage(),
//      home: UserOrderFormPage(),
//      home: ShoppingCartPage(),
//      home: CommodityInfoPage(Map()),
//      home: ShopIndexPage(),
//      home: GambitHomePage(Map()),
      builder: (BuildContext context, Widget child) {
        return Material(
          type: MaterialType.transparency,
          child: FlutterSmartDialog(child: child),
        );
      },
    );
  }
}
