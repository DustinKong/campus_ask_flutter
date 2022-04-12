import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_baidu_mapapi_base/flutter_baidu_mapapi_base.dart';
import 'package:flutter_baidu_mapapi_map/flutter_baidu_mapapi_map.dart';
import 'package:flutter_baidu_mapapi_utils/flutter_baidu_mapapi_utils.dart';
import './routes/Routes.dart';
import './views/Tabs.dart';
import './views/api/SpUtil.dart';

void main() => realRunApp();

enum PlayType {
  network,
  asset,
  file,
  fileId,
}

class Router {
  static GlobalKey<NavigatorState> navigatorKey = GlobalKey();
}

///加载框样式
void configLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..progressColor = Colors.white
    ..indicatorColor = Colors.white
    ..textColor = Colors.white
    ..backgroundColor = Colors.black38;
  // ..indicatorType = EasyLoadingIndicatorType.cubeGrid;
}

void setCustomErrorPage() {
  ErrorWidget.builder = (FlutterErrorDetails flutterErrorDetails) {
    print(flutterErrorDetails.toString());
    return Center(
      child: Text("请重新加载"),
    );
  };
}

void realRunApp() async {
  ///使用第三方控件初始化之前 初始化
  WidgetsFlutterBinding.ensureInitialized();

  ///使缓存获取与写入同步
  bool success = await SpUtil.getInstance();
  print("init-" + success.toString());

  ///当组件报错的时候会出现红屏现象，解决办法是覆盖原有的ErrorWidget 用一个空白的组件去替换它
  // setCustomErrorPage();
  ///地图基本功能-注册高德key
  // await AmapService.init(androidKey: '948fd6bf41108dfe09180bfbc64e5328', iosKey: "1b84928ce79cd21b8c8c44272bd81454");
  /// 关闭高德log
//   await enableFluttifyLog(false);

  if(Platform.isIOS){
    BMFMapSDK.setApiKeyAndCoordType(
        '请输入百度开放平台申请的iOS端API KEY', BMF_COORD_TYPE.BD09LL);
  }else if(Platform.isAndroid){
// Android 目前不支持接口设置Apikey,
// 请在主工程的Manifest文件里设置，详细配置方法请参考[https://lbs.baidu.com/ 官网][https://lbs.baidu.com/)demo
    BMFMapSDK.setCoordType(BMF_COORD_TYPE.BD09LL);}

  ///获取用户设备信息
//  final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
//  Map<String, dynamic> deviceData;
  if (Platform.isAndroid) {
//    deviceData = _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
    ///设置手机类型是安卓
    SpUtil.preferences.setString("deviceType", "0");
  } else if (Platform.isIOS) {
//    deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
    ///设置手机类型是苹果
    SpUtil.preferences.setString("deviceType", "1");

//    getTemporaryDirectory().then((value){
//      print("save directory");
//      print(value);
//      SpUtil.preferences.setString("saveDirectory", value.toString());
//    });
  }
  // getTemporaryDirectory().then((value){
  //   print("save directory");
  //   print(value);
  //   print(value.path+"/videos");
  //   SpUtil.preferences.setString("saveDirectory", value.path+"/videos");
  //
  // });
//  print(deviceData);

  /// 状态栏颜色改变
  // if (Platform.isAndroid) {
  //   SystemUiOverlayStyle systemUiOverlayStyle = SystemUiOverlayStyle(statusBarColor: Color(0xff3954A3));
  //   SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
  // }

  /// 强制竖屏
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  ///用户token不存在
  // String token = SpUtil.preferences.getString('user_token');
  // if (token == null) {
  //   Future.delayed(Duration(milliseconds: 100)).then((e) {
  //     Router.navigatorKey.currentState.pushNamedAndRemoveUntil('/login', (route) => false);
  //   });
  // }
  configLoading();

  ///原始runApp
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        designSize: Size(360, 690),
        builder: () => MaterialApp(
              /// Flutter 中TextField的hintText不居中与光标位置不一致
              theme: ThemeData(textTheme: TextTheme(subtitle1: TextStyle(textBaseline: TextBaseline.alphabetic))),
              debugShowCheckedModeBanner: false,

              ///取消debug
              home: BottomNavigationWidget(),
              initialRoute: '/',

              ///登录页
              navigatorKey: Router.navigatorKey,

              /// 无Context跳转，处理登录失效
              onGenerateRoute: onGenerateRoute,

              /// 国际化
              localizationsDelegates: [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
              ],

              /// 显示中文
              supportedLocales: [
                const Locale('zh', 'CH'),
                const Locale('en', 'US'),
              ],
            ));
  }
}
