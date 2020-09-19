import 'package:flutter/cupertino.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/types/FoodOtions.dart';
import 'package:thedietplan/types/Nutrition.dart';
import 'package:thedietplan/util/NutrientColor.dart';


class FoodModel extends ChangeNotifier{
  Set<FoodItem> selectedFoodList;
  Set<FoodItem> consumedFoodList;
  FoodModel(){
    selectedFoodList={};
    consumedFoodList={};
  }

  void revertConsumption(String foodItem){
    selectedFoodList.addAll(consumedFoodList.where((element) => element.name == foodItem));
    consumedFoodList.removeWhere((element) => element.name == foodItem);
    notifyListeners();
  }
  void setSelectedFoods(Map<String,List<String>> foodMap){
    foodMap.forEach((key, value) { 
      for(var item in value){
        Set<Nutrition> nutrients={};
        FoodOptions.getFoodOptions().forEach((key1, value1) {
          if(value1.contains(item)){
            nutrients.add(Nutrition(key1,NutrientColor.getNutrientColor(key1)));
          }
        });
        selectedFoodList.add(FoodItem( item,nutrients.toList(),"Medium"));
      }
    });
    notifyListeners();
  }

  void setSelectedFoodList(List<FoodItem> foodsList){
    selectedFoodList = {};
    consumedFoodList.addAll(foodsList);
    notifyListeners();
  }

  void setConsumedFoods(List<FoodItem> foodsList){
    consumedFoodList = {};
    consumedFoodList.addAll(foodsList);
    foodsList.forEach((element) {
      if(selectedFoodList.contains(element)){
        selectedFoodList.remove(element);
      }
    });
    notifyListeners();
  }

  List<FoodItem> getSelectedFoodList(){
    return selectedFoodList.toList();
  }

  List<FoodItem> getConsumedFoodList(){
    return consumedFoodList.toList();
  }

  void consumeFood(FoodItem foodItem){
    if(!consumedFoodList.contains(foodItem))
    consumedFoodList.add(foodItem);
    selectedFoodList.remove(foodItem);
    notifyListeners();
  }

  List<Nutrition> getSelectedNutrients(){
    Set<String> nutrients = {};
    List<Nutrition> nutriList=[];
    for(var item in selectedFoodList){
      item.nutrients.forEach((element) {
        if(!nutrients.contains(element.name)){
          nutrients.add(element.name);
          nutriList.add(element);
        }
      });
    }
    return nutriList;
  }

  List<Nutrition> getConsumedNutrients(){
    Set<String> nutrients = {};
    List<Nutrition> nutriList=[];
    for(var item in consumedFoodList){
      item.nutrients.forEach((element) {
        if(!nutrients.contains(element.name)){
          nutrients.add(element.name);
          nutriList.add(element);
        }
      });
    }
    return nutriList;
  }
}