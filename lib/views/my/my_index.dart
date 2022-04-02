import 'package:cached_network_image/cached_network_image.dart';
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
        appBar: AppBar(
          automaticallyImplyLeading:false,
          elevation: 0, // 隐藏阴影
          centerTitle: true,
          title: new Text("个人中心"),
          backgroundColor: Color(0xff3954A3),
          // actions: <Widget>[
          //   IconButton(
          //     icon: Icon(
          //       Icons.settings,
          //       color: Colors.white,
          //     ),
          //     onPressed: () {
          //       Navigator.pushNamed(context, '/mySettingPage');
          //     },
          //   )
          // ],
        ),
        body: ListView(children: <Widget>[
          InkWell(
            child: ListTile(
              trailing: Icon(Icons.arrow_forward_ios),
              title: Text(
                "退出登录",
                style: TextStyle(fontSize: 24),
              ),
            ),
            onTap: () {
              SpUtil.preferences.remove("user_id");
              SpUtil.preferences.remove("user_token");
              Navigator.pushNamedAndRemoveUntil(context, '/login', (route) => false);},
          ),
        ],));
  }
}
