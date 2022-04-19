import 'dart:ffi';

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
  var num=0;
  int type = 1;
  void _requestLocaitonPermission() async {
    PermissionStatus status = await Permission.location.request();
    print('permissionStatus=====> $status');
  }

  static final CameraPosition _kInitialPosition = const CameraPosition(
    target: LatLng(30.30988, 120.38949),
    zoom: 16.0,
  );
  ///自定义定位小蓝点
  MyLocationStyleOptions _myLocationStyleOptions = MyLocationStyleOptions(true);
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

  var marks=new List();
  var sumLoc=new List();
  AMapController _controller;
  void _onMapCreated(AMapController controller) {
    _controller = controller;
  }
  @override
  void initState() {
    _requestLocaitonPermission();
    super.initState();
    // _futureBuilderFuture = _getData;
    // LogUtil.init(title: "来自LogUtil",limitLength:800)
    FutureDio('get', Api.GetAllBuildingInfoController,{} ).then((res){
      for(int k=0;k<6;k++){
        final Map<String, Marker> _initMarkerMap = <String, Marker>{};
        var tmp=res.data['data'][k]['singleBuildingData'];
        var tmpB=new List();
        print("yyy");
        LogUtil.d(tmp);
        for(int i=0;i<tmp.length;i++){
          Map tmpA =Map();
          LatLng position = LatLng(tmp[i]['latitude'],tmp[i]['longitude']);
          _initMarkerMap[tmp[i]['title']]= Marker(position: position,icon:BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueOrange));
          tmpA['title']=tmp[i]['title'];
          tmpA['img']=tmp[i]['img'][0];
          tmpA['description']=tmp[i]['description'];
          tmpA['buildingMapIcon']=tmp[i]['buildingMapIcon'];
          tmpA['latitude']=tmp[i]['latitude'];
          tmpA['longitude']=tmp[i]['longitude'];
          tmpB.add(tmpA);
        }
        setState(() {
          sumLoc.add(tmpB);
          marks.add(_initMarkerMap);
        });
      }
      LogUtil.d(sumLoc);
    });
  }

  @override
  Widget build(BuildContext context) {
    final AMapWidget amap = AMapWidget(
      onMapCreated: _onMapCreated,
      privacyStatement: ConstConfig.amapPrivacyStatement,
      apiKey: ConstConfig.amapApiKeys,
      initialCameraPosition: _kInitialPosition,
      myLocationStyleOptions: _myLocationStyleOptions,
      zoomGesturesEnabled: _zoomGesturesEnabled,
      scaleEnabled: _scaleEnabled,
      rotateGesturesEnabled: _rotateGesturesEnabled,
      scrollGesturesEnabled: _scrollGesturesEnabled,
      tiltGesturesEnabled: _tiltGesturesEnabled,
      markers: Set<Marker>.of(marks[num].values),
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
              height: 350.h,
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
                          num=0;
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
                          num=1;
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
                          num=2;
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
                          num=3;
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
                          num=4;
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
                          num=5;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
            Container(
              height: 200.h,
              child: ListView.builder(
                  itemCount: sumLoc[num].length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      onTap: (){
                        _controller?.moveCamera(CameraUpdate.newCameraPosition(CameraPosition(
                            target: LatLng(sumLoc[num][index]['latitude'],sumLoc[num][index]['longitude']),
                            zoom: 18,
                            tilt: 30,
                            bearing: 0)));
                      },
                      leading:CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 40,
                        width: 40,
                        imageUrl: sumLoc[num][index]['buildingMapIcon'],
                      ),
                      trailing: CachedNetworkImage(
                        fit: BoxFit.fill,
                        height: 50.h,
                        width: 60.w,
                        imageUrl: sumLoc[num][index]['img'],
                      ),
                      title: Text(
                        sumLoc[num][index]['title'],
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      subtitle: Text(
                        sumLoc[num][index]['description'],
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
                      ),
                    );
                  }),
            )
          ],
        ));
  }
}
