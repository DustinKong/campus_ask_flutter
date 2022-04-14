import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:math';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'api/SpUtil.dart';
import 'api/api.dart';
// import 'package:apifm/apifm.dart' as Apifm;

bool _saving = false;
bool needFindAccount = false;

class MainLoginPage extends StatefulWidget {
  @override
  MainLoginPageState createState() => new MainLoginPageState();
}

class MainLoginPageState extends State<MainLoginPage> {
  // 判断是否登录
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          backgroundColor: Color(0xff3954A3),
          title: new Text("登录"),
        ),
        body: ModalProgressHUD(
            inAsyncCall: _saving,
            child: ListView(
              children: <Widget>[
                Container(
                  color: Colors.white,
                  padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '校园问问',
                        style: TextStyle(
                            fontSize: 36,
                            //                              fontFamily: "DFST-G7",
                            color: Color(0xff3954A3),
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        '欢迎您',
                        style: TextStyle(
                            //                              fontFamily: "DFST-G7",
                            fontSize: 36,
                            color: Color(0xff3954A3),
                            fontWeight: FontWeight.w800),
                      ),
                    ],
                  ),
                ),
                LoginPage(),
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: Container(
                    //                    width: 400,
                    child: Image.asset('assets/images/home/轮播图0@2x(1).png', fit: BoxFit.cover),
                  ),
                )
              ],
            )));
  }
}

