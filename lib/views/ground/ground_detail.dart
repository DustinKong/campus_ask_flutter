import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/ColorUtil.dart';
import '../api/LogUtil.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
import '../api/LogUtil.dart';

class GroundDetailPage extends StatefulWidget {
  final arguments;
  GroundDetailPage({this.arguments});
  @override
  _GroundDetailPageState createState() => _GroundDetailPageState();
}

class _GroundDetailPageState extends State<GroundDetailPage> {
  var _futureBuilderFuture;
  // Future _gerData() async {
  //   var response = HttpUtil()
  //       .get('http://api.douban.com/v2/movie/top250', data: {'count': 15});
  //   return response;
  // }
  Future _getData;
  var show, comment;
  TextEditingController commentController = new TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getData = FutureDio('post', Api.login, {"sid": "076003"}).then((res) {
    //   print(res.data);
    //   setState(() {
    //     show=res.data;
    //   });
    // });
    _futureBuilderFuture = _getData;
    FutureDio('get', Api.getArticleById + '/' + widget.arguments['id'], {}).then((res) {
      LogUtil.d(res.data['data']);
      setState(() {
        show = res.data['data'];
      });
    });

    FutureDio('get', Api.getNewComment + '/' + widget.arguments['id'] + "/" + "2", {}).then((res) {
      LogUtil.d(res.data['data']);
      setState(() {
        comment = res.data['data'];
      });
    });
    // LogUtil.init(title: "来自LogUtil",limitLength:800);

    var log = "我是日志";
    //仅在Debug时打印
    LogUtil.d(log);
    LogUtil.d("我是日志");
  }
  Future _createSelectViewWithContext() async {
    //屏幕宽高
    RenderBox renderBox = context.findRenderObject();
    var screenSize = renderBox.size;
    await showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Color(0x62d2d2d),
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(builder: (context, state) {
            return GestureDetector(
              child:
              Stack(alignment: AlignmentDirectional.topCenter, children: <
                  Widget>[
                Container(
                  color: Colors.transparent,
                  height: screenSize.height * 0.7,
                  width: double.infinity,
                ),
                Container(
                  height: screenSize.height * 0.35,
                  width: screenSize.width * 1.0,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(20.0))),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: 45,
                        width: screenSize.width * 0.95,
                        child: Row(
                          children: <Widget>[
                            Container(
                              margin:
                              EdgeInsets.only(left: screenSize.width * 0.4),
                              child: Text('写评论',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black)),
                            ),
                            InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              hoverColor: Colors.transparent,
                              child: Container(
                                margin: EdgeInsets.only(
                                    left: screenSize.width * 0.2),
                                padding: EdgeInsets.only(left: 5, top: 3),
                                width: 45,
                                height: 25,
                                decoration: BoxDecoration(
                                    borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                    color: Colors.deepOrangeAccent),
                                child: Text(
                                  '发送',
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.white),
                                ),
                              ),
                              onTap: () {
                              },
                            )
                          ],
                        ),
                      ),
                      Container(
                          height: 95,
                          width: screenSize.width * 0.90,
                          decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.all(Radius.circular(20)),
                              color: Color(0xFFF0F0F0)),
                          child: Container(
                            margin: EdgeInsets.only(bottom: 5),
                            color: Colors.transparent,
                            child: TextField(
                              controller: commentController,
                              autofocus: true,
                              maxLength: 100,
                              maxLengthEnforced: true,
                              maxLines: 5,
                              enableInteractiveSelection: true,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.all(10.0),
                                  border: InputBorder.none),
                            ),
                          ))
                    ],
                  ),
                )
              ]),
              onTap: () => false,
            );
          });
        });
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
        title: new Text(
          "帖子详情",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
      ),
      body: Column(
        children: <Widget>[
          ListTile(
              // isThreeLine:true,
              leading: ClipOval(
                child: CachedNetworkImage(
                  fit: BoxFit.fill,
                  height: 35,
                  width: 35,
                  imageUrl: show['userEntity']['avatarUrl'],
                ),
              ),
              title: Text(
                show['userEntity']['nickname'],
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(show['createTime']),
                  Text(
                    show['articleText'],
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
              trailing: Container(
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: ColorsUtil.deepPurple()),
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
            width: ScreenUtil().screenWidth - 30.w,
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
                      show['articleLike'].toString(),
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
          ),
          Container(
            color: ColorsUtil.hexColor(0xebebeb),
            height: 10,
            width: ScreenUtil().screenWidth,
            margin: EdgeInsets.fromLTRB(0, 10, 0, 5),
          ),
          Padding(
            padding: EdgeInsets.all(10),
            child: Row(children: <Widget>[
              Text(
                "  评论 " + "·" + " " + comment['size'].toString(),
                style: TextStyle(fontSize: 20),
              ),
            ],)
          )
        ],
      ),
      bottomSheet: Container(
        height: 60,
        padding: EdgeInsets.only(bottom: 15),
        color: Colors.white,
        child: Row(
          children: <Widget>[
            InkWell(
              child: Container(
                width: 300.w,
                margin: EdgeInsets.only(left: 10, top: 10),
                child: Container(
                    margin: EdgeInsets.only(right: 20),
                    height: 30,
                    decoration: new BoxDecoration(
                        color: Color(0xFFF0F0F0), borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: Container(
                      width: 50,
                      padding: EdgeInsets.only(left: 10,top: 7),
                      child: InkWell(
                        onTap: _createSelectViewWithContext,
                        child: Text('${commentController.text==null||commentController.text==''?'来说些什么吧':commentController.text}',style: TextStyle(
                            color: commentController.text==null||commentController.text==''?Colors.grey:Colors.black
                        ),maxLines: 1,overflow: TextOverflow.visible,),
                      ),
                    )),
              ),
              onTap: _createSelectViewWithContext,
            ),
            InkWell(
              child: Container(
                height: 30,
                width: 45,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 10),
                decoration: BoxDecoration(
                  color: Colors.deepOrangeAccent,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
                child: Text('发送',style: TextStyle(
                    color: Colors.white,
                    fontSize: 12
                ),),
              ),
              onTap: _createSelectViewWithContext,
            ),
          ],
        ),
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
