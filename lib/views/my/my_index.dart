import 'package:cached_network_image/cached_network_image.dart';
import 'package:campus_ask_flutter/views/api/ColorUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  Map userInfo = {};
  @override
  void initState() {
    super.initState();
    // FutureDio('get', Api.UserInfo, {"user_id": SpUtil.preferences.getString("user_id")}).then((res) {
    //   print(res.data['data']);
    //   setState(() {
    //     userInfo = res.data['data'];
    //   });
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          elevation: 0, //隐藏底部阴影分割线
          title: Text(
            "我的",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: <Widget>[
            Container(
              height: 230,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/images/my/Magazine.png"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(20, 30, 5, 10),
                    child: Image.asset(
                      "assets/images/my/默认头像备份@2x.png",
                      height: 110,
                      width: 110,
                    ),
                  ),
                  Expanded(
                      child: Column(
                    children: <Widget>[
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 30, 10, 10),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "未登录",
                                textAlign: TextAlign.left,
                                style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "浙江工商大学",
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                      Padding(
                          padding: EdgeInsets.fromLTRB(0, 0, 10, 5),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "计算机与信息工程学院",
                                style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w600),
                              ),
                            ],
                          )),
                    ],
                  ))
                ],
              ),
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "99",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text("帖子", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "99",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text("消息", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "99",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text("关注", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.all(10),
                    child: Column(
                      children: <Widget>[
                        Text(
                          "999",
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                        ),
                        Text("粉丝", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600))
                      ],
                    ),
                  ),
                ),
              ],
            ),
            ListTile(
              trailing: InkWell(
                child: Container(
                  width: 80,
                  child: Row(
                    children: <Widget>[
                      Text("积分商城"),
                      Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  print("积分商城");
                },
              ),
              title: Text(
                "做任务赚积分",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
              ),
            ),
            Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0.0, 6.0))],
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: Column(
                children: <Widget>[
                  InkWell(
                    child: ListTile(
                      title: Text(
                        "我的信息",
                        style: TextStyle(fontSize: 18),
                      ),
                      leading: Image.asset(
                        "assets/images/my/用户@2x.png",
                        height: 30,
                        width: 30,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    onTap: () {},
                  ),
                  Divider(
                    height: 1.0,
                    indent: 20.0,
                    endIndent: 20.0,
                    color: Colors.grey,
                  ),
                  InkWell(
                    child: ListTile(
                      title: Text(
                        "邀请好友",
                        style: TextStyle(fontSize: 18),
                      ),
                      leading: Image.asset(
                        "assets/images/my/积分@2x.png",
                        height: 30,
                        width: 30,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    onTap: () {},
                  ),
                  Divider(
                    height: 1.0,
                    indent: 60.0,
                    color: Colors.grey,
                  ),
                  InkWell(
                    child: ListTile(
                      title: Text(
                        "赞赏",
                        style: TextStyle(fontSize: 18),
                      ),
                      leading: Image.asset(
                        "assets/images/my/赞评@2x.png",
                        height: 30,
                        width: 30,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    onTap: () {},
                  ),
                  Divider(
                    height: 1.0,
                    indent: 60.0,
                    color: Colors.grey,
                  ),
                  InkWell(
                    child: ListTile(
                      title: Text(
                        "意见反馈",
                        style: TextStyle(fontSize: 18),
                      ),
                      leading: Image.asset(
                        "assets/images/my/档案@2x.png",
                        height: 30,
                        width: 30,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    onTap: () {Navigator.pushNamed(context, '/myAboutPage');},
                  ),
                  Divider(
                    height: 1.0,
                    indent: 60.0,
                    color: Colors.grey,
                  ),
                  InkWell(
                    child: ListTile(
                      title: Text(
                        "关于平台",
                        style: TextStyle(fontSize: 18),
                      ),
                      leading: Image.asset(
                        "assets/images/my/促销@2x.png",
                        height: 30,
                        width: 30,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    onTap: () {Navigator.pushNamed(context, '/myAboutPage');},
                  ),
                ],
              ),
            ),
            SizedBox(height: 80,)

          ],
        ));
  }
}
