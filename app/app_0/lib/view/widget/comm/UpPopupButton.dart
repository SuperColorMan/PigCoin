import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:xhd_app/view/comm/utils/GlobalColor.dart';

/// -------------------------------
/// Des: 自定义向上弹出菜单
/// -------------------------------
class UpPopupButton extends StatefulWidget {
  /// 子按钮项颜色,顺序与按钮项一致
  final List<Color> colorList;

  /// 菜单按钮选项
  final List<Icon> iconList;

  /// 按钮的点击事件
  final Function(int index) clickCallback;

  /// 按钮起始颜色
  final Color startColor;

  /// 按钮动画结束颜色
  final Color endColor;

  UpPopupButton(
      {this.iconList,
      this.clickCallback,
      this.colorList,
      this.startColor,
      this.endColor});

  @override
  _RoteButtonPageState createState() => _RoteButtonPageState();
}

////旋转变换按钮 向上弹出的效果 State实现
class _RoteButtonPageState extends State<UpPopupButton>
    with SingleTickerProviderStateMixin {
  //记录是否打开
  bool isOpened = false;

  //动画控制器
  AnimationController _animationController;

  //颜色变化取值
  Animation<Color> _animateColor;

  //图标变化取值
  Animation<double> _animateIcon;

  //按钮的位置动画
  Animation<double> _translateButton;

  //动画执行速率
  Curve _curve = Curves.easeOut;

  /// 主icon颜色
  Color _mainIconColor = Color(GlobalColor.APP_THEME_COLOR);

  /// 主icon
  Icon _mainIcon = Icon(
    Icons.add,
    color: Colors.white,
  );

  double _fabHeight = 56.0;

  @override
  initState() {
    super.initState();
    //初始化动画控制器
    _animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));

    /// 添加动画监听
    _animationController.addListener(() {
      setState(() {});
    });

    /// 添加动画状态监听
    _animationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        /// 动画已开始
        _mainIconColor = Colors.white;
        _mainIcon = Icon(
          Icons.close,
          color: Color(GlobalColor.APP_THEME_COLOR),
        );
      } else if (status == AnimationStatus.dismissed) {
        /// 动画已结束
        _mainIconColor = Color(GlobalColor.APP_THEME_COLOR);
        _mainIcon = Icon(
          Icons.add,
          color: Colors.white,
        );
      }
    });
    //Tween结合_animationController，使300毫秒内执行一个从0.0到0.1的变换过程
    _animateIcon =
        Tween<double>(begin: 0.0, end: 1.0).animate(_animationController);
    //结合_animationController 实现一个从Colors.blue到Colors.deepPurple的动画过渡
    _animateColor = ColorTween(
      begin: widget.startColor != null ? widget.startColor : Colors.blue,
      end: widget.endColor != null ? widget.endColor : Colors.deepPurple,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.00,
        1.00,
        curve: _curve,
      ),
    ));

    _translateButton = Tween<double>(
      begin: _fabHeight,
      end: -14.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(
        0.0,
        0.75,
        curve: _curve,
      ),
    ));
  }

  @override
  Widget build(BuildContext context) {
    //构建子菜单
    List<Widget> itemList = [];
    for (int i = 0; i < widget.iconList.length; i++) {
      //通过Transform来促成FloatingActionButton的平移
      itemList.add(
        Transform(
          transform: Matrix4.translationValues(
            0.0,
            _translateButton.value * (widget.iconList.length - i),
            0.0,
          ),
          child: FloatingActionButton(
            backgroundColor: widget.colorList[i],
            heroTag: "$i",
            onPressed: () {
              //点击菜单子选项要求菜单弹缩回去
              floatClick();
              if (widget.clickCallback != null) {
                widget.clickCallback(i);
              }
            },
            child: widget.iconList[i],
          ),
        ),
      );
    }
    //添加菜单按钮
    itemList.add(floatButton());

    return Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: itemList);
  }

  //构建固定旋转菜单按钮
  Widget floatButton() {
    return new Container(
      child: FloatingActionButton(
        backgroundColor: _mainIconColor,
        child: _mainIcon,
        onPressed: floatClick,
      ),
    );
  }

  //FloatingActionButton的点击事件，用来控制按钮的动画变换
  floatClick() {
    if (!isOpened) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
    isOpened = !isOpened;
  }

  //页面销毁时，销毁动画控制器
  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
