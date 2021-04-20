import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flustars/flustars.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';
import 'package:xhd_app/model/user/UserInfoModel.dart';
import 'package:city_pickers/city_pickers.dart';
import 'package:xhd_app/view/comm/cache/GlobalLocalCache.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/media/GlobalCamera.dart';
import 'package:xhd_app/view/comm/media/GlobalPhotoAlbum.dart';
import 'package:xhd_app/view/comm/net/GlobalApiUrlTable.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/comm/utils/GlobalDateUtil.dart';
import 'package:xhd_app/view/widget/comm/GlobalSelectBox.dart';
import 'package:xhd_app/view/widget/comm/GlobalToast.dart';

class EditUserInfoPage extends StatefulWidget {
  EditUserInfoPage({Key key}) : super(key: key);

  @override
  _EditUserInfoPageState createState() => _EditUserInfoPageState();
}

class _EditUserInfoPageState extends State<EditUserInfoPage>
    with TickerProviderStateMixin {
  /// ----------- 用户数据模型 -----------
  UserInfoModel _userInfoModel;

  /// ---------------------------------
  /// 用户名编辑区控制器
  TextEditingController _userNameEditingController = TextEditingController();

  /// 用户简介编辑区控制器
  TextEditingController _userIntroEditingController = TextEditingController();

  /// -------------------- 发生编辑的用户信息 start --------------------
  /// 用户名
  String _editUserName = "";

  /// 用户性别
  String _editUserSex = "";

  /// 用户生日
  String _editUserBirthday = "";

  /// 所在地
  Map userLocalInfo = Map();

  /// 简介
  String _editUserIntro = "";

  /// 图片编辑标识符 0:编辑头像,1:编辑壁纸。
  int _imgEditFlag = 0;

  /// -------------------- 发生编辑的用户信息 end --------------------

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _userInfoModel = UserInfoModel(context);

    /// ------------- 用户数据初始化 start  -------------
    /// 初始化用户信息
    /// 用户登录信息
    GlobalLocalCache.getLoginUserInfo().then((loginUserInfo) {
      Map loginUserInfoMap = jsonDecode(loginUserInfo as String) as Map;

      /// 互动信息
      Map tuInteractionInfo = loginUserInfoMap['tuInteractionInfo'];

      setState(() {
        /// 用户性别
        String _sex = "外星人";
        if (loginUserInfoMap['sex'] == 0) {
          _sex = "女";
        } else if (loginUserInfoMap['sex'] == 1) {
          _sex = "男";
        } else if (loginUserInfoMap['sex'] == 2) {
          _sex = "外星人";
        }

        /// 用户id
        _userId = loginUserInfoMap['id'].toString();

        /// 用户个性id
        _userUId = loginUserInfoMap['uid'].toString();

        /// 用户名
        _userName = loginUserInfoMap['name'].toString();

        /// 性别
        _userSex = _sex;

        /// 简介
        _userIntro = loginUserInfoMap['intro'].toString();

        /// 生日
        _userBirthday = loginUserInfoMap['birthday'].toString();

        /// 用户地理信息
        Map tLocalInfo = loginUserInfoMap['tLocalInfo'];
        String local = ObjectUtil.isNotEmpty(tLocalInfo)
            ? '${tLocalInfo['country']} ${tLocalInfo['provincial']} ${tLocalInfo['city']} ${tLocalInfo['district']}'
            : '';

        _userInfoModel = UserInfoModel(
          context,
          id: _userId,
          uid: _userUId,
          userName: _userName,
          sex: _userSex,
          intro: _userIntro,
          birthday: _userBirthday,
          local: local,
          userHeadImg:
              '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${loginUserInfoMap['id'].toString()}&${GlobalDateUtil.getCurrentTimestamp()}',
          userBgImg: _userInfoModel.userBgImg =
              '${GlobalApiUrlTable.GET_USER_BG_PIC}?id=${loginUserInfoMap['id'].toString()}&${GlobalDateUtil.getCurrentTimestamp()}',
          attentionConut: tuInteractionInfo['attentionCount'].toString(),
          fansCount: tuInteractionInfo['fansCount'].toString(),
          goodCount: tuInteractionInfo['byGoodCount'].toString(),
        );
      });
    });

    /// ------------- 用户数据初始化 end  -------------
  }

  /// 构建媒体选择弹窗
  Widget _buildMedia() {
    return Container(
      color: Colors.white,
      width: double.infinity,
      height: ScreenUtil.getInstance().screenHeight * 0.3,
      padding: EdgeInsets.only(top: 10, bottom: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          /// 相机
          GestureDetector(
            onTap: () {
              /// 关闭弹窗
              SmartDialog.dismiss();

              /// 打开相机
              GlobalCamera.open(context, (assetEntity) async {
                /// 前往编辑
                File file = await assetEntity.file;
                GlobalRouteTable.goImageCropPage(context, file,
                    (Uint8List result, BuildContext c) {
                  GlobalLocalCache.getLoginUserId().then((loginUserId) {
                    print("编辑标识符---${_imgEditFlag}");
                    if (_imgEditFlag == 0) {
                      GlobalConst.NET_API_CALL
                          .upUserHeadPic(loginUserId.toString(), result)
                          .then((value) {
                        /// 裁剪头像并上传完成
                        /// 刷新编辑页
                        setState(() {
                          _userInfoModel.userHeadImg =
                              '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}';
                        });

                        /// 关闭页面
                        Navigator.pop(c);
                      });
                    } else if (_imgEditFlag == 1) {
                      GlobalConst.NET_API_CALL
                          .upUserBgPic(loginUserId.toString(), result)
                          .then((value) {
                        /// 裁剪壁纸并上传完成
                        /// 刷新编辑页
                        setState(() {
                          _userInfoModel.userBgImg =
                              '${GlobalApiUrlTable.GET_USER_BG_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}';
                        });

                        /// 关闭页面
                        Navigator.pop(c);
                      });
                    }
                  });
                });
                print("相机选择....${file}");
              });
            },
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.only(top: 15, bottom: 15),
              color: Colors.white,
              width: double.infinity,
              child: Text("相机", style: TextStyle(fontSize: 15)),
            ),
          ),

          /// 相册
          GestureDetector(
            onTap: () {
              /// 关闭弹窗
              SmartDialog.dismiss();
              GlobalPhotoAlbum.open(context, (assetEntityList) async {
                /// 前往编辑
                List list = assetEntityList as List;
                File file = await list.elementAt(0).file;
                GlobalRouteTable.goImageCropPage(context, file,
                    (Uint8List result, BuildContext c) {
                  GlobalLocalCache.getLoginUserId().then((loginUserId) {
                    print("编辑标识符---${_imgEditFlag}");
                    if (_imgEditFlag == 0) {
                      GlobalConst.NET_API_CALL
                          .upUserHeadPic(loginUserId.toString(), result)
                          .then((value) {
                        /// 裁剪头像并上传完成
                        /// 关闭页面
                        Navigator.pop(c);

                        /// 刷新编辑页
                        setState(() {});
                      });
                    } else if (_imgEditFlag == 1) {
                      GlobalConst.NET_API_CALL
                          .upUserBgPic(loginUserId.toString(), result)
                          .then((value) {
                        /// 裁剪壁纸并上传完成
                        /// 关闭页面
                        Navigator.pop(c);

                        /// 刷新编辑页
                        setState(() {});
                      });
                    }
                  });
                });
                print("相册回传---${assetEntityList}");
              }, maxAssets: 1);
            },
            child: Container(
              padding: EdgeInsets.only(top: 15, bottom: 15),
              alignment: Alignment.center,
              color: Colors.white,
              width: double.infinity,
              child: Text("相册", style: TextStyle(fontSize: 15)),
            ),
          ),

          /// 分割线
          Container(
            width: double.infinity,
            height: 5,
            color: Color(GlobalColor.MAX_SHALLOW_GRAY),
          ),

          /// 取消
          GestureDetector(
            onTap: () {
              SmartDialog.dismiss();
            },
            child: Container(
              padding: EdgeInsets.only(top: 10, bottom: 10),
              alignment: Alignment.center,
              color: Colors.white,
              width: double.infinity,
              child: Text(
                "取消",
                style: TextStyle(fontSize: 15),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// 获取内容List
  Widget _buildPage() {
    return Container(
      padding: EdgeInsets.only(left: 10, top: 0, right: 10, bottom: 0),
      color: Color(0xfffffffff),
      child: ListView.builder(
          itemCount: 1,
          itemBuilder: (context, i) {
            return new Column(
              children: [
                /// 头像编辑区域
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _imgEditFlag = 0;
                    });
                    SmartDialog.show(
                      alignmentTemp: Alignment.bottomCenter,
                      widget: _buildMedia(),
                    );
                  },
                  child: Container(
                    child: Column(
                      children: [
                        ///用户信息
                        Center(
                          child: Container(
                            margin: EdgeInsets.only(top: 60),
                            child: ClipOval(
                              child: CachedNetworkImage(
                                imageUrl: _userInfoModel.userHeadImg,
                                fit: BoxFit.cover,
                                width: 80,
                                height: 80,
                                // color: Colors.black
                              ),
                            ),
                          ),
                        ),

                        ///编辑文字
                        Center(
                          child: Container(
                            child: Text(
                              "点击更换头像",
                              style: TextStyle(fontSize: 15),
                            ),
                            margin: EdgeInsets.only(top: 10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                /// 昵称
                Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Text(
                          "昵称",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 15,
                        child: TextField(
                          controller: _userNameEditingController,
                          style: TextStyle(
                            fontSize: 18,
                          ),
                          maxLines: 1,
                          decoration: InputDecoration(
                            hintText: _userInfoModel.userName,
                            hintMaxLines: 20,
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                ///分割线
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Color(0xfff9fafb),
                  height: 2,
                ),

                ///性别
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    //打开性别选择框
                    var aa = ["女", "男", "外星人"];
                    GlobalSelectBox.showStringPicker(context, data: aa,
                        clickCallBack: (int index, var sexStr) {
                      /// index : 性别索引约束; sexStr : 性别名称;
                      setState(() {
                        _userInfoModel.sex = sexStr;
                        _editUserSex = index.toString();
                      });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "性别",
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                _userInfoModel.sex,
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 28,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                ///分割线
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Color(0xfff9fafb),
                  height: 2,
                ),

                ///生日
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    /// 打开日期选择框
                    GlobalSelectBox.showDatePicker(context,
//            dateType: DateType.YMD,
//            dateType: DateType.YM,
//            dateType: DateType.YMD_HM,
//            dateType: DateType.YMD_AP_HM,
//             title: "请选择2",
//            minValue: DateTime(2020,10,10),
//            maxValue: DateTime(2023,10,10),
//            value: DateTime(2020,10,10),
                        clickCallback: (var str, var time) {
                      /// str :  2021年6月23日
                      /// time : 2021-01-23 14:33:16.904740
                      time = time.toString().split(' ').elementAt(0);
                      setState(() {
                        _userInfoModel.birthday = time;
                        _editUserBirthday = time;
                      });
                    });
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "生日",
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                _userInfoModel.birthday,
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 28,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// 分割线
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Color(0xfff9fafb),
                  height: 2,
                ),

                /// 所在地
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    Result result = await CityPickers.showCityPicker(
                      height: 300,
                      context: context,
                      cancelWidget: Text(
                        '取消',
                        style:
                            TextStyle(fontSize: 17.0, color: Color(0xFF323232)),
                      ),
                      confirmWidget: Text(
                        '确定',
                        style: TextStyle(
                            fontSize: 17.0,
                            color: Color(GlobalColor.APP_THEME_COLOR)),
                      ),
                    );

                    /// result 回传格式:{"provinceName":"北京市","provinceId":"110000","cityName":"北京城区","cityId":"110100","areaName":"东城区","areaId":"110101"}
                    setState(() {
                      _userInfoModel.local =
                          '${result.provinceName}-${result.cityName}-${result.areaName}';
                      userLocalInfo['provinceName'] = "${result.provinceName}";
                      userLocalInfo['cityName'] = "${result.cityName}";
                      userLocalInfo['areaName'] = "${result.areaName}";
                    });
                    print("所在地:" + result.toString());
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "所在地",
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Text(
                                _userInfoModel.local,
                                style: TextStyle(fontSize: 16),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 28,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// 分割线
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Color(0xfff9fafb),
                  height: 2,
                ),

                /// 背景图片
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () async {
                    setState(() {
                      _imgEditFlag = 1;
                    });
                    SmartDialog.show(
                      alignmentTemp: Alignment.bottomCenter,
                      widget: _buildMedia(),
                    );
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 20),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "背景封面",
                          style: TextStyle(fontSize: 16),
                        ),
                        Container(
                          child: Row(
                            children: [
                              Container(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(4),
                                    topRight: Radius.circular(4),
                                    bottomLeft: Radius.circular(4),
                                    bottomRight: Radius.circular(4),
                                  ),
                                  child: CachedNetworkImage(
                                    width: 78,
                                    height: 68,
                                    fit: BoxFit.fill,
                                    imageUrl:
                                        '${GlobalApiUrlTable.GET_USER_BG_PIC}?id=${_userInfoModel.id}&${GlobalDateUtil.getCurrentTimestamp()}',
                                  ),
                                ),
                              ),
                              Icon(
                                Icons.chevron_right,
                                size: 28,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),

                /// 分割线
                Container(
                  margin: EdgeInsets.only(top: 20),
                  color: Color(0xfff9fafb),
                  height: 6,
                ),

                ///个人简介
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 15),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "个人简介",
                    style: TextStyle(fontSize: 16),
                  ),
                ),

                /// 个人简介编辑
                Container(
                  padding: EdgeInsets.only(left: 15, right: 15),
                  constraints: BoxConstraints(
                    minHeight: 150,
                  ),
                  color: Color(GlobalColor.MAX_SHALLOW_GRAY),
                  alignment: Alignment.topLeft,
                  child: TextField(
                    controller: _userIntroEditingController,
                    maxLines: null,
                    decoration: InputDecoration(
                      hintText: _userInfoModel.intro,
                      hintMaxLines: 20,
                      border: InputBorder.none,
                    ),
                  ),
                ),

                /// 底部空白
                SizedBox(
                  width: double.infinity,
                  height: 100,
                ),
              ],
            );
          }),
    );
  }

  /// 用户id
  String _userId;

  /// 用户个性id
  String _userUId;

  /// 用户名
  String _userName;

  /// 性别
  String _userSex;

  /// 简介
  String _userIntro;

  /// 生日
  String _userBirthday;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            child: AppBar(
              title: Text(
                '编辑资料',
                style: TextStyle(color: Colors.black87),
              ),
              centerTitle: true,
              elevation: 0,
              backgroundColor: Colors.white,
              brightness: Brightness.dark,
              actions: [
                Container(
                  padding: EdgeInsets.only(right: 15),
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      print("完成资料编辑");
                      setState(() {
                        /// 编辑的用户名
                        _editUserName = _userNameEditingController.value.text;

                        /// 编辑的用户简介
                        _editUserIntro = _userIntroEditingController.value.text;

                        /// 上传编辑信息
                        GlobalLocalCache.getLoginUserId().then((loginUserId) {
                          if (loginUserId != 0) {
                            Map editUserInfo = Map();

                            /// 用户id
                            editUserInfo['id'] = loginUserId.toString();

                            /// 用户名
                            if (!ObjectUtil.isEmptyString(_editUserName)) {
                              editUserInfo['name'] = _editUserName;
                            }

                            /// 用户简介
                            if (!ObjectUtil.isEmptyString(_editUserIntro)) {
                              editUserInfo['intro'] = _editUserIntro;
                            }

                            /// 用户性别
                            if (!ObjectUtil.isEmptyString(_editUserSex)) {
                              editUserInfo['sex'] = _editUserSex;
                            }

                            /// 生日
                            if (!ObjectUtil.isEmptyString(_editUserBirthday)) {
                              editUserInfo['birthday'] = _editUserBirthday;
                            }

                            /// 用户地理信息
                            editUserInfo['localInfo'] =
                                json.encode(userLocalInfo);
                            GlobalConst.NET_API_CALL
                                .editUserInfo(editUserInfo)
                                .then((value) {
                              if (value['code'] == 0) {
                                GlobalLocalCache.updateLoginUserInfo(
                                    editUserInfo);
                                GlobalLocalCache.getLoginUserInfo()
                                    .then((value) {
                                  print("登录用户信息---${value.toString()}");
                                });
                              }

                              /// 刷新头像与壁纸
                              _userInfoModel.userHeadImg =
                                  '${GlobalApiUrlTable.GET_USER_HEAD_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}';
                              _userInfoModel.userBgImg =
                                  '${GlobalApiUrlTable.GET_USER_BG_PIC}?id=${_userId}&${GlobalDateUtil.getCurrentTimestamp()}';
                              print("编辑用户信息回传");
                            });
                          } else {
                            GlobalToast.showToast("请先登录");
                          }
                        });
                      });
                    },
                    child: Center(
                      child: Text(
                        "完成",
                        style: TextStyle(
                            color: Color(GlobalColor.DEEP_GRAY), fontSize: 15),
                      ),
                    ),
                  ),
                )
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
