import 'package:flutter/material.dart';
import 'package:union_tabs/union_tabs.dart';
import 'package:flutter/src/material/tabs.dart';
import 'package:xhd_app/view/comm/route/GlobalRouteTable.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/page/home/hometabpage/find/FindPage.dart';
import 'package:xhd_app/view/page/home/hometabpage/index/IndexAttentionPage.dart';
import 'package:xhd_app/view/page/home/hometabpage/index/IndexLocalPage.dart';

import 'IndexRecommendPage.dart';

class IndexPage extends StatefulWidget {
  IndexPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> with TickerProviderStateMixin,AutomaticKeepAliveClientMixin{
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  void initState() {
    _tabController = TabController(initialIndex: 1,vsync: this, length: _pageTypeList.length)
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
    // 直接传this
    print("初始化");
    print(_tabController);
  }

  List imgList = [
    "http://yanxuan.nosdn.127.net/65091eebc48899298171c2eb6696fe27.jpg",
    "http://yanxuan.nosdn.127.net/8b30eeb17c831eba08b97bdcb4c46a8e.png",
    "http://yanxuan.nosdn.127.net/a196b367f23ccfd8205b6da647c62b84.png",
    "http://yanxuan.nosdn.127.net/149dfa87a7324e184c5526ead81de9ad.png",
    "http://yanxuan.nosdn.127.net/88dc5d80c6f84102f003ecd69c86e1cf.png",
    "http://yanxuan.nosdn.127.net/8b9328496990357033d4259fda250679.png",
    "http://yanxuan.nosdn.127.net/c39d54c06a71b4b61b6092a0d31f2335.png",
    "http://yanxuan.nosdn.127.net/ee92704f3b8323905b51fc647823e6e5.png",
    "http://yanxuan.nosdn.127.net/e564410546a11ddceb5a82bfce8da43d.png",
    "http://yanxuan.nosdn.127.net/56f4b4753392d27c0c2ccceeb579ed6f.png",
    "http://yanxuan.nosdn.127.net/6a54ccc389afb2459b163245bbb2c978.png",
    'https://picsum.photos/id/101/548/338',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1569842561051&di=45c181341a1420ca1a9543ca67b89086&imgtype=0&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201504%2F17%2F20150417212547_VMvrj.jpeg',
    'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1570437233&di=9239dbc3237f1d21955b50e34d76c9d5&imgtype=jpg&er=1&src=http%3A%2F%2Fb-ssl.duitang.com%2Fuploads%2Fblog%2F201508%2F30%2F20150830095308_UAQEi.thumb.700_0.jpeg'
  ];

  //页面类型数组
  List<Widget> _pageTypeList = [
    Text('关注'),
    Text('推荐'),
    Text('本地'),
    Text('发现'),
  ];

  //页面列表
  List<Widget> _pageList = [
    IndexAttentionPage(),
    IndexRecommendPage(),
    IndexLocalPage(),
    FindPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        child: AppBar(
          leading: IconButton(
              color: Colors.black,
              iconSize: 26,
              icon: Icon(Icons.add_a_photo_outlined),
              onPressed: () {
                print('add click....');
              }),
          actions: <Widget>[
            IconButton(
                color: Colors.black,
                icon: Icon(Icons.search),
                iconSize: 26,
                onPressed: () {
                  GlobalRouteTable.goSearchHomePage(context);
                }),
          ],
          title: _getTab(),
          elevation: 0,
          backgroundColor: Colors.white,
        ),
        preferredSize: Size.fromHeight(50),
      ),
      body: UnionOuterTabBarView(
        controller: _tabController,
        children: _pageList,
      ),
    );
  }

  Widget _getTab() {
    return SizedBox(
      height: 35,
      child: TabBar(
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
          indicatorWeight: 2.0,
          //选中下划线的高度，值越大高度越高，默认为2。0
          //用于设定选中状态下的展示样式
          tabs: _pageTypeList),
    );
  }
}

//选项卡
class AppBarTabsItem extends StatelessWidget {
  const AppBarTabsItem({Key key, this.text, this.onTap, this.active})
      : super(key: key);

  final String text;
  final GestureTapCallback onTap;
  final bool active;

  @override
  Widget build(BuildContext context) {
    ThemeData _theme = Theme.of(context);
    return GestureDetector(
      onTap: this.onTap,
      child: Column(
        children: [
          Container(
            // color: Colors.pink,
            padding: EdgeInsets.only(top: 5, bottom: 5),
            margin: EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 2.0,
                  // 如果不用透明色，就会出现文字偏移现象
                  // 因为border没有的情况下容器里只有文字的元素，所以高度会比有border的元素少一点
                  color: this.active ? _theme.primaryColor : Colors.transparent,
                ),
              ),
            ),
            child: Text(
              this.text,
              style: TextStyle(
                color: this.active ? Colors.black : _theme.disabledColor,
                fontSize: _theme.textTheme.bodyText1.fontSize + 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
