import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GradientDecoration {
  static BoxDecoration getDecoration () {
    return BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 10)],
        gradient: LinearGradient(
          colors: [Color(0XFF7668BF), Color(0XFFD569A8)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,)
    );
  }
  static BoxDecoration getButtonDecoration(){
    return BoxDecoration(
        boxShadow: [BoxShadow(color: Colors.blue, blurRadius: 5.0, )],
        gradient: LinearGradient(
          colors: [Color(0XFF7668BF), Color(0XFFD569A8)],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,),
        borderRadius: BorderRadius.circular(5.0),

    );
  }
}
