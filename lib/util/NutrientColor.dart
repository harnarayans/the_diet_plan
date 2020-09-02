import 'package:flutter/material.dart';
class NutrientColor{
  static getNutrientColor(String nutrient){
    switch(nutrient){
      case "Vitamin C":
        return Colors.yellowAccent;
      case "Folate":
        return Colors.purpleAccent;
      case "Vitamin B":
        return Colors.greenAccent;
      case "Vitamin D":
        return Colors.orangeAccent;
      case "Iron":
        return Colors.brown;
      case "Calcium":
        return Colors.lightBlueAccent;
      case "Protein":
        return Colors.pinkAccent;
      case "Good Fat":
        return Colors.redAccent;
      case "Fiber":
        return Colors.tealAccent;
      default:
        return Colors.white70;
    }
  }

  static getRatingColor(String caloryRating) {
    switch(caloryRating){
      case "High":
        return Colors.redAccent;
      case "Medium":
        return Colors.yellowAccent;
      case "Low":
        return Colors.greenAccent;
    }
  }
}