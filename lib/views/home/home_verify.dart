import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/ColorUtil.dart';
import '../api/LogUtil.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
import '../api/LogUtil.dart';

class HomeVerify extends StatefulWidget {
  @override
  _HomeVerifyState createState() => _HomeVerifyState();
}

class _HomeVerifyState extends State<HomeVerify> {
  var _futureBuilderFuture;
  // Future _gerData() async {
  //   var response = HttpUtil()
  //       .get('http://api.douban.com/v2/movie/top250', data: {'count': 15});
  //   return response;
  // }
  Future _getData;
  List<DropdownMenuItem<String>> sortItems1 = [];
  List<DropdownMenuItem<String>> sortItems2 = [];
  List<DropdownMenuItem<String>> sortItems3 = [];
  List<DropdownMenuItem<String>> sortItems4 = [];
  List<DropdownMenuItem<String>> sortItems5 = [];
  List groupList = [];
  final picker = ImagePicker();
  List<File> imageShowGroup = [null, null, null, null, null, null, null, null, null];
  List listPhoto = [
    {"id": '', "path": "", "notes": "", "status": 10},
    {"id": '', "path": "", "notes": "", "status": 10},
    {"id": '', "path": "", "notes": "", "status": 10}
  ];
  Future getImageFromGallery(int i) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.gallery);
      if (pickedFile != null) EasyLoading.show(status: '上传中');
      // String tmp = await UploadPicCompress.getCosWithNoCompress(pickedFile, 'other');
      //TODO 上传图片
      String tmp = "xx";
      if (tmp != null) {
        setState(() {
          imageShowGroup[i] = File(pickedFile.path);
          groupList.add({"id": '', "path": tmp, "notes": "", "status": 10});
          // listPhoto[i]['path'] = tmp;
        });
        print(imageShowGroup);
      }
      EasyLoading.dismiss();
    } catch (e) {
      print(e);
    }
  }

  Future getImageFromCamera(int i) async {
    try {
      final pickedFile = await picker.getImage(source: ImageSource.camera);
      if (pickedFile != null) EasyLoading.show(status: '上传中');
      // String tmp = await UploadPicCompress.getCosWithNoCompress(pickedFile, 'other');
      String tmp = "xx";
      if (tmp != null) {
        setState(() {
          imageShowGroup[i] = File(pickedFile.path);
          groupList.add({"id": '', "path": tmp, "notes": "", "status": 10});
          // listPhoto[i]['path'] = tmp;
        });
        print(imageShowGroup);
      }
      EasyLoading.dismiss();
    } catch (e) {
      print(e);
    }
  }

  var _typeOne="";
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // _getData = FutureDio('post', Api.login, {"sid": "076003"});
    // _futureBuilderFuture = _getData;
    // LogUtil.init(title: "来自LogUtil ",limitLength:800);

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
          "编辑内容",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
      ),
      body: ListView(children: [
        Container(
            height: 850.h,
            width: 360.w,
            decoration: BoxDecoration(
              image: new DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/home/2@2x.png',)
              ),
            ),
            child: Column(children: [
              Image.asset('assets/images/home/title@2x.png',height: 160.h,),
              Container(
                margin: EdgeInsets.all(25),
                padding: EdgeInsets.fromLTRB(30, 10, 30, 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('学校',style: TextStyle(fontSize: 18),),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.9),),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 00),
                          child: DropdownButton(
                            items: sortItems1,
                            hint: Text('请选择您的学校    '),
                            onChanged: (value) {
                              setState(() {
                                print(value);
                              });
                            },
                            //                          isExpanded: true,
                            value: _typeOne,
                            icon: Icon(Icons.keyboard_arrow_down),
                            underline: Container(height: 0),
                          ))
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('学院',style: TextStyle(fontSize: 18),),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.9),),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 00),
                          child: DropdownButton(
                            items: sortItems1,
                            hint: Text('请选择您的学院    '),
                            onChanged: (value) {
                              setState(() {
                                print(value);
                              });
                            },
                            //                          isExpanded: true,
                            value: _typeOne,
                            icon: Icon(Icons.keyboard_arrow_down),
                            underline: Container(height: 0),
                          ))
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('专业',style: TextStyle(fontSize: 18),),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.9),),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 00),
                          child: DropdownButton(
                            items: sortItems1,
                            hint: Text('请选择您的专业    '),
                            onChanged: (value) {
                              setState(() {
                                print(value);
                              });
                            },
                            //                          isExpanded: true,
                            value: _typeOne,
                            icon: Icon(Icons.keyboard_arrow_down),
                            underline: Container(height: 0),
                          ))
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('在校身份',style: TextStyle(fontSize: 18),),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.9),),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 00),
                          child: DropdownButton(
                            items: sortItems1,
                            hint: Text('请选择您的在校身份    '),
                            onChanged: (value) {
                              setState(() {
                                print(value);
                              });
                            },
                            //                          isExpanded: true,
                            value: _typeOne,
                            icon: Icon(Icons.keyboard_arrow_down),
                            underline: Container(height: 0),
                          ))
                    ],
                  ),
                  SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('入学年级',style: TextStyle(fontSize: 18),),
                      Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: ColorsUtil.hexColor(0xD8D8D8, alpha: 0.9),),
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                          padding: EdgeInsets.fromLTRB(5, 0, 5, 00),
                          child: DropdownButton(
                            items: sortItems1,
                            hint: Text('请选择您的入学年级    '),
                            onChanged: (value) {
                              setState(() {
                                print(value);
                              });
                            },
                            //                          isExpanded: true,
                            value: _typeOne,
                            icon: Icon(Icons.keyboard_arrow_down),
                            underline: Container(height: 0),
                          ))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text('上传学生卡',style: TextStyle(fontSize: 18),),
                      buildGrid(),
                    ],
                  ),

                ],),),
              InkWell(child: Image.asset('assets/images/home/按钮@2x.png',height: 160.h,),onTap: (){
                Fluttertoast.showToast(
                    msg: "认证成功！",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Colors.pink,
                    textColor: Colors.white,
                    fontSize: 16.0);
                Future.delayed(Duration(milliseconds: 800)).then((e) {
                  Navigator.pop(context);
                });

              },)
            ],)
        )
      ],)
    );
  }
  Widget buildGrid() {
    List<Widget> tiles = []; //先建一个数组用于存放循环生成的widget
    print(groupList);
    for (int i = 0; i < groupList.length + 1 && i < 9; i++) {
//      print(groupList[i]['name'].text);
      tiles.add(Column(
        children: <Widget>[
          //上传图片
          Padding(
            padding: EdgeInsets.fromLTRB(10, 25, 10, 25),
            child: Row(
              children: <Widget>[
                imageShowGroup[i] == null
                    ? Row(
                  children: <Widget>[
                    Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      color: Color(0xfff1eff2),
                      child: IconButton(
                          icon: Icon(
                            Icons.photo_camera,
                            color: Colors.black,
                            size: 40,
                          ),
                          onPressed: () {
                            print('照片' + (i + 1).toString());
                            getImageFromCamera(i);
                          }),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: 65,
                      width: 65,
                      alignment: Alignment.center,
                      color: Color(0xfff1eff2),
                      child: IconButton(
                          icon: Icon(
                            Icons.photo,
                            color: Colors.black,
                            size: 40,
                          ),
                          onPressed: () {
                            print('照片' + (i + 1).toString());
                            getImageFromGallery(i);
                          }),
                    ),
                  ],
                )
                    : Container(
                  child: Stack(
                    children: <Widget>[
                      Align(
                        child: Image.file(
                          imageShowGroup[i],
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                          left: 62,
                          //                                        top: 10,
                          child: InkWell(
                            onTap: () {
                              print(i);
                              setState(() {
                                imageShowGroup.removeAt(i);
                                groupList[i]['notes'] = '';
                                groupList.removeAt(i);
                              });
                              // print(imageShowGroup);
                              // print(groupList);
                            },
                            child: Icon(
                              Icons.clear,
                              color: Colors.white,
                            ),
                          ))
                    ],
                  ),
                )
              ],
            ),
          ),
          // TextField(
          //   // 是否自动对焦
          //   autofocus: false,
          //   onChanged: (value) => groupList[i]['notes'] = value,
          //   inputFormatters: [LengthLimitingTextInputFormatter(25)],
          //   style: TextStyle(fontSize: 14),
          //   decoration: InputDecoration(
          //     prefixIcon: Container(height: 3,width: 3,child: Image.asset(
          //       'assets/images/write.png',
          //     ),),
          //     prefixIconConstraints:BoxConstraints(
          //         minHeight: 16,
          //         minWidth: 16
          //     ),
          //     fillColor: Colors.transparent,
          //     filled: true,
          //     // contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          //     hintText: '请输入图片描述文字',
          //   ),
          //   // 输入框校验
          // ),
          // Divider(
          //   height: 0,
          // ),
          // SizedBox(
          //   height: 15,
          // ),
        ],
      ));
    }
    return Column(children: tiles);
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
        LogUtil.d('finished');
        LogUtil.d(snapshot.data);
        List showList = snapshot.data.data['data']['records'];
        return ListView.builder(
            itemCount: showList.length,
            itemBuilder: (context, index) {
              return Container();
            });
      default:
        return null;
    }
  }
}
