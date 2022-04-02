import 'package:flutter/material.dart';

class ColorsUtil {
  /// 十六进制颜色，
  /// hex, 十六进制值，例如：0xffffff,
  //  / alpha, 透明度 [0.0,1.0]
  static Color hexColor(int hex, {double alpha = 1}) {
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }

  static Color purple() {
    int hex = 0xA161FF;
    double alpha = 1;
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }

  static Color yellow() {
    int hex = 0xFEE100;
    double alpha = 1;
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }

  static Color orange() {
    int hex = 0xFEB708;
    double alpha = 1;
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }

  static Color blue() {
    int hex = 0x137FFE;
    double alpha = 1;
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }

  static Color deepPurple() {
    int hex = 0x6B2FE3;
    double alpha = 1;
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }

  static Color deepBlue() {
    int hex = 0x5635EA;
    double alpha = 1;
    return Color.fromRGBO((hex & 0xFF0000) >> 16, (hex & 0x00FF00) >> 8, (hex & 0x0000FF) >> 0, alpha);
  }
}

// 用法
// ColorsUtil.hexColor(0x3caafa)//透明度为1
// ColorsUtil.hexColor(0x3caafa,alpha: 0.5)//透明度为0.5
