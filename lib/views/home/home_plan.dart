import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
class HomePlanPage extends StatefulWidget {
  @override
  _HomePlanPageState createState() => _HomePlanPageState();
}

class _HomePlanPageState extends State<HomePlanPage> {
  List planList = [];

  @override
  void initState() {
    super.initState();
    FutureDio('get', Api.prodPlan, {}).then((res) {
      print(res.data['data']);
      setState(() {
        planList = res.data['result']['records'];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: new Text("任务列表"),
        backgroundColor: Color(0xff3954A3),
      ),
      body: ListView.separated(
          itemCount: planList.length,
          separatorBuilder: (BuildContext context, int index) {
            return Divider(color: Colors.grey,height: 6,thickness: 2,);
          },
          itemBuilder: (context, index) {
            return InkWell(
              child: ListTile(
                leading: Text((index + 1).toString(),style: TextStyle(fontSize: 24,fontWeight: FontWeight.w600),),
                title: Text(planList[index]['planName']),
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
                              Text("计划名称:" + planList[index]['planName']),
                              SizedBox(
                                height: 10,
                              ),
                              Text("创建计划用户名:" + planList[index]['userName']),
                              SizedBox(
                                height: 10,
                              ),
                              Text("电力线名称:" + planList[index]['lineName']),
                              SizedBox(
                                height: 10,
                              ),
                              Text("停电设备范围:" + planList[index]['coverRange']),
                              SizedBox(
                                height: 10,
                              ),Text("工作开始时间:" + planList[index]['startDate']),
                              SizedBox(
                                height: 10,
                              ),Text("工作时长:" + planList[index]['workingTime'].toString()),
                              SizedBox(
                                height: 10,
                              ),Text("状态:" + planList[index]['planState_dictText']),
                              SizedBox(
                                height: 10,
                              ),Text("停电设备范围:" + planList[index]['coverRange']),
                              SizedBox(
                                height: 10,
                              ),
                              Text("工作内容:"),
                              Text(planList[index]['planContent']),
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
