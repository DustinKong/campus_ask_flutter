import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
import '../api/LogUtil.dart';

class GroundFormAct extends StatefulWidget {
  @override
  _GroundFormActState createState() => _GroundFormActState();
}

class _GroundFormActState extends State<GroundFormAct> {
  var name = new TextEditingController();
  var textController = new TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return FlutterEasyLoading(
      child: Scaffold(
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
        body: GestureDetector(
          // 可以点击空白收起键盘
          behavior: HitTestBehavior.translucent,
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode()); // 收起键盘
          },
          child: Padding(
            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
            child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Text(
                      '*',
                      style: TextStyle(color: Colors.red, fontSize: 18),
                    ),
                    Expanded(child: Text('活动名称')),
                    Expanded(
                      child: TextFormField(
                        // 是否自动对焦
                        autofocus: false,
                        // 输入模式设置为手机号
                        maxLengthEnforced: true,
                        maxLength: 20,
                        textAlign: TextAlign.right,
//          textDirection:TextDirection.rtl,
                        controller: name,
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            hintText: '请输入标题',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                        // 输入框校验
                        validator: (value) {
                          if (value == '') {
                            return '请输入标题';
                          }
                          return null;
                        },
                      ),
                    ),
                    Icon(Icons.border_color)
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                        child: Padding(
                            padding: EdgeInsets.fromLTRB(8, 10, 0, 0),
                            child: Row(
                              children: <Widget>[Text('视频说明')],
                            ))),
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        maxLines: 6,
                        minLines: 3,
                        // 是否自动对焦
                        autofocus: false,
                        // 输入模式设置为手机号
                        textAlign: TextAlign.right,
                        maxLength: 300,
                        // textDirection: TextDirection.rtl,
                        controller: textController,
                        decoration: InputDecoration(
                            fillColor: Colors.transparent,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            hintText: '输入视频说明',
                            border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                            )),
                      ),
                    ),
                    Icon(Icons.border_color)
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text('照片'),
                    Row(
                      children: <Widget>[Text(groupList.length.toString()), Text('/9')],
                    )
                  ],
                ),
                buildGrid(),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: ListTile(
                      title: Text(
                        "所在位置",
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Image.asset(
                        "assets/images/ground/定位@2x.png",
                        height: 20,
                        width: 20,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    onTap: () {
                      // Navigator.pushNamed(context, '/myAboutPage');
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10),
                  child: InkWell(
                    child: ListTile(
                      title: Text(
                        "添加标签",
                        style: TextStyle(fontSize: 16),
                      ),
                      leading: Image.asset(
                        "assets/images/ground/话题符号@2x.png",
                        height: 20,
                        width: 20,
                      ),
                      trailing: Icon(
                        Icons.arrow_forward_ios,
                        size: 16,
                      ),
                    ),
                    onTap: () {
                      // Navigator.pushNamed(context, '/myAboutPage');
                    },
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter, //右上
                              end: Alignment.bottomCenter, //左下
                              colors: [Color(0xffC7C9D1), Color(0xffD8D8D8)]), // 渐变色
                          borderRadius: BorderRadius.circular(10)),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.transparent, // 设为透明色
                        elevation: 0, // 正常时阴影隐藏
                        highlightElevation: 0, // 点击时阴影隐藏
                        onPressed: () {},
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            '取消',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter, //右上
                              end: Alignment.bottomCenter, //左下
                              colors: [Color(0xff6B2FE3), Color(0xff5536EB)]), // 渐变色
                          borderRadius: BorderRadius.circular(10)),
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        color: Colors.transparent, // 设为透明色
                        elevation: 0, // 正常时阴影隐藏
                        highlightElevation: 0, // 点击时阴影隐藏
                        onPressed: () {
                          FutureDio('post', Api.insertArticle, {
                            "title": name.text,
                            "content": textController.text,
                            "authorName": "张三",
                            "articleType": 1
                          }).then((res) {
                            print(res.data);
                            Fluttertoast.showToast(
                                    msg: "发布成功",
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.pink,
                                    textColor: Colors.white,
                                    fontSize: 16.0)
                                .then((value) {
                              Future.delayed(Duration(milliseconds: 1000)).then((e) {
                                Navigator.pop(context);
                              });

                            });
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 50,
                          child: Text(
                            '发布',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
