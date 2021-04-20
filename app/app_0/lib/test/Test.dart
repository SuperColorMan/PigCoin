import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter之Hero动画',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TestPage(title: 'Flutter Demo Home Page'),
    );
  }
}

class TestPage extends StatefulWidget {
  TestPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TestPageState createState() => _TestPageState();
}

class _TestPageState extends State<TestPage> {
  //图片查看方法
  void showPhoto(BuildContext context, Widget image) {
    Navigator.push(context,
        MaterialPageRoute<void>(builder: (BuildContext context) {
          return GestureDetector(
            child: SizedBox.expand(
              child: Hero(
                tag: image,
                child: image,
              ),
            ),
            onTap: () {
              Navigator.maybePop(context);
            },
          );
        }));
  }

  List<Widget> _list = <Widget>[
    ClipRRect(
      child: CachedNetworkImage(
        imageUrl:'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2867449984,3525681023&fm=26&gp=0.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
    ClipRRect(
      child: CachedNetworkImage(
        imageUrl:'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2867449984,3525681023&fm=26&gp=0.jpg',
        fit: BoxFit.cover,
      ),
      borderRadius: BorderRadius.circular(8),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // Here we take the value from the TestPage object that was created by
          // the App.build method, and use it to set our appbar title.
          title: Text('底部弹窗'),
          centerTitle: true,
        ),
        body: Center(
          child: RaisedButton(
            child: const Text('展示底部弹窗'),
            onPressed: () {
              showModalBottomSheet<void>(
                  isScrollControlled: true, //一：设为true，此时为全屏展示
                  context: context,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20),
                    ),
                  ),
                  builder: (BuildContext context) {
                    return SizedBox(
                        height: GlobalConst.REPLY_AREA_HEIGHT,
                        child: StatefulBuilder(builder: (context, setState1)
                    {
                      return Container(
                        padding: EdgeInsets.only(
                            bottom: 50, top: 10, left: 10, right: 10),
                        child: GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 4.0,
                          crossAxisSpacing: 4.0,
                          padding: const EdgeInsets.all(4.0),
                          children: _list.map(
                                (Widget img) {
                              return GestureDetector(
                                onTap: () {
                                  setState1(() {
                                    _list.add(
                                      ClipRRect(
                                        child: CachedNetworkImage(
                                          imageUrl:'https://ss1.bdstatic.com/70cFuXSh_Q1YnxGkpoWK1HF6hhy/it/u=2867449984,3525681023&fm=26&gp=0.jpg',
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius:
                                        BorderRadius.circular(8),
                                      ),
                                    );
                                  });
                                },
                                child: Hero(
                                  tag: img,
                                  child: img,
                                ),
                              );
                            },
                          ).toList(),
                        ),
                      );
                    }),
                    );
                  });
            },
          ),
        ));
  }
}
