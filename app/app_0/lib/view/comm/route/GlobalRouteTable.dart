import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/anim/PageRouteAnimation.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/media/GlobalCropImage.dart';
import 'package:xhd_app/view/comm/page/GlobalBlackListPage.dart';
import 'package:xhd_app/view/comm/page/GlobalPhotoAlbumPage.dart';
import 'package:xhd_app/view/comm/page/GlobalSelectAtUserPage.dart';
import 'package:xhd_app/view/comm/page/GlobalSelectGambitPage.dart';
import 'package:xhd_app/view/comm/page/GlobalShowImagePage.dart';
import 'package:xhd_app/view/comm/page/PrivacyPolicyPage.dart';
import 'package:xhd_app/view/comm/page/UserProtocolPage.dart';
import 'package:xhd_app/view/page/content/SendContentPage.dart';
import 'package:xhd_app/view/page/content/ShowContentPage.dart';
import 'package:xhd_app/view/page/gambit/GambitHomePage.dart';
import 'package:xhd_app/view/page/home/ReleaseSelectPage.dart';
import 'package:xhd_app/view/page/home/HomePage.dart';
import 'package:xhd_app/view/page/home/hometabpage/message/CommentAndAtMessagePage.dart';
import 'package:xhd_app/view/page/home/hometabpage/message/FansMessagePage.dart';
import 'package:xhd_app/view/page/home/hometabpage/message/GoodAndCollectMessagePage.dart';
import 'package:xhd_app/view/page/home/hometabpage/mypage/MyPage.dart';
import 'package:xhd_app/view/page/login/LoginPage.dart';
import 'package:xhd_app/view/page/login/RegisterPage.dart';
import 'package:xhd_app/view/page/search/HotSeachPage.dart';
import 'package:xhd_app/view/page/search/SearchHomePage.dart';
import 'package:xhd_app/view/page/search/SearchLevelListPage.dart';
import 'package:xhd_app/view/page/shop/commodity/CommodityAddPage.dart';
import 'package:xhd_app/view/page/shop/commodity/CommodityClassifyPage.dart';
import 'package:xhd_app/view/page/shop/commodity/CommoditySelectClassifyPage.dart';
import 'package:xhd_app/view/page/shop/commodity/CommoditySelectPage.dart';
import 'package:xhd_app/view/page/shop/index/navpage/BuyUserEveryDayPage.dart';
import 'package:xhd_app/view/page/shop/index/navpage/CommoditySharePage.dart';
import 'package:xhd_app/view/page/shop/index/navpage/ExcellentSellerPage.dart';
import 'package:xhd_app/view/page/shop/index/navpage/HotCommodityPage.dart';
import 'package:xhd_app/view/page/shop/index/navpage/NewCommodityPage.dart';
import 'package:xhd_app/view/page/shop/order/UserOrderFormPage.dart';
import 'package:xhd_app/view/page/shop/shopcart/ShoppingCartPage.dart';
import 'package:xhd_app/view/page/user/EditUserInfoPage.dart';
import 'package:xhd_app/view/page/user/MyHomePage_2.dart';
import 'package:xhd_app/view/page/user/UserHomePage_2.dart';
import 'package:xhd_app/view/page/user/UserLookContentHistoryPage.dart';
import 'package:xhd_app/view/page/user/setting/AccountSecurityPage.dart';
import 'package:xhd_app/view/page/user/setting/MessageSettingPage.dart';
import 'package:xhd_app/view/page/user/setting/UserSettingPage.dart';
import 'package:xhd_app/view/page/user/shop/UserBusinessAnalysePage.dart';
import 'package:xhd_app/view/page/user/shop/UserCommodityPage.dart';

/// -------------------------------
/// Des: 全局路由表
/// -------------------------------

class GlobalRouteTable {
  /// 前往内容发送页
  static void goSendContentPage(BuildContext context) {
    /// 登录判断
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        /// 已登录,允许发送
        Navigator.push(context, CustomRouteJianBian(SendContentPage()));
      } else {
        /// 未登录,前往登录或注册
        goLoginPage(context, () {});
      }
    });
  }

  /// 主页切换
  static void goHomePage(BuildContext context, int index, {Function callBack}) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return HomePage(index);
    })).then(callBack);
  }

  ///内容发送选择页
  static void goReleaseSelectPage(BuildContext context) {
    Navigator.push(context, CustomRouteJianBian(ReleaseSelectPage()));
//    Navigator.of(context)
//        .push(CupertinoPageRoute(builder: (BuildContext context) {
//      return ReleaseSelectPage(); //新打开的还是本控件,可无限重复打开
//    }));
  }

  ///用户个人资料编辑页
  static void goEditUserInfoPage(BuildContext context) {
    Navigator.push(context, CustomRouteJianBian(EditUserInfoPage()));
//    Navigator.of(context)
//        .push(CupertinoPageRoute(builder: (BuildContext context) {
//      return ReleaseSelectPage(); //新打开的还是本控件,可无限重复打开
//    }));
  }

  ///前往我的个人页
  static void goMyHomePage(BuildContext context, int index) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
