import 'package:flutter/cupertino.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/types/Nutrition.dart';
import 'package:thedietplan/util/NutrientColor.dart';


class FoodModel extends ChangeNotifier{
  Set<FoodItem> selectedFoodList;
  Set<FoodItem> consumedFoodList;
  FoodModel(){
    selectedFoodList={};
    consumedFoodList={};
  }

  void setSelectedFoods(Map<String,List<String>> foodMap){
    foodMap.forEach((key, value) { 
      for(var item in value){
        Set<Nutrition> nutrients={};
        foodMap.forEach((key1, value1) {
          if(value1.contains(item)){
            nutrients.add(Nutrition(key,NutrientColor.getNutrientColor(key)));
          }
        });
        selectedFoodList.add(FoodItem( item,nutrients.toList(),"Medium"));
      }
    });
  }

  void setConsumedFoods(List<FoodItem> foodsList){
    consumedFoodList = {};
    consumedFoodList.addAll(foodsList);
    foodsList.forEach((element) {
      if(selectedFoodList.contains(element)){
        selectedFoodList.remove(element);
      }
    });
//    Map<String,List<String>> foodMap = FoodOptions.getFoodOptions();
//    foodsList.forEach((element) {
//      Set<Nutrition> nutrients={};
//      foodMap.forEach((key, value) {
//        if(value.contains(element)){
//          nutrients.add(Nutrition(key,NutrientColor.getNutrientColor(key)));
//        }
//      });
//      consumedFoodList.add(FoodItem( element,nutrients.toList()));
//    });
  }

  List<FoodItem> getSelectedFoodList(){
    return selectedFoodList.toList();
  }

  List<FoodItem> getConsumedFoodList(){
    return consumedFoodList.toList();
  }

  void consumeFood(FoodItem foodItem){
    consumedFoodList.add(foodItem);
    selectedFoodList.remove(foodItem);
    notifyListeners();
  }

  List<Nutrition> getSelectedNutrients(){
    Set<Nutrition> nutrients = {};
    for(var item in selectedFoodList){
      nutrients.addAll(item.nutrients);
    }
    return nutrients.toList();
  }
  List<Nutrition> getConsumedNutrients(){
    Set<Nutrition> nutrients = {};
    for(var item in consumedFoodList){
      nutrients.addAll(item.nutrients);
    }
    return nutrients.toList();
  }
}