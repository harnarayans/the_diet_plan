import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientDecoration {
  static BoxDecoration getDecoration () {
    return BoxDecoration(gradient: LinearGradient(
      colors: [Color(0XFFcca48f), Color(0xffffcdb2)],
      begin: Alignment.topRight,
      end: Alignment.bottomLeft,) );
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
}