//      return MyHomePage(index); //新打开的还是本控件,可无限重复打开
      return MyHomePage_2(defaultPageIndex: index); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(UserHomePage(index)));
  }

  ///前往用户页
  static void goUserPage(BuildContext context,
      {String userId, String userName}) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return UserHomePage_2(userId: userId, userName: userName);
    }));
  }

  /// 前往用户个人页面
  static void goMyPage(BuildContext context, {Function callBack}) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return MyPage();
    })).then(callBack);
  }

  /// 前往用户设置页面
  static void goUserSettingPage(BuildContext context, {Function callBack}) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return UserSettingPage();
    })).then(callBack);
  }

  /// 前往图片裁剪页面
  static void goImageCropPage(
      BuildContext context, File file, Function saveCallBack) {
//    Navigator.push<String>(context,
//        MaterialPageRoute(builder: (BuildContext context) {
//          return GlobalCropImage();
//        })).then(callBack);
    print("文件-----${file}");
    Navigator.push(
        context, CustomRouteJianBian(GlobalCropImage(file, saveCallBack)));
  }

  /// 前往话题主页
  static void goGambitHomePage(BuildContext context, Map gambitInfo) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return GambitHomePage(gambitInfo); //新打开的还是本控件,可无限重复打开
    }));
  }

  ///前往内容查看详情页
  static void goShowContentPage(BuildContext context, Map contentInfo) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return ShowContentPage(contentInfo); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(ShowContentPage()));
  }

  ///前往用户查看内容历史页
  static void goUserLookContentHistoryPage(
      BuildContext context, String userId) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return UserLookContentHistoryPage(userId); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(ShowContentPage()));
  }

  ///------------ 前往搜索页 ------------
  static void goSearchHomePage(BuildContext context) {
//    Navigator.push(context, CustomRouteJianBian(SearchHomePage()));
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return SearchHomePage(); //新打开的还是本控件,可无限重复打开
    }));
  }

  ///------------ 前往热搜页 ------------
  static void goHotSearchHomePage(BuildContext context) {
//    Navigator.push(context, CustomRouteJianBian(SearchHomePage()));
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return HotSeachPage(defaultPageIndex: 0); //新打开的还是本控件,可无限重复打开
    }));
  }

  ///------------ 前往搜索榜单页 ------------
  static void goSearchLevelListPage(BuildContext context) {
//    Navigator.push(context, CustomRouteJianBian(SearchHomePage()));
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return SearchLevelListPage(); //新打开的还是本控件,可无限重复打开
    }));
  }

  ///------------ 前往图片查看页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goShowImagePage(BuildContext context, List<String> urlList) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return GlobalShowImagePage(urlList); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(GlobalShowImagePage(urlList)));
  }

  ///------------ 前往用户通知设置页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goUserMessageSettingPage(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return MessageSettingPage(); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(MessageSettingPage()));
  }

  ///------------ 前往用户赞和收藏消息页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goGoodAndCollectMessagePage(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return GoodAndCollectMessagePage(); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(MessageSettingPage()));
  }

  ///------------ 前往用户新增粉丝消息页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goFansMessagePage(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return FansMessagePage(); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(MessageSettingPage()));
  }

  ///------------ 前往用户评论和@消息页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goCommentAndAtMessagePage(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return CommentAndAtMessagePage(); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(MessageSettingPage()));
  }

  ///------------ 前往小黑屋页面页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goUserBlackListPage(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return GlobalBlackListPage(); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(GlobalBlackListPage()));
  }

  ///------------ 前往用户协议页面页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goUserProtocolPage(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return UserProtocolPage(); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(UserProtocolPage()));
  }

  ///------------ 前往隐私协议页面页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goPrivacyPolicyPage(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return PrivacyPolicyPage(); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(PrivacyPolicyPage()));
  }

  ///------------ 前往用户账号与安全页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goUserAccountSecurityPage(BuildContext context) {
    Navigator.of(context)
        .push(CupertinoPageRoute(builder: (BuildContext context) {
      return AccountSecurityPage(); //新打开的还是本控件,可无限重复打开
    }));
//    Navigator.push(context, CustomRouteJianBian(AccountSecurityPage()));
  }

  ///------------ 前往登录页 ------------
  /// urlList: 内容url列表
  /// -------------------------------------
  static void goLoginPage(BuildContext context, Function callBack) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return LoginPage();
    })).then(callBack);
