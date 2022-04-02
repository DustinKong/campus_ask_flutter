import 'package:shared_preferences/shared_preferences.dart';
class SpUtil{
  static SharedPreferences preferences;
  static Future<bool> getInstance() async{
    preferences = await SharedPreferences.getInstance();
    return true;
  }
}

//example
//SpUtil.preferences.getString('provinceName')
//SpUtil.preferences.setString('provinceCode', 'xxxx');