import 'package:flutter/foundation.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/types/FoodOtions.dart';

class FoodState extends ChangeNotifier{
  static Map<String,List<String>> foodSelections = {"Vitamin C":[],
    "Folate":[],
    "Vitamin B":[],
    "Vitamin D":[],
    "Iron":[],
    "Calcium":[],
    "Protein":[],
    "Good Fat":[],
    "Fiber":[]};

  static List<String> getSelectedItems(String nutrient){
    List<String> menuItems = FoodOptions.getFoodOptions()[nutrient];
    FoodState.foodSelections.forEach((key, value) {
      if(key != nutrient){
        for(var item in value){
          if(menuItems.contains(item)){
            FoodState.foodSelections[nutrient].add(item);
          }
        }
      }
    });
    return foodSelections[nutrient];
  }
}