// 这是登录界面
class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() {
    return _LoginPageState();
  }
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var username = new TextEditingController();
  var password = new TextEditingController();
  var randomCode = new TextEditingController();

  var verifyPhoneNum = new TextEditingController();
  var emailVerifyNum = new TextEditingController();
  var codeController = new TextEditingController();
  var randomPic = null;
  var idCode;

  Color btnColor = Colors.deepOrange;
  bool isCheck = false;
  Timer _timer;
  //倒计时数值
  var _countdownTime = 0;

  //倒计时方法
  startCountdown() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
    _countdownTime = 60;

    final call = (timer) {
      if (_countdownTime < 1) {
        _timer.cancel();
      } else {
        setState(() {
          _countdownTime -= 1;
        });
      }
    };
    _timer = Timer.periodic(Duration(seconds: 1), call);
  }

  @override
  void dispose() {
    super.dispose();
    if (_timer != null) {
      _timer.cancel();
    }
  }

  void getRandom() async {
    print("random");
    String scopeF = '123456789'; //首位
    String scopeC = '0123456789'; //中间
    String result = '';
    for (int i = 0; i < 13; i++) {
      if (i == 0) {
        result = scopeF[Random().nextInt(scopeF.length)];
      } else {
        result = result + scopeC[Random().nextInt(scopeC.length)];
      }
    }
    this.idCode = result;
    print("result");
    print(result);
    Response response = await Dio().get(
      Api.randomImage + "/" + result,
    );
    setState(() {
      this.randomPic = response.data["result"];
    });
    print(response);
  }

  void _vercodeLogin() async {
    try {
      setState(() {
        _saving = true;
      });
      Map _data;

      ///正常登录
      _data = {"captcha": randomCode.text, "checkKey": idCode, "password": password.text, "username": username.text};

      print(_data);
      Response response = await Dio().post(
        Api.login,
        data: _data,
      );

      print(response);
      if (response.data['code'] == 200) {
        print('VercodeLogin success');

        print('success');
        print(response.data['result']);
        print(response.data["result"]['token']);
        print(response.data["result"]["userInfo"]['id']);
        final prefs = await SharedPreferences.getInstance();
        final setTokenResult = await prefs.setString('user_token', response.data["result"]['token']);
        // await prefs.setString('user_nickname', response.data["data"]['nickname']);
        await prefs.setString('user_id', response.data["result"]["userInfo"]['id']);
        // await prefs.setString('user_head', response.data["data"]['head']);
        // await prefs.setString('user_phone', response.data["data"]['vercode']['mobile']);
        if (setTokenResult) {
          debugPrint('保存登录token成功');
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/',
            (route) => route == null,
          );
        } else {
          debugPrint('error, 保存登录token失败');
        }
      } else {
        Fluttertoast.showToast(
            msg: response.data['message'],
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.black38,
            textColor: Colors.white,
            fontSize: 16.0);
      }

      ///设置为不需要找回账户
      SpUtil.preferences.setBool('needFindAccount', false);
      print(SpUtil.preferences.getBool('needFindAccount'));
      setState(() {
        _saving = false;
      });
      return print(response.data["data"]);
    } catch (e) {
      setState(() {
        _saving = false;
      });
      return print(e);
    }
  }

  @override
  void initState() {
    super.initState();

    // getRandom();
    username.text = '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // 可以点击空白收起键盘
      behavior: HitTestBehavior.translucent,
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode()); // 收起键盘
      },
      child: Container(
        color: Colors.white,
        // 所有内容都设置向内55
        padding: EdgeInsets.all(27.5),
        // 垂直布局
        child: Column(
          children: <Widget>[
            // 使用Form将两个输入框包起来 做控制
            Form(
              key: _formKey,
              // Form里面又是一个垂直布局
              child: Column(
                children: <Widget>[
                  // 输入手机号
                  TextFormField(
                    // 是否自动对焦
                    autofocus: false,
                    // 装饰
                    controller: username,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFf9f8fd),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.account_box,
                          color: Color(0xff3954A3),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        hintText: '请输入账号',
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(22))),
                  ),
                  // 间隔
                  SizedBox(height: 20),
                  TextFormField(
                    // 是否自动对焦
                    autofocus: false,
                    // 装饰
                    controller: password,
                    decoration: InputDecoration(
                        fillColor: Color(0xFFf9f8fd),
                        filled: true,
                        prefixIcon: Icon(
                          Icons.branding_watermark,
                          color: Color(0xff3954A3),
                        ),
                        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        hintText: '请输入密码',
                        border:
                            OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.circular(22))),
                  ),
                  // 间隔
                  SizedBox(height: 20),
                  // Padding(
                  //   padding: EdgeInsets.all(0),
                  //   child: Row(
                  //     children: <Widget>[
                  //       Expanded(
                  //         child: TextFormField(
                  //           // 是否自动对焦
                  //           autofocus: false,
                  //           // 装饰
                  //           controller: randomCode,
                  //           decoration: InputDecoration(
                  //               fillColor: Color(0xFFf9f8fd),
                  //               filled: true,
                  //               prefixIcon: Icon(
                  //                 Icons.phone_android,
                  //                 color: Color(0xff3954A3),
                  //               ),
                  //               contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  //               hintText: '验证码',
                  //               border: OutlineInputBorder(
                  //                   borderSide: BorderSide.none, borderRadius: BorderRadius.circular(22))),
                  //         ),
                  //       ),
                  //       Expanded(
                  //           child: InkWell(
                  //               child:randomPic!=null? Image.memory(
                  //                 base64.decode(randomPic.split(',')[1]),
                  //                 height: 50, //设置高度
                  //                 width: 60, //设置度
                  //                 fit: BoxFit.fill, //填充
                  //                 gaplessPlayback: true, //防止重绘
                  //               ):Container(width: 60,height: 50,),
                  //               onTap: () {
                  //                 getRandom();
                  //               })),
                  //     ],
                  //   ),
                  // )
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22))),
                    color: Colors.green,
                    child: Text(
                      '微信登录',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      if (username.text != "" && password.text != "") {
                        print('正在登录');
//                      print(verifyPhoneNum.text);
//                     _vercodeLogin();
                        SpUtil.preferences.setString("user_token", "xxx");
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      } else {
                        Fluttertoast.showToast(
                            msg: "请先填写信息",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black38,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  ),
                  width: 120,
                ),
                SizedBox(width: 15,),
                Container(
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22))),
                    color: btnColor,
                    child: Text(
                      '普通登录',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                    onPressed: () {
                      if (username.text != "" && password.text != "") {
                        print('正在登录');
//                      print(verifyPhoneNum.text);
//                     _vercodeLogin();
                        SpUtil.preferences.setString("user_token", "xxx");
                        Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
                      } else {
                        Fluttertoast.showToast(
                            msg: "请先填写信息",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.CENTER,
                            timeInSecForIosWeb: 1,
                            backgroundColor: Colors.black38,
                            textColor: Colors.white,
                            fontSize: 16.0);
                      }
                    },
                  ),
                  width: 120,
                ),
