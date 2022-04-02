import 'package:flutter/material.dart';
import '../views/index.dart';
import '../views/home/home_plan.dart';
import '../views/home/home_standard.dart';
import '../views/my/my_index.dart';

import '../views/my/my_profile.dart';

import '../views/Tabs.dart';
import '../views/login.dart';



final routes = {
  '/': (context) => BottomNavigationWidget(),
  '/index': (context) => Index(),
  '/login': (context) => MainLoginPage(),
  '/myPage': (context) => MyPage(),
  '/homePlanPage': (context) => HomePlanPage(),
  '/homeStandardPage': (context) => HomeStandardPage(),
  // '/myRecordCoursePage': (context) => MyRecordCoursePage(),
  // '/myRecordVideoPage': (context) => MyRecordVideoPage(),
  //
  // '/studyDetailAllPage': (context) => StudyDetailAllPage(),
  // '/courseDetailPage': (context,{arguments}) => CourseDetailPage(arguments:arguments),
  // '/studyDetailOfflinePage': (context,{arguments}) => StudyDetailOfflinePage(arguments:arguments),
  // '/studyDetailVideoPage': (context,{arguments}) => StudyDetailVideoPage(arguments:arguments),


};

// ignore: top_level_function_literal_block
var onGenerateRoute = (RouteSettings settings){
  //统一处理
  final String name = settings.name;
  final Function pageContentBuilder = routes[name];
  if (pageContentBuilder != null) {
    if (settings.arguments != null) {
      final Route route = MaterialPageRoute(
          builder: (context) =>
              pageContentBuilder(context, arguments: settings.arguments));
      return route;
    } else {
      final Route route =
          MaterialPageRoute(builder: (context) => pageContentBuilder(context));
      return route;
    }
  }
  else return null;
};
