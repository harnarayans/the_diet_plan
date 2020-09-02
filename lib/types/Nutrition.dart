import 'package:convert/convert.dart';
import 'package:flutter/material.dart';

class Nutrition{
  String name;
  Color color;
  Nutrition(this.name, this.color);
  Map toJson(){
    return {
      'name': name,
      'color': color.toString()
    };
  }
  factory Nutrition.fromJson(json){
    List<String> colorCodeArr = json['color'].split('(');
    String colorCode = colorCodeArr.length>1?colorCodeArr[colorCodeArr.length-1].substring(0,10):"0x1e1e1e";
    return Nutrition(json['name'] as String, Color(int.parse(colorCode)));
  }
}