//                     Container(
//                       width: 120,
//                       child: RaisedButton(
//
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22))),
//                         color: btnColor,
//                         child: Text(
//                           '普通登录',
//                           style: TextStyle(fontSize: 20, color: Colors.white),
//                         ),
//                         onPressed: () {
//                           if (username.text != "" && password.text != "") {
//                             print('正在登录');
// //                      print(verifyPhoneNum.text);
// //                     _vercodeLogin();
//                             SpUtil.preferences.setString("user_token", "xxx");
//                             Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//                           } else {
//                             Fluttertoast.showToast(
//                                 msg: "请先填写信息",
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 gravity: ToastGravity.CENTER,
//                                 timeInSecForIosWeb: 1,
//                                 backgroundColor: Colors.black38,
//                                 textColor: Colors.white,
//                                 fontSize: 16.0);
//                           }
//                         },
//                       ),
//
//                     )
              ],
            ),
//             Container(
//                 height: 44,
//                 width: MediaQuery.of(context).size.width - 220,
// //            width: 320,
// //              decoration: BoxDecoration(
// //                color: Color(0xFFbabdd5), borderRadius: BorderRadius.circular(22)),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Container(
//                       child: RaisedButton(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22))),
//                         color: Colors.green,
//                         child: Text(
//                           '微信登录',
//                           style: TextStyle(fontSize: 20, color: Colors.white),
//                         ),
//                         onPressed: () {
//                           if (username.text != "" && password.text != "") {
//                             print('正在登录');
// //                      print(verifyPhoneNum.text);
// //                     _vercodeLogin();
//                             SpUtil.preferences.setString("user_token", "xxx");
//                             Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//                           } else {
//                             Fluttertoast.showToast(
//                                 msg: "请先填写信息",
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 gravity: ToastGravity.CENTER,
//                                 timeInSecForIosWeb: 1,
//                                 backgroundColor: Colors.black38,
//                                 textColor: Colors.white,
//                                 fontSize: 16.0);
//                           }
//                         },
//                       ),
//                       width: 120,
//                     ),
//                     Container(
//                       child: RaisedButton(
//                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22))),
//                         color: btnColor,
//                         child: Text(
//                           '普通登录',
//                           style: TextStyle(fontSize: 20, color: Colors.white),
//                         ),
//                         onPressed: () {
//                           if (username.text != "" && password.text != "") {
//                             print('正在登录');
// //                      print(verifyPhoneNum.text);
// //                     _vercodeLogin();
//                             SpUtil.preferences.setString("user_token", "xxx");
//                             Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
//                           } else {
//                             Fluttertoast.showToast(
//                                 msg: "请先填写信息",
//                                 toastLength: Toast.LENGTH_SHORT,
//                                 gravity: ToastGravity.CENTER,
//                                 timeInSecForIosWeb: 1,
//                                 backgroundColor: Colors.black38,
//                                 textColor: Colors.white,
//                                 fontSize: 16.0);
//                           }
//                         },
//                       ),
//                       width: 120,
//                     ),
// //                     Container(
// //                       width: 120,
// //                       child: RaisedButton(
// //
// //                         shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(22))),
// //                         color: btnColor,
// //                         child: Text(
// //                           '普通登录',
// //                           style: TextStyle(fontSize: 20, color: Colors.white),
// //                         ),
// //                         onPressed: () {
// //                           if (username.text != "" && password.text != "") {
// //                             print('正在登录');
// // //                      print(verifyPhoneNum.text);
// // //                     _vercodeLogin();
// //                             SpUtil.preferences.setString("user_token", "xxx");
// //                             Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
// //                           } else {
// //                             Fluttertoast.showToast(
// //                                 msg: "请先填写信息",
// //                                 toastLength: Toast.LENGTH_SHORT,
// //                                 gravity: ToastGravity.CENTER,
// //                                 timeInSecForIosWeb: 1,
// //                                 backgroundColor: Colors.black38,
// //                                 textColor: Colors.white,
// //                                 fontSize: 16.0);
// //                           }
// //                         },
// //                       ),
// //
// //                     )
//                   ],
//                 )),
            // RaisedButton(child: Text("go"),onPressed: (){
            //   Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            // },)
          ],
        ),
      ),
    );
  }
}
