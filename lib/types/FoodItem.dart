
import 'dart:convert';

import 'Nutrition.dart';

class FoodItem{
  String name;
  List<Nutrition> nutrients;
  String caloryRating;
  FoodItem(this.name, this.nutrients, this.caloryRating);
  Map toJson()=>{
    'name': name,
    'nutrients':nutrients.map((e) => e.toJson()).toList(),
    'caloryRating': caloryRating.toString()
  };
  factory FoodItem.fromJson(dynamic json){
    List<dynamic> nutrients = json['nutrients'];
    List<Nutrition> nutrientList=[];
    nutrients.forEach((element) {
      nutrientList.add(Nutrition.fromJson(element));
    });
    return FoodItem(json['name'] as String, nutrientList, json['caloryRating'] as String);
  }

  bool operator ==(o) => o is FoodItem && o.name == name;

  @override
  // TODO: implement hashCode
  int get hashCode => super.hashCode;
}

enum CaloryRating {
  High, Medium, Low
}