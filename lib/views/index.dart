import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import './Tabs.dart';
import 'api/api.dart';
import 'api/ColorUtil.dart';
import 'api/LogUtil.dart';
import 'api/api2.dart';
import 'api/SpUtil.dart';
import 'api/FutureDioToken.dart';

class Index extends StatefulWidget {
  @override
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
  //轮播图
  List _swiperlist = [
    'assets/images/home/轮播图0@2x.png',
    'assets/images/home/轮播图1@2x.png',
    'assets/images/home/轮播图2@2x.png',
  ];
  List showList = [];
  String university = "浙江工商大学";
  ScrollController _scrollController;
  FocusNode searchFocusNode = FocusNode();
  TextEditingController searchController = new TextEditingController();
  int type = 1; //校园新闻 1 事物通知 2
  Future _getData;
  @override
  void initState() {
    super.initState();
    //判断是否登录
    // String token = SpUtil.preferences.getString('user_token');
    // print(token);
    // if (token == null) {
    //   Future.delayed(Duration(milliseconds: 100)).then((e) {
    //     Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);
    //   });
    // } else
    //   FutureDio('get', Api.getUserPermissionByToken, {"pageNo":1,"pageSize":33}).then((res) {
    //     print(res.data['data']);
    //   });
    _getData = FutureDio('post', Api.login, {"sid": "076003"}).then((res) {
      print(res);
    });
  }

  Widget _buildFuture(BuildContext context, AsyncSnapshot snapshot) {
    switch (snapshot.connectionState) {
      case ConnectionState.none:
        return Center(
          child: CircularProgressIndicator(),
        );
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
          return InkWell(
            child: Container(
              padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  ListTile(
                    title: showList[index]['title'],
                  ),
                  CachedNetworkImage(fit: BoxFit.cover, height: 80, width: 160, imageUrl: showList[index]['pic'])
                  // TODO wait data
                ],
              ),
            ),
            onTap: () {},
          );
        });
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, width: 750, height: 1334, allowFontScaling: false);
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0, //隐藏底部阴影分割线
          title: new Text(
            "校园问问",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                      padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            university,
                            style: TextStyle(fontSize: 17),
                          ),
                          IconButton(icon: Icon(Icons.keyboard_arrow_down), onPressed: () {})
                        ],
                      )),
                  flex: 2,
                ),
                Expanded(
                  flex: 3,
                  child: Container(
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
                                  fontSize: ScreenUtil.screenHeight * 0.019,
                                ),
                                hintText: '搜索感兴趣的内容',
                                border: InputBorder.none,
                              ),
                            ),
                          )
                        ],
                      )),
                ),
              ],
            ),
            Container(
              padding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 10.0),
              alignment: Alignment.topLeft,
              child: Column(
                children: <Widget>[
                  Container(
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10))),
                      // height: 300,
                      child: AspectRatio(
                        aspectRatio: 20 / 8,
                        child: Swiper(
                          autoplay: true,
                          key: UniqueKey(),
                          itemBuilder: (BuildContext context, int index) {
                            return InkWell(onTap: () {}, child: Image.asset(_swiperlist[index]));
                          },
                          itemCount: _swiperlist.length,
                          viewportFraction: 0.8,
                          scale: 0.9,
                          pagination: SwiperPagination(
                              builder: DotSwiperPaginationBuilder(
                                  size: 5, color: Colors.black12, activeColor: Colors.pinkAccent, activeSize: 5)),
                        ),
                      )),
                ],
              ),
//              height: 280.0,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   colors: [
//                     Color(0xff3954A3),
//                     Color(0xff3954A3),
//                     Color(0xff3954A3),
//                     Colors.white,
//                   ],
//                 ),
//               ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (content) {
                          return BottomNavigationWidget(index: 1, pageIndex: 0);
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/home/首页1@2x(2).png',
                              height: 37,
                              width: 37,
                            ),
                          ),
                          Text(
                            '校园导览',
                            style: TextStyle(fontSize: 14, color: Color(0xff666666)),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (content) {
                          return BottomNavigationWidget(index: 1, pageIndex: 1);
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/home/位置聊天@2x.png',
                              height: 37,
                              width: 37,
                            ),
                          ),
                          Text(
                            '位置聊天',
                            style: TextStyle(fontSize: 14, color: Color(0xff666666)),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (content) {
                          return BottomNavigationWidget(index: 1, pageIndex: 2);
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/home/交友盲盒@2x.png',
                              height: 37,
                              width: 37,
                            ),
                          ),
                          Text(
                            '交友盲盒',
                            style: TextStyle(fontSize: 14, color: Color(0xff666666)),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (content) {
                          return BottomNavigationWidget(index: 1, pageIndex: 3);
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/home/首页1@2x(1).png',
                              height: 37,
                              width: 37,
                            ),
                          ),
                          Text(
                            '跳蚤市场',
                            style: TextStyle(fontSize: 14, color: Color(0xff666666)),
                          )
                        ],
                      ),
                    )),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (content) {
                          return BottomNavigationWidget(index: 1, pageIndex: 0);
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/home/办事流程@2x.png',
                              height: 37,
                              width: 37,
                            ),
                          ),
                          Text(
                            '办事流程',
                            style: TextStyle(fontSize: 14, color: Color(0xff666666)),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (content) {
                          return BottomNavigationWidget(index: 1, pageIndex: 1);
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/home/6-社团介绍@2x.png',
                              height: 37,
                              width: 37,
                            ),
                          ),
                          Text(
                            '社团介绍',
                            style: TextStyle(fontSize: 14, color: Color(0xff666666)),
                          )
                        ],
                      ),
                    )),
                Expanded(
                    flex: 1,
                    child: InkWell(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (content) {
                          return BottomNavigationWidget(index: 1, pageIndex: 2);
                        }));
                      },
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Image.asset(
                              'assets/images/home/竞赛汇总@2x.png',
                              height: 37,
                              width: 37,
                            ),
                          ),
                          Text(
                            '竞赛汇总',
                            style: TextStyle(fontSize: 14, color: Color(0xff666666)),
                          )
                        ],
                      ),
                    )),
                Expanded(flex: 1, child: Container()),
              ],
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Image.asset(
                'assets/images/home/引导认证小卡片@2x.png',
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: <Widget>[
                InkWell(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Text("校园新闻",
                            style: TextStyle(
                                fontSize: 26,
                                color: type == 1 ? Colors.black : Colors.grey,
                                fontWeight: FontWeight.w600)),
                        Container(
                          color: type == 1 ? ColorsUtil.orange() : Colors.white,
                          height: 5,
                          width: 100,
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  onTap: () {
                    LogUtil.d("校园新闻");
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
                          "事物通知",
                          style: TextStyle(
                              fontSize: 26, color: type == 2 ? Colors.black : Colors.grey, fontWeight: FontWeight.w600),
                        ),
                        Container(
                          color: type == 2 ? ColorsUtil.orange() : Colors.white,
                          height: 5,
                          width: 100,
                        )
                      ],
                    ),
                    padding: EdgeInsets.all(10),
                  ),
                  onTap: () {
                    LogUtil.d("事物通知");
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
          ],
        ));
  }
}
