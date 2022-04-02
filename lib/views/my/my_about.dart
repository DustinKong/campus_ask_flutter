import 'package:flutter/material.dart';
import 'package:package_info/package_info.dart';
import 'package:url_launcher/url_launcher.dart';

class MyAboutPage extends StatefulWidget {
  @override
  _MyAboutPageState createState() => _MyAboutPageState();
}

class _MyAboutPageState extends State<MyAboutPage> {
  var systemInfo;
  String appName;
  String packageName;
  String version;
  String buildNumber;
  @override
  void initState() {
    super.initState();
    print('ini');
    getInfo();
//     FutureDio('get', Api.FindSysinfo, {}).then((res) {
// //      print(res);
//       print(res.data);
//       if (res.data['code'] == 0) if (mounted)
//         setState(() {
//           systemInfo = res.data['data'];
//         });
//     });
  }

  Future<void> getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();

    appName = packageInfo.appName;
    packageName = packageInfo.packageName;
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
  }

  bool isagree = true;
  _launchagreeURL() async {
    const url = 'https://api.udianle.com/udl/agree.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchprivateURL() async {
    const url = 'https://api.udianle.com/udl/private.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  _launchdismissURL() async {
    const url = 'https://api.udianle.com/udl/dismiss.html';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          centerTitle: true,
          title: new Text("关于校园问问"),
          backgroundColor: Color(0xff3954A3),
        ),
        body: Column(
          children: <Widget>[
            SizedBox(
              height: 40,
            ),
            Center(child: Image.asset('assets/images/logo.png',height: 140,width: 140,),),
            SizedBox(
              height: 10,
            ),
            Text("V 1.0.0"),
            SizedBox(
              height: 10,
            ),
            Text(
              "专注企业培训",
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            // Text(
            //   "校园问问专注于中小企业企业培训市场致力于打造培训需求方（企业用户）与培训供给方（培训机构）之间的培训交易与管理平台，成为连接供需双方最便捷的通道与桥梁。做最值得中小企业信赖的企业培训平台。",
            //   style: TextStyle(fontSize: 16),
            // ),
            SizedBox(
              height: 40,
            ),
            Padding(padding: EdgeInsets.all(40),child: Text("校园问问专注于中小企业企业培训市场致力于打造培训需求方（企业用户）与培训供给方（培训机构）之间的培训交易与管理平台，成为连接供需双方最便捷的通道与桥梁。做最值得中小企业信赖的企业培训平台。"),)
            // Center(
            //   child: CachedNetworkImage(
            //     fit: BoxFit.cover,
            //     height: 120,
            //     width: 120,
            //     imageUrl: systemInfo['recommAndr'],
            //   ),
            // ),
            // SizedBox(
            //   height: 10,
            // ),
            // Text(
            //   systemInfo['recommTips'],
            //   style: TextStyle( fontSize: 16),
            // ),

            // SizedBox(
            //   height: 40,
            // ),
            // Container(
            //     height: 20,
            //     child: FlatButton(
            //       child: Text(
            //         '《用户协议》',
            //         style: TextStyle(fontSize: 11, color: Color(0xFF5C7CFF)),
            //       ),
            //       onPressed: () {
            //         print('agree1');
            //         _launchagreeURL();
            //       },
            //     )),
            // SizedBox(
            //   height: 15,
            // ),
            // Container(
            //     height: 20,
            //     child: FlatButton(
            //       child: Text(
            //         '《隐私协议》',
            //         style: TextStyle(fontSize: 11, color: Color(0xFF5C7CFF)),
            //       ),
            //       onPressed: () {
            //         print('agree2');
            //         _launchprivateURL();
            //       },
            //     )),
            // SizedBox(
            //   height: 15,
            // ),
            // Container(
            //     height: 20,
            //     child: FlatButton(
            //       child: Text(
            //         '《注销协议》',
            //         style: TextStyle(fontSize: 11, color: Color(0xFF5C7CFF)),
            //       ),
            //       onPressed: () {
            //         print('agree3');
            //         _launchdismissURL();
            //       },
            //     )),
          ],
        ));
  }
}
