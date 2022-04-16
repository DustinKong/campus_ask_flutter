import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:amap_flutter_map/amap_flutter_map.dart';
import 'package:amap_flutter_base/amap_flutter_base.dart';
import 'package:permission_handler/permission_handler.dart';
import '../mapUtil/const_config.dart';
import '../api/ColorUtil.dart';
import '../api/LogUtil.dart';
import '../api/api.dart';
import '../api/SpUtil.dart';
import '../api/FutureDioToken.dart';
import '../api/LogUtil.dart';

class HomeMapPage extends StatefulWidget {
  @override
  _HomeMapPageState createState() => _HomeMapPageState();
}

class _HomeMapPageState extends State<HomeMapPage> {
  var _futureBuilderFuture;
  // Future _gerData() async {
  //   var response = HttpUtil()
  //       .get('http://api.douban.com/v2/movie/top250', data: {'count': 15});
  //   return response;
  // }
  Future _getData;
  var showList = [
    {
      "pic": "assets/images/home/位置聊天@2x.png",
      "title": "计算机与信息工程学院",
      "subtitle": "这是关于计算机与信息工程学院的介绍",
      "trail": "assets/images/home/array.png"
    },
    {
      "pic": "assets/images/home/位置聊天@2x.png",
      "title": "计算机与信息工程学院",
      "subtitle": "这是关于计算机与信息工程学院的介绍",
      "trail": "assets/images/home/array.png"
    },
    {
      "pic": "assets/images/home/位置聊天@2x.png",
      "title": "计算机与信息工程学院",
      "subtitle": "这是关于计算机与信息工程学院的介绍",
      "trail": "assets/images/home/array.png"
    },
    {
      "pic": "assets/images/home/位置聊天@2x.png",
      "title": "计算机与信息工程学院",
      "subtitle": "这是关于计算机与信息工程学院的介绍",
      "trail": "assets/images/home/array.png"
    },
  ];
  int type = 1;
  void _requestLocaitonPermission() async {
    PermissionStatus status = await Permission.location.request();
    print('permissionStatus=====> $status');
  }

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(30.30988, 120.38949),
    zoom: 15.0,
  );

  ///自定义定位小蓝点
  MyLocationStyleOptions _myLocationStyleOptions = MyLocationStyleOptions(false);

  ///是否显示比例尺
  bool _scaleEnabled = true;

  ///是否支持缩放手势
  bool _zoomGesturesEnabled = true;

  ///是否支持滑动手势
  bool _scrollGesturesEnabled = true;

  ///是否支持旋转手势
  bool _rotateGesturesEnabled = true;

  ///是否支持倾斜手势
  bool _tiltGesturesEnabled = true;
  static final LatLng mapCenter = const LatLng(30.30988, 120.38949);
  final Map<String, Marker> _initMarkerMap = <String, Marker>{};

  @override
  void initState() {
    _requestLocaitonPermission();
    super.initState();
    // _futureBuilderFuture = _getData;
    // LogUtil.init(title: "来自LogUtil",limitLength:800)
  }

  @override
  Widget build(BuildContext context) {
    for (int i = 0; i < 10; i++) {
      LatLng position =
          LatLng(mapCenter.latitude + sin(i * pi / 12.0) / 20.0, mapCenter.longitude + cos(i * pi / 12.0) / 20.0);
      Marker marker = Marker(position: position);
      _initMarkerMap[marker.id] = marker;
    }
    final AMapWidget amap = AMapWidget(
      privacyStatement: ConstConfig.amapPrivacyStatement,
      apiKey: ConstConfig.amapApiKeys,
      initialCameraPosition: _kInitialPosition,
      myLocationStyleOptions: _myLocationStyleOptions,
      zoomGesturesEnabled: _zoomGesturesEnabled,
      scaleEnabled: _scaleEnabled,
      rotateGesturesEnabled: _rotateGesturesEnabled,
      scrollGesturesEnabled: _scrollGesturesEnabled,
      tiltGesturesEnabled: _tiltGesturesEnabled,
      markers: Set<Marker>.of(_initMarkerMap.values),
    );
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
            "地图",
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800),
          ),
          backgroundColor: Colors.white,
        ),
        body: ListView(
          children: [
            Container(
              child: amap,
              height: 330.h,
              width: 360.w,
            ),
            Container(
              height: 60.h,
              padding: EdgeInsets.all(15),
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  InkWell(
                    child: Column(
                      children: [
                        Text(
                          "教学楼",
                          style: TextStyle(
                              fontWeight: type == 1 ? FontWeight.w600 : FontWeight.w400, fontSize: type == 1 ? 18 : 16),
                        ),
                        Container(
                          color: type == 1 ? Colors.orange : ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                          height: 3,
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      if (type != 1) {
                        setState(() {
                          type = 1;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Text(
                          "景点",
                          style: TextStyle(
                              fontWeight: type == 2 ? FontWeight.w600 : FontWeight.w400, fontSize: type == 2 ? 18 : 16),
                        ),
                        Container(
                          color: type == 2 ? Colors.orange : ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                          height: 3,
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      if (type != 2) {
                        setState(() {
                          type = 2;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Text(
                          "校门",
                          style: TextStyle(
                              fontWeight: type == 3 ? FontWeight.w600 : FontWeight.w400, fontSize: type == 3 ? 18 : 16),
                        ),
                        Container(
                          color: type == 3 ? Colors.orange : ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                          height: 3,
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      if (type != 3) {
                        setState(() {
                          type = 3;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Text(
                          "餐厅超市",
                          style: TextStyle(
                              fontWeight: type == 4 ? FontWeight.w600 : FontWeight.w400, fontSize: type == 4 ? 18 : 16),
                        ),
                        Container(
                          color: type == 4 ? Colors.orange : ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                          height: 3,
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      if (type != 4) {
                        setState(() {
                          type = 4;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Text(
                          "宿舍楼",
                          style: TextStyle(
                              fontWeight: type == 5 ? FontWeight.w600 : FontWeight.w400, fontSize: type == 5 ? 18 : 16),
                        ),
                        Container(
                          color: type == 5 ? Colors.orange : ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                          height: 3,
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      if (type != 5) {
                        setState(() {
                          type = 5;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    child: Column(
                      children: [
                        Text(
                          "生活",
                          style: TextStyle(
                              fontWeight: type == 6 ? FontWeight.w600 : FontWeight.w400, fontSize: type == 6 ? 18 : 16),
                        ),
                        Container(
                          color: type == 6 ? Colors.orange : ColorsUtil.hexColor(0xD8D8D8, alpha: 0.4),
                          height: 3,
                          width: 50,
                        )
                      ],
                    ),
                    onTap: () {
                      if (type != 6) {
                        setState(() {
                          type = 6;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 220.h,
              child: ListView.builder(
                  itemCount: showList.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: Image.asset(
                        showList[index]['pic'],
                        width: 50.w,
                        height: 50.h,
                      ),
                      trailing: Image.asset(
                        showList[index]['trail'],
                        width: 50.w,
                        height: 50.h,
                      ),
                      title: Text(
                        showList[index]['title'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        showList[index]['subtitle'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
