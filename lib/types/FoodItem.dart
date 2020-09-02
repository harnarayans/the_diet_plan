
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

  int compareTo(FoodItem item){
    if(this.name == item.name) return 0;
    else return(item.name.length - this.name.length);
  }
}

enum CaloryRating {
  High, Medium, Low
}