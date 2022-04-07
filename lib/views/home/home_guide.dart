import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../api/ColorUtil.dart';
import '../api/LogUtil.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
import '../api/LogUtil.dart';

class HomeGuidePage extends StatefulWidget {
  @override
  _HomeGuidePageState createState() => _HomeGuidePageState();
}

class _HomeGuidePageState extends State<HomeGuidePage> {
  var _futureBuilderFuture;
  // Future _gerData() async {
  //   var response = HttpUtil()
  //       .get('http://api.douban.com/v2/movie/top250', data: {'count': 15});
  //   return response;
  // }
  Future _getData;
  int type=1;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getData = FutureDio('post', Api.login, {"sid": "076003"}).then((res) {
      print(res.data);
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
      appBar: AppBar(
        centerTitle: true,
        leading:  IconButton(
          icon:  Icon(Icons.arrow_back,color: Colors.black,),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        elevation: 0, //隐藏底部阴影分割线
        title: Text(
          "校园导览",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(children: <Widget>[
        Container(
            margin: EdgeInsets.all(5),
            padding: EdgeInsets.all(3),
            height: 40,
            decoration: BoxDecoration(
                color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                borderRadius: BorderRadius.all(Radius.circular(20))),
            child: Row(
              children: <Widget>[
                Container(
                  height: 20,
                  width: 30,
                  margin: EdgeInsets.only(left: 2.0, right: 2.0),
                  child: Icon(Icons.search),
                ),
                Expanded(
                  child: TextField(
                    focusNode: searchFocusNode,
                    textAlignVertical: TextAlignVertical.center,
                    controller: searchController,
                    cursorColor: Colors.black,
                    cursorWidth: 1.3,
                    decoration: InputDecoration(
                      hintStyle: new TextStyle(
                        fontSize: ScreenUtil().screenHeight * 0.019,
                      ),
                      hintText: '搜索感兴趣的内容',
                      border: InputBorder.none,
                    ),
                  ),
                )
              ],
            )),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            InkWell(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text("办事流程",
                        style: TextStyle(
                            fontSize: 26,
                            color: type == 1 ? Colors.black : Colors.grey,
                            fontWeight: FontWeight.w600)),
                    Container(
                      color: type == 1 ? ColorsUtil.blue() : Colors.white,
                      height: 5,
                      width: ScreenUtil().screenWidth*0.45,
                    )
                  ],
                ),
                padding: EdgeInsets.all(10),
              ),
              onTap: () {
                LogUtil.d("办事流程");
                if (type == 2)
                  setState(() {
                    type = 1;
                  });
              },
            ),
            InkWell(
              child: Container(
                child: Column(
                  children: <Widget>[
                    Text(
                      "电话信息",
                      style: TextStyle(
                          fontSize: 26, color: type == 2 ? Colors.black : Colors.grey, fontWeight: FontWeight.w600),
                    ),
                    Container(
                      color: type == 2 ? ColorsUtil.blue() : Colors.white,
                      height: 5,
                      width: ScreenUtil().screenWidth*0.45,
                    )
                  ],
                ),
                padding: EdgeInsets.all(10),
              ),
              onTap: () {
                LogUtil.d("电话信息");
                if (type == 1)
                  setState(() {
                    type = 2;
                  });
              },
            )
          ],
        ),
        FutureBuilder(
          builder: _buildFuture,
          future: _getData,
        ),
      ],)
    );
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
          return Container();
        });
      default:
        return null;
    }
  }
}
