import 'package:flutter/material.dart';
import 'package:flutter/src/material/tabs.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/comm/const/GlobalFilePath.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';
import 'package:xhd_app/view/widget/comm/GlobalContentList.dart';
import 'package:xhd_app/view/widget/comm/GlobalHotCommentContentList.dart';

class IndexRecommendPage extends StatefulWidget {
  IndexRecommendPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IndexRecommendPageState createState() => _IndexRecommendPageState();
}

class _IndexRecommendPageState extends State<IndexRecommendPage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController _tabController;

  @override
  bool get wantKeepAlive => true;

  /// 页面类型数组
  List<Widget> _pageTypeList = [
    Text('热门'),
    Text('最新'),
    Text('图文'),
    Text('段子'),
    Text('神评'),
  ];

  /// 页面列表
  List<Widget> _pageList = [
    GlobalContentList(
        GlobalConst.NET_API_CALL.getContentByType, {"contentClassify": "0"}),
    GlobalContentList(
        GlobalConst.NET_API_CALL.getContentByType, {"contentClassify": "1"}),
    GlobalContentList(
        GlobalConst.NET_API_CALL.getContentByType, {"contentClassify": "2"}),
    GlobalContentList(
        GlobalConst.NET_API_CALL.getContentByType, {"contentClassify": "3"}),
    GlobalHotCommentContentList(
        GlobalConst.NET_API_CALL.getContentByType, {"contentClassify": "4"}),
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
                Expanded(child: SizedBox()),
                _getTab(),
              ],
            ),
          ),
        ),
        preferredSize: Size.fromHeight(38),
      ),
      body: _getTabView(),
    );
  }

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
        labelStyle: TextStyle(fontSize: 22),
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

  Widget _getTabView() {
    return TabBarView(controller: _tabController, children: _pageList);
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
