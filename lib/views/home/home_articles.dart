import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/ColorUtil.dart';
import '../api/LogUtil.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
import '../api/LogUtil.dart';

class HomeArticlesPage extends StatefulWidget {
  final arguments;
  HomeArticlesPage({this.arguments});
  @override
  _HomeArticlesPageState createState() => _HomeArticlesPageState();
}

class _HomeArticlesPageState extends State<HomeArticlesPage> {
  var _futureBuilderFuture;
  // Future _gerData() async {
  //   var response = HttpUtil()
  //       .get('http://api.douban.com/v2/movie/top250', data: {'count': 15});
  //   return response;
  // }
  var show = null;
  Future _getData;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // LogUtil.init(title: "来自LogUtil",limitLength:800);
    FutureDio('get', Api.GetDetailArticleController, {"articleId": widget.arguments['id']}).then((res) {
      LogUtil.d(res.data['data']);
      setState(() {
        show = res.data['data'];
      });
    });
    var log = "我是日志";
    //仅在Debug时打印
    LogUtil.d(log);
    LogUtil.d("我是日志");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          elevation: 0, //隐藏底部阴影分割线
          title: new Text(
            "详细内容",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
        ),
        body: show == null
            ? Center(child: CircularProgressIndicator(),)
            : ListView(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(
                      show['articleTitle'],
                      style: TextStyle(fontWeight: FontWeight.w600, fontSize: 24),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Icon(Icons.account_box),
                        Text(
                          show['articleAuthorName'],
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.article),
                        Text(
                          show['createTime'],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Html(data: show['articleContent']??""),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(widget.arguments['content']??""),
                  )
                ],
              ));
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        print('还没有开始网络请求');
        return Text('还没有开始网络请求');
      case ConnectionState.active:
        print('active');
        return Text('ConnectionState.active');
      case ConnectionState.waiting:
        print('waiting');
        return Center(
          child: CircularProgressIndicator(),
        );
      case ConnectionState.done:
        print('done');
        if (snapshot.hasError) return Text('Error: ${snapshot.error}');
        if (!snapshot.hasData)
          return Center(
            child: Text("暂无数据"),
          );
        return ListView.builder(itemBuilder: (context, index) {
          return Container();
        });
      default:
        return null;
    }
  }
}
