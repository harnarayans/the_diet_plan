import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientDecoration {
  static BoxDecoration getDecoration () {
    return BoxDecoration(
      color: Color(0xffb3f5ff));
  }
  static BoxDecoration getLoginPageDecoration(){
    return BoxDecoration(
      borderRadius: BorderRadius.vertical(bottom:Radius.circular(20), top: Radius.zero),
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
        gradient: LinearGradient(
          colors: [Color(0XFF6a00f4), Color(0XFFf20089)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,)
    );
  }
  static BoxDecoration getButtonDecoration(){
    return BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 5.0, )],
        gradient: LinearGradient(
          colors: [Color(0XFF6a00f4), Color(0XFFf20089)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,),
        borderRadius: BorderRadius.circular(5.0),

    );
  }
  static Color getFontColor(){
    return Color(0xfffcfafa);
  }
  static Color getAppBarColor(){
    return Color(0XFF5e60ce);
  }
  static Color getBackGroundColor(){
    return Color(0xff56cfe1);
  }
  static Color getButtonTextColor(){
    return Color(0xff433c4d);
  }
  static Color getGraphBackgroundColor(){
    return Color(0xff3a86ff);
  }
  static Color getGraphContentColor(){
    return Color(0xFFFFEB3B);
  }
}
