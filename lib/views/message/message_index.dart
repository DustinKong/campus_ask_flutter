import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/api.dart';
import '../api/ColorUtil.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
import '../api/LogUtil.dart';

class MessageIndexPage extends StatefulWidget {
  @override
  _MessageIndexPageState createState() => _MessageIndexPageState();
}

class _MessageIndexPageState extends State<MessageIndexPage> {
  var _futureBuilderFuture;
  // Future _gerData() async {
  //   var response = HttpUtil()
  //       .get('http://api.douban.com/v2/movie/top250', data: {'count': 15});
  //   return response;
  // }
  int chooseId = 0;
  List actNum = [0, 0, 0];
  int type = 20;
  List showList = [];
  Future _loadData = FutureDio('post', Api.taskStandard, {});
  Future _getData;
  @override
  void initState() {
    super.initState();
    _getData = FutureDio('post', Api.login, {}).then((res) {
      print(res);
    });
    _futureBuilderFuture = _getData;
    // LogUtil.init(title: "来自LogUtil",limitLength:800);

    var log = "我是日志";
    //仅在Debug时打印
    LogUtil.d(log);
    LogUtil.d("我是日志");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0, //隐藏底部阴影分割线
          title: new Text(
            "消息",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  //参加20
                  Expanded(
                      child: InkResponse(
                    highlightColor: Colors.transparent,
                    radius: 0.0,
                    child: Column(
                      children: <Widget>[
                        Text(actNum[0].toString(),
                            style: TextStyle(
                                color: chooseId == 0 ? ColorsUtil.orange() : ColorsUtil.blue(),
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 6,
                        ),
                        Text('点赞', style: TextStyle(color: chooseId == 0 ? ColorsUtil.orange() : ColorsUtil.blue())),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 5,
                          width: 90,
                          decoration: new BoxDecoration(
                            color: chooseId == 0 ? ColorsUtil.orange() : ColorsUtil.blue(),
                            //设置四周圆角 角度
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          ),
                        ),
                      ],
                    ),
                    onTap: () {
                      if (chooseId != 0) {
                        print('change');
                        setState(() {
                          type = 20;
                          _loadData = FutureDio('post', Api.taskStandard, {});
                        });
                      }
                      if (mounted)
                        setState(() {
                          chooseId = 0;
                        });
                    },
                  )),
                  //发起10
                  Expanded(
                      child: InkResponse(
                    highlightColor: Colors.transparent,
                    radius: 0.0,
                    child: Column(
                      children: <Widget>[
                        Text(actNum[1].toString(),
                            style: TextStyle(
                                color: chooseId == 1 ? ColorsUtil.orange() : ColorsUtil.blue(),
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 6,
                        ),
                        Text('评论', style: TextStyle(color: chooseId == 1 ? ColorsUtil.orange() : ColorsUtil.blue())),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 5,
                          width: 90,
                          decoration: new BoxDecoration(
                            color: chooseId == 1 ? ColorsUtil.orange() : ColorsUtil.blue(),
                            //设置四周圆角 角度
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      if (chooseId != 1) {
                        setState(() {
                          type = 10;
                          _loadData = FutureDio('post', Api.taskStandard, {});
                        });
                      }
                      if (mounted)
                        setState(() {
                          chooseId = 1;
                        });
                    },
                  )),
                  //关注30
                  Expanded(
                      child: InkResponse(
                    highlightColor: Colors.transparent,
                    radius: 0.0,
                    child: Column(
                      children: <Widget>[
                        Text(actNum[2].toString(),
                            style: TextStyle(
                                color: chooseId == 2 ? ColorsUtil.orange() : ColorsUtil.blue(),
                                fontSize: 20,
                                fontWeight: FontWeight.w600)),
                        SizedBox(
                          height: 6,
                        ),
                        Text('通知', style: TextStyle(color: chooseId == 2 ? ColorsUtil.orange() : ColorsUtil.blue())),
                        SizedBox(
                          height: 3,
                        ),
                        Container(
                          height: 5,
                          width: 90,
                          decoration: new BoxDecoration(
                            color: chooseId == 2 ? ColorsUtil.orange() : ColorsUtil.blue(),
                            //设置四周圆角 角度
                            borderRadius: BorderRadius.all(Radius.circular(2.0)),
                          ),
                        )
                      ],
                    ),
                    onTap: () {
                      if (chooseId != 2) {
                        setState(() {
                          type = 30;
                          _loadData = FutureDio('post', Api.taskStandard, {});
                        });
                      }
                      if (mounted)
                        setState(() {
                          chooseId = 2;
                        });
                    },
                  )),
                ],
              ),
            ),
            FutureBuilder(
              builder: _buildFuture,
              future: _futureBuilderFuture,
            ),
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
        if(!snapshot.hasData) return Center(child: Text("暂无数据"),);
        return ListView.builder(itemBuilder: (context, index) {
          return ListTile(
            title: Text(showList[index]['title']),
            subtitle: showList[index]['subtitle'],
            trailing: Column(
              children: <Widget>[
                Text(showList[index]['time']),
                Container(
                  height: 10,
                  width: 10,
                  child: Text(showList[index]['num']),
                  decoration: BoxDecoration(
                      color: ColorsUtil.hexColor(0xff0000, alpha: 1),
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                )
              ],
            ),
          );
        });
      default:
        return null;
    }
  }
}
