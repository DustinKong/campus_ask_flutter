import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';

class HomeStandardPage extends StatefulWidget {
  @override
  _HomeStandardPageState createState() => _HomeStandardPageState();
}

class _HomeStandardPageState extends State<HomeStandardPage> {
  List standList = [];

  @override
  void initState() {
    super.initState();
    FutureDio('get', Api.taskStandard, {"pageNo": 1, "pageSize": 40}).then((res) {
      print(res.data['data']);
      setState(() {
        standList = res.data['result']['records'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("作业项目规范"),
        backgroundColor: Color(0xff3954A3),
      ),
      body: ListView.separated(
          itemCount: standList.length,
          separatorBuilder: (BuildContext context, int index) {
             return Divider(color: Colors.grey,height: 6,thickness: 2,);
          },
          itemBuilder: (context, index) {
            return InkWell(
              child: ListTile(
                leading: Text((index + 1).toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                title: Text(standList[index]['taskName']),
                trailing: Icon(Icons.arrow_forward_ios),
                onTap: () {
                  showDialog<Null>(
                    context: context,
                    barrierDismissible: true,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('详情'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: <Widget>[
                              Text("作业方式:" + standList[index]['taskType_dictText']),
                              SizedBox(
                                height: 10,
                              ),
                              Text("校园问问时间:" + standList[index]['workingHour']),
                              SizedBox(
                                height: 10,
                              ),
                              Text("减少停电时间:" + standList[index]['saveHours']),
                              SizedBox(
                                height: 10,
                              ),
                              Text("作业人数:" + standList[index]['workingLab'].toString()),
                              SizedBox(
                                height: 10,
                              ),
                              Text("所用器具:"),
                              Text(standList[index]['toolsNeed']),
                              SizedBox(
                                height: 10,
                              ),
                            ],
                          ),
                        ),
                        actions: <Widget>[
                          FlatButton(
                            child: Text('确定'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            );
          }),
    );
  }
}
