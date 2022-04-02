import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';

class MyProfilePage extends StatefulWidget {
  @override
  _MyProfilePageState createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  var realName = new TextEditingController();
  var company = new TextEditingController();
  var position = new TextEditingController();
  Map userInfo = {};
  String sex;
  @override
  void initState() {
    super.initState();
    FutureDio('get', Api.UserInfo, {"user_id": SpUtil.preferences.getString("user_id")}).then((res) {
      print(res.data['data']);
      setState(() {
        userInfo = res.data['data'];
        realName= TextEditingController(text:res.data['data']['realName']);
        company= TextEditingController(text:res.data['data']['company']);
        position= TextEditingController(text:res.data['data']['position']);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: new Text("个人资料"),
        backgroundColor: Color(0xff3954A3),
      ),
      body: ListView(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffb1b1b1),
                      blurRadius: 5.0,
                      offset: Offset(5.0, 5.0),
                    ),
                  ]),
              child: Column(
                children: <Widget>[
                  ListTile(
                    title: Text(
                      "头像",
                      style: TextStyle(fontSize: 16),
                    ),
                    trailing: ClipOval(
                      child: CachedNetworkImage(
                        imageUrl: userInfo['head'] ??
                            "https://qtt-cmall.oss-accelerate.aliyuncs.com/rotation/202104/1617546202220logo.png",
                        fit: BoxFit.cover,
                        height: 65,
                        width: 65,
                      ),
                    ),
                  ),
                  Row(
                    children: <Widget>[
                      Text(
                        '*',
                        style: TextStyle(color: Colors.red, fontSize: 18),
                      ),
                      SizedBox(width: 10,),
                      Expanded(child: Text('姓名')),
                      Expanded(
                        child: TextField(
                          controller: realName,
                          textAlign: TextAlign.right,
                          onChanged: (value) => userInfo['realName'] = value,
                          decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              hintText: userInfo['realName'] ?? "请输入姓名",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(width: 20,),

                          Text('性别'),
                        ],
                      ),
                      Container(
                          child: DropdownButton(
                            items: [
                              DropdownMenuItem(value: '1', child: Text('男')),
                              DropdownMenuItem(value: '0', child: Text('女'))
                            ],
//                            hint: Text('请选择'),
                            onChanged: (value) {
                              setState(() {
                                userInfo["sex"]  = value;
                                sex=value;
                              });
                            },
                            //                    isExpanded: true,
                            icon: Icon(Icons.keyboard_arrow_right),
                            value: sex,
                            hint: Text(userInfo['sex']==0?'女':"男"),
                            underline: Container(height: 0),
                          ))
                    ],
                  ),
                ],
              )),
          Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(
                  color: Color(0xffffffff),
                  borderRadius: BorderRadius.all(Radius.circular(15.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xffb1b1b1),
                      blurRadius: 5.0,
                      offset: Offset(5.0, 5.0),
                    ),
                  ]),
              child: Column(
                children: <Widget>[
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(child: Text('公司')),
                      Expanded(
                        child: TextField(
                          controller: company,
                          textAlign: TextAlign.right,
                          onChanged: (value) => userInfo['company'] = value,
                          decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              hintText: userInfo['company'] ?? "请输入公司",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      SizedBox(width: 10,),
                      Expanded(child: Text('职位')),
                      Expanded(
                        child: TextField(
                          controller: position,
                          textAlign: TextAlign.right,
                          onChanged: (value) => userInfo['position'] = value,
                          decoration: InputDecoration(
                              fillColor: Colors.transparent,
                              filled: true,
                              contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                              hintText: userInfo['position'] ?? "请输入公司",
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                              )),
                        ),
                      ),
                    ],
                  ),
                ],
              )),
          Container(
              padding: EdgeInsets.only(top: 25),
              height: 60,
              child: Center(
                child: Container(
                    width: ScreenUtil.screenWidth * 0.9,
                    child: FlatButton(
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
                      color: Color(0xff3954A3),
                      textColor: Colors.white,
                      child: Text('提交'),
                      onPressed: () {
                        FutureDio('put', Api.ChangeInfo,{
                          "company": userInfo['company'],
                          "position": userInfo['position'],
                          "realName": userInfo['realName'],
                          "userId": userInfo['userId'],
                        } ).then((res){
                          print(res.data);
                          if (res.data["code"] == 200) {
                            print('commit success');
                            Fluttertoast.showToast(
                                msg: "修改成功",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.CENTER,
                                timeInSecForIosWeb: 2,
                                backgroundColor: Colors.black38,
                                textColor: Colors.white,
                                fontSize: 16.0)
                                .then((value) {
                              Future.delayed(Duration(milliseconds: 2000)).then((e) {
                                Navigator.pop(context);
                              });
                            });
                          }
                        });
                      },
                    )),
              )),
        ],
      ),
    );
  }
}
