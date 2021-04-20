import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

import 'FindPage_1.dart';
import 'FindPage_2.dart';

class FindPage extends StatefulWidget {
  FindPage({Key key}) : super(key: key);

  @override
  _FindPageState createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> with TickerProviderStateMixin {
  TabController _tabController;

  /// 页面类型数组
  List<Widget> _pageTypeList = [
    Text('关注'),
    Text('分类'),
  ];

  /// 页面列表
  List<Widget> _pageList = [
    FindPage_1(),
    FindPage_2(),
  ];

  /// 轮播图图片显示
  List carouselImageUrls = [
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
    "https://ss1.bdstatic.com/70cFvXSh_Q1YnxGkpoWK1HF6hhy/it/u=239561221,4188985846&fm=26&gp=0.jpg",
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(vsync: this, length: _pageTypeList.length)
      ..addListener(() {
        switch (_tabController.index) {
          case 0:
            print(1);
            break;
          case 1:
            print(2);
            break;
          case 2:
            print(3);
            break;
        }
      });
  }

  /// ---------------------------- 构建轮播图区域 start----------------------------
  Widget _buildSwiper() {
    return Expanded(
      flex: 3,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10), color: Colors.black),
        child: ClipRRect(
          child: Swiper(
            itemCount: carouselImageUrls.length,
            autoplay: true,
            itemBuilder: (BuildContext context, int index) {
              return CachedNetworkImage(
                imageUrl: carouselImageUrls[index],
                fit: BoxFit.cover,
              );
            },
            pagination: SwiperPagination(
                builder: DotSwiperPaginationBuilder(
              size: 8,
              color: Colors.black54,
              activeColor: Colors.white,
            )),
          ),
        ),
      ),
    );
  }

  /// ---------------------------- 构建轮播图区域 end----------------------------

  /// ---------------------------- 获取tabbar start----------------------------
  Widget _getTab() {
    return TabBar(
        onTap: (int index) {
          print('Selected......$index');
          return true;
        },
        controller: _tabController,
        unselectedLabelColor: Colors.grey,
        //设置未选中时的字体颜色，tabs里面的字体样式优先级最高
        unselectedLabelStyle: TextStyle(fontSize: 16),
        //设置未选中时的字体样式，tabs里面的字体样式优先级最高
        labelColor: Color(GlobalColor.APP_THEME_COLOR),
        //设置选中时的字体颜色，tabs里面的字体样式优先级最高
        labelStyle: TextStyle(fontSize: 16),
        //设置选中时的字体样式，tabs里面的字体样式优先级最高
        isScrollable: true,
        //允许左右滚动
        indicatorColor: Color(GlobalColor.APP_THEME_COLOR),
        //选中下划线的颜色
        indicatorSize: TabBarIndicatorSize.label,
        //选中下划线的长度，label时跟文字内容长度一样，tab时跟一个Tab的长度一样
        indicatorWeight: 3.0,
        //选中下划线的高度，值越大高度越高，默认为2。0
        indicator: BoxDecoration(),
        //用于设定选中状态下的展示样式
        tabs: _pageTypeList);
  }

  /// ---------------------------- 获取tabbar end----------------------------
  /// ---------------------------- 获取tabpage start----------------------------
  Widget _getTabView() {
    return TabBarView(controller: _tabController, children: _pageList);
  }

  /// ---------------------------- 获取tabpage end----------------------------

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          elevation: 0,
          leading: Container(
            width: 0,
            height: 0,
          ),
          backgroundColor: Colors.white,
          flexibleSpace: SafeArea(
            child: Column(
              children: <Widget>[
                _buildSwiper(),
                SizedBox(
                  height: 10,
                ),
                _getTab(),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(200),
      ),
      body: _getTabView(),
    );
  }
}