//    Navigator.of(context).push(
//        CupertinoPageRoute(builder: (BuildContext context){
//          return LoginPage(); //新打开的还是本控件,可无限重复打开
//        })
//    );
//    Navigator.push(context, CustomRouteJianBian(LoginPage()));
  }

  ///------------ 前往注册页 ------------
  static void goRegisterPage(BuildContext context) {
    Navigator.push(context, CustomRouteJianBian(RegisterPage()));
  }

  ///------------ 前往@用户选择页 ------------
  /// callBack: 处理页面回传回调函数
  /// -------------------------------------
  static void goSelectAtUserPage(BuildContext context, Function callBack) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return GlobalSelectAtUserPage();
    })).then(callBack);
  }

  ///------------ 前往话题选择页 ------------
  /// callBack: 处理页面回传回调函数
  /// -------------------------------------
  static void goGlobalSelectGambitPage(
      BuildContext context, Function callBack) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return GlobalSelectGambitPage();
    })).then(callBack);
  }

  ///------------ 前往相册选择页 ------------
  /// callBack: 处理页面回传回调函数
  /// -------------------------------------
  static void goGlobalPhotoAlbumPage(BuildContext context, Function callBack) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return GlobalPhotoAlbumPage();
    })).then(callBack);
  }

  ///------------------------ 商城模块 start ------------------------
  /// 前往商品发布页
  static void goCommodityAddPage(BuildContext context) {
    /// 登录判断
    GlobalLocalCache.getLoginUserId().then((loginUserId) {
      if (loginUserId > 0) {
        /// 已登录,允许发送
        Navigator.push(context, CustomRouteJianBian(CommodityAddPage()));
      } else {
        /// 未登录,前往登录或注册
        goLoginPage(context, () {});
      }
    });
  }

  /// 前往订单页
  static void goUserOrderFormPage(BuildContext context, Function callBack) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return UserOrderFormPage();
    })).then(callBack);
  }

  /// 前往购物车页
  static void goShoppingCartPage(BuildContext context, Function callBack) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return ShoppingCartPage();
    })).then(callBack);
  }

  /// 前往分类页
  static void goCommodityClassifyPage(BuildContext context, Function callBack,
      {defaultIndex = 0}) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return CommodityClassifyPage(
        defaultIndex: defaultIndex,
      );
    })).then(callBack);
  }

  /// 前往分类选择页
  static void goCommoditySelectClassifyPage(
      BuildContext context, Function callBack,
      {defaultIndex = 0}) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return CommoditySelectClassifyPage(
        defaultIndex: defaultIndex,
      );
    })).then(callBack);
  }

  /// 前往商品选择页
  static void goCommoditySelectPage(BuildContext context, Function callBack) {
    Navigator.push<String>(context,
        MaterialPageRoute(builder: (BuildContext context) {
      return CommoditySelectPage();
    })).then(callBack);
  }

  ///用户商品页
  static void goUserCommodityPage(BuildContext context, {String pageTitle}) {
    Navigator.push(
        context, CustomRouteJianBian(UserCommodityPage(pageTitle: pageTitle)));
//    Navigator.of(context)
//        .push(CupertinoPageRoute(builder: (BuildContext context) {
//      return ReleaseSelectPage(); //新打开的还是本控件,可无限重复打开
//    }));
  }

  ///用户经营数据分析页
  static void goUserBusinessAnalysePage(BuildContext context,
      {String pageTitle}) {
    Navigator.push(context, CustomRouteJianBian(UserBusinessAnalysePage()));
//    Navigator.of(context)
//        .push(CupertinoPageRoute(builder: (BuildContext context) {
//      return ReleaseSelectPage(); //新打开的还是本控件,可无限重复打开
//    }));
  }

  ///前往买家日常页
  static void goBuyUserEveryDayPage(BuildContext context) {
    Navigator.push(context, CustomRouteJianBian(BuyUserEveryDayPage()));
  }

  ///前往商品分享页
  static void goCommoditySharePage(BuildContext context) {
    Navigator.push(context, CustomRouteJianBian(CommoditySharePage()));
  }

  ///前往优秀卖家页
  static void goExcellentSellerPage(BuildContext context) {
    Navigator.push(context, CustomRouteJianBian(ExcellentSellerPage()));
  }

  ///前往热门商品页
  static void goHotCommodityPage(BuildContext context) {
    Navigator.push(context, CustomRouteJianBian(HotCommodityPage()));
  }

  ///前往最新商品页
  static void goNewCommodityPage(BuildContext context) {
    Navigator.push(context, CustomRouteJianBian(NewCommodityPage()));
  }

  ///------------------------ 商城模块 end ------------------------

}
