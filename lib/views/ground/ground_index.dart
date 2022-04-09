import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
import '../api/ColorUtil.dart';
import '../api/LogUtil.dart';

class GroundIndexPage extends StatefulWidget {
  @override
  _GroundIndexPageState createState() => _GroundIndexPageState();
}

class _GroundIndexPageState extends State<GroundIndexPage> {
  var _futureBuilderFuture;
  // Future _gerData() async {
  //   var response = HttpUtil()
  //       .get('http://api.douban.com/v2/movie/top250', data: {'count': 15});
  //   return response;
  // }
  Future _getData;
  int type = 1;
  ScrollController _scrollController;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = new TextEditingController();
  @override
  void initState() {
    super.initState();
    _getData = FutureDio('get', Api.getArticleByThemeId + "/1/1", {});
    _futureBuilderFuture = _getData;
    // LogUtil.init(title: "来自LogUtil",limitLength:800);
    // FutureDio('get', Api.getArticleByThemeId+"/1/1",{} ).then((res){
    //   LogUtil.d(res.data);
    //   // print(res.data);
    // });
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
          "学校操场",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(
        children: <Widget>[
          Stack(
            alignment: Alignment.topCenter,
            children: <Widget>[
              Container(
                height: 230.h,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/images/ground/顶部背景 6@2x.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(left: 5),
                      child: Image.asset(
                        "assets/images/ground/顶部头像@2x.png",
                        height: 110.h,
                        width: 110.w,
                      ),
                    ),
                    Expanded(
                        child: Column(
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 30, 10, 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "浙江工商大学",
                                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.arrow_forward_ios,
                                  color: Colors.white,
                                ),
                                onPressed: () {},
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                "1234帖子 1234成员",
                                style: TextStyle(color: Colors.white, fontSize: 14),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                                ),
                                height: 35.h,
                                width: 75.w,
                                // color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                                child: InkWell(
                                  child: Row(
                                    children: <Widget>[
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Icon(
                                        Icons.add,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        "加入",
                                        style: TextStyle(color: Colors.white),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.fromLTRB(10, 0, 0, 5),
                          child: Text(
                            "置顶:欢迎来到浙江工商大学操场，这里是本校区所有活动的集结之地，在这里你可以发布任意动态，希望你玩得开心～",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ))
                  ],
                ),
              ),
              Positioned(
                bottom: -15.0,
                width: ScreenUtil().screenWidth,
                child: Container(
                  width: ScreenUtil().screenWidth,
                  height: 30,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(30))),
                ),
              ),
            ],
          ),
          Container(
            height: 80,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: <Widget>[
                InkWell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                      child: Image.asset(
                        "assets/images/ground/01失物招领@2x.png",
                        height: 70,
                        width: 140,
                      )),
                  onTap: () {},
                ),
                InkWell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 5, 5, 10),
                      child: Image.asset(
                        "assets/images/ground/02表白墙@2x.png",
                        height: 70,
                        width: 140,
                      )),
                  onTap: () {},
                ),
                InkWell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 5, 5, 10),
                      child: Image.asset(
                        "assets/images/ground/03代拿跑腿@2x.png",
                        height: 70,
                        width: 140,
                      )),
                  onTap: () {},
                ),
                InkWell(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                      child: Image.asset(
                        "assets/images/ground/04有偿问答@2x.png",
                        height: 70,
                        width: 140,
                      )),
                  onTap: () {},
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 5, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  width: 200,
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text("最新",
                                  style: TextStyle(
                                      fontSize: type == 1 ? 25 : 20,
                                      color: type == 1 ? Colors.black : Colors.grey,
                                      fontWeight: type == 1 ? FontWeight.w600 : FontWeight.w500)),
                              Container(
                                color: type == 1 ? ColorsUtil.orange() : Colors.white,
                                height: 5,
                                width: 40,
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        onTap: () {
                          LogUtil.d("最新");
                          if (type != 1)
                            setState(() {
                              type = 1;
                            });
                        },
                      ),
                      InkWell(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text("热门",
                                  style: TextStyle(
                                      fontSize: type == 2 ? 25 : 20,
                                      color: type == 2 ? Colors.black : Colors.grey,
                                      fontWeight: type == 2 ? FontWeight.w600 : FontWeight.w500)),
                              Container(
                                color: type == 2 ? ColorsUtil.orange() : Colors.white,
                                height: 5,
                                width: 40,
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        onTap: () {
                          LogUtil.d("热门");
                          if (type != 2)
                            setState(() {
                              type = 2;
                            });
                        },
                      ),
                      InkWell(
                        child: Container(
                          child: Column(
                            children: <Widget>[
                              Text("精华",
                                  style: TextStyle(
                                      fontSize: type == 3 ? 25 : 20,
                                      color: type == 3 ? Colors.black : Colors.grey,
                                      fontWeight: type == 3 ? FontWeight.w600 : FontWeight.w500)),
                              Container(
                                color: type == 3 ? ColorsUtil.orange() : Colors.white,
                                height: 5,
                                width: 40,
                              )
                            ],
                          ),
                          padding: EdgeInsets.all(10),
                        ),
                        onTap: () {
                          LogUtil.d("精华");
                          if (type != 3)
                            setState(() {
                              type = 3;
                            });
                        },
                      ),
                    ],
                  ),
                ),
                Container(
                    width: 150,
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
              ],
            ),
          ),
          Container(height: 5,color: ColorsUtil.hexColor(0xF0F0F0),),
          Container(
            height:480.h,
            color: ColorsUtil.hexColor(0xF0F0F0),
            child: FutureBuilder(
              builder: _buildFuture,
              future: _getData,
            ),
          ),
        ],
      ),

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
        LogUtil.d('finished');
        LogUtil.d(snapshot.data);
        List showList = snapshot.data.data['data']['records'];
        return ListView.builder(
            itemCount: showList.length,
            itemBuilder: (context, index) {
              return Container(
                margin: EdgeInsets.fromLTRB(10, 5, 5, 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                height: 110.h,
                child: Column(
                  children: <Widget>[
                    ListTile(
                        // isThreeLine:true,
                        onTap: (){
                          Navigator.pushNamed(context, '/GroundDetailPage', arguments: {'id': showList[index]['articleId'].toString()});
                        },
                        leading: ClipOval(
                          child: CachedNetworkImage(
                            fit: BoxFit.fill,
                            height: 35,
                            width: 35,
                            imageUrl: showList[index]['userEntity']['avatarUrl'],
                          ),
                        ),
                        title: Text(showList[index]['userEntity']['nickname'],style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(showList[index]['createTime']),
                            Text(showList[index]['articleText'],style: TextStyle(color: Colors.black),),
                          ],
                        ),
                        trailing: Container(
                          decoration:
                              BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorsUtil.deepPurple()),
                          height: 30.h,
                          width: 70.w,
                          // color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                          child: InkWell(
                            child: Row(
                              children: <Widget>[
                                SizedBox(
                                  width: 12,
                                ),
                                Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                                Text(
                                  "关注",
                                  style: TextStyle(color: Colors.white),
                                ),
                              ],
                            ),
                          ),
                        )),
                    Container(
                      margin: EdgeInsets.only(left: 65.w),
                      width: ScreenUtil().screenWidth-30.w,
                      child: Row(
                        children: <Widget>[
                          Expanded(
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/ground/点赞@2x.png',
                                    height: 18,
                                    width: 18,
                                  ),
                                  Text(
                                    showList[index]['articleLike'].toString(),
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              )),
                          Expanded(
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/ground/评论@2x.png',
                                    height: 18,
                                    width: 18,
                                  ),
                                  Text(
                                    "回复",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              )),
                          Expanded(
                              child: Row(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/ground/分享@2x.png',
                                    height: 18,
                                    width: 18,
                                  ),
                                  Text(
                                    "分享",
                                    style: TextStyle(color: Colors.grey),
                                  )
                                ],
                              )),
                        ],
                      ),
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
