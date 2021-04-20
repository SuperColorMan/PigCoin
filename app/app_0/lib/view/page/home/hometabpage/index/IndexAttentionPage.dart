import 'package:flutter/material.dart';
import 'package:xhd_app/view/comm/const/GlobalConst.dart';
import 'package:xhd_app/view/widget/comm/GlobalContentList.dart';

class IndexAttentionPage extends StatefulWidget {
  IndexAttentionPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _IndexAttentionPageState createState() => _IndexAttentionPageState();
}

class _IndexAttentionPageState extends State<IndexAttentionPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GlobalContentList(GlobalConst.NET_API_CALL.getContentByType,{"contentClassify":"1"}),
    );
  }
}
