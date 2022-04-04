import 'package:flutter/material.dart';
import '../views/index.dart';
import '../views/my/my_index.dart';
import '../views/home/home_index.dart';
import '../views/ground/ground_index.dart';
import '../views/message/message_index.dart';

import 'android_back_desktop.dart';

int schemeJumpTime = 0;
enum UniLinksType { string, uri }
// 底部tabbar
class BottomNavigationWidget extends StatefulWidget {
  final int pageIndex;
  final int index;
  @override
  BottomNavigationWidget({Key key, this.index = 0, this.pageIndex = 0})
      : super(key: key);

  State<StatefulWidget> createState() {
    return BottomNavigationWidgetState(this.index);
  }
}

class BottomNavigationWidgetState extends State<BottomNavigationWidget> {
  var name;
  int pageIndex = 0;
  int _currentIndex = 0;
  bool alreadyIn = false;
  BottomNavigationWidgetState(index) {
    this._currentIndex = index;
  }
  List _pageList = [Index(),GroundIndexPage(),MessageIndexPage(),MyPage()];


  @override
  void initState() {
    super.initState();
    this.pageIndex = widget.pageIndex;
    this._currentIndex = widget.index;
    // print(widget.pageIndex);
    // print('widget.pageIndex');
    // _pageList[1] = CourseIndexPage(
    //   pageIndex: pageIndex,
    // );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /*
    返回一个脚手架，里面包含两个属性，一个是底部导航栏，另一个就是主体内容
     */
    ///检测返回键
    return  WillPopScope(
        child: Scaffold(
          floatingActionButton: Container(
            height: 52,
            width: 52,
            margin: EdgeInsets.only(top: 14),
            padding: EdgeInsets.all(6),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: Colors.white,
//          渐变效果会出现黑糊糊的一团
//          gradient: LinearGradient(
//            begin: Alignment.topCenter,
//            end: Alignment.bottomCenter,
//            colors: [
//              Color(0xFFFBBF9D),
//              Color(0xFFFE6004),
//            ],
//          ),
            ),
            child: FloatingActionButton(
                backgroundColor: Color(0xff3954A3),
                // child: Container(
                //   height: 40,
                //   width: 40,
                //   decoration:  BoxDecoration(
                //     color: Colors.transparent,
                //     image:  DecorationImage(
                //         fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/book.png', scale: 5)),
                //   ),
                // ),
                child: Icon(Icons.add),
                onPressed: () {

                  Navigator.pushNamed(context, '/groundFormAct');
                  print('float');
                }),
          ),
          // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
          backgroundColor: Colors.white,
          body: this._pageList[this._currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            backgroundColor: Colors.white,
            //底部导航栏的创建需要对应的功能标签作为子项，这里我就写了4个，每个子项包含一个图标和一个title。
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                title:  Text(
                  '首页',
                  style: TextStyle(color: Color(_currentIndex == 0 ? 0xff3954A3 : 0xff000000)),
                ),
                backgroundColor: Colors.transparent,
                icon:  Container(
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(
                    color: Colors.transparent,
                    image:  DecorationImage(
                        fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/首页-off@3x.png', scale: 3.5)),
                  ),
                ),
                activeIcon:  Container(
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(
                    color: Colors.transparent,
                    image:  DecorationImage(
                        fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/首页-on@3x.png', scale: 2.3)),
                  ),
                ),
              ),

              BottomNavigationBarItem(
                title:  Text(
                  '操场',
                  style: TextStyle(color: Color(_currentIndex == 0 ? 0xff3954A3 : 0xff000000)),
                ),
                backgroundColor: Colors.transparent,
                icon:  Container(
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(
                    color: Colors.transparent,
                    image:  DecorationImage(
                        fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/论坛-off@3x.png', scale: 3.5)),
                  ),
                ),
                activeIcon:  Container(
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(
                    color: Colors.transparent,
                    image:  DecorationImage(
                        fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/论坛-on@3x.png', scale: 2.3)),
                  ),
                ),
              ),BottomNavigationBarItem(
                title:  Text(
                  '消息',
                  style: TextStyle(color: Color(_currentIndex == 0 ? 0xff3954A3 : 0xff000000)),
                ),
                backgroundColor: Colors.transparent,
                icon:  Container(
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(
                    color: Colors.transparent,
                    image:  DecorationImage(
                        fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/消息-off@3x.png', scale: 3.5)),
                  ),
                ),
                activeIcon:  Container(
                  height: 40,
                  width: 40,
                  decoration:  BoxDecoration(
                    color: Colors.transparent,
                    image:  DecorationImage(
                        fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/消息-on@3x.png', scale: 2.3)),
                  ),
                ),
              ),

              BottomNavigationBarItem(
                  backgroundColor: Colors.transparent,
                  icon:  Container(
                    height: 40,
                    width: 40,
                    decoration:  BoxDecoration(
                      color: Colors.transparent,
                      image:  DecorationImage(
                          fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/我的-off@3x.png', scale: 2.3)),
                    ),
                  ),
                  activeIcon:  Container(
                    height: 40,
                    width: 40,
                    decoration:  BoxDecoration(
                      color: Colors.transparent,
                      image:  DecorationImage(
                          fit: BoxFit.scaleDown, image: ExactAssetImage('assets/images/tabbar/我的-on@3x.png', scale: 2.3)),
                    ),
                  ),
                  title:  Text(
                    '我的',
                    style: TextStyle(color: Color(_currentIndex == 4 ? 0xff3954A3 : 0xff000000)),
                  )),
            ],
            //这是底部导航栏自带的位标属性，表示底部导航栏当前处于哪个导航标签。给他一个初始值0，也就是默认第一个标签页面。
            currentIndex: _currentIndex,
            //这是点击属性，会执行带有一个int值的回调函数，这个int值是系统自动返回的你点击的那个标签的位标
            onTap: (int i) {
              //进行状态更新，将系统返回的你点击的标签位标赋予当前位标属性，告诉系统当前要显示的导航标签被用户改变了。
              setState(() {
                _currentIndex = i;
              });
            },
          ),
        ),
        onWillPop: AndroidBackDesktop.backToDesktop);
  }
}
