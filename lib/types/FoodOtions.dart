
import 'package:thedietplan/util/NutrientColor.dart';

import 'FoodItem.dart';
import 'Nutrition.dart';

class FoodOptions{
  static final Map<String,List<String>> foodMap = {"Vitamin C":["Oranges","Kiwis","Guava","Broccoli","Tomato"],
    "Folate":["Legumes","Eggs","Spinach","Beetroot","Oranges","Nuts"],
    "Vitamin B":["Spinach","Meat","Eggs","Curd/Yogurt","Milk Prods"],
    "Vitamin D":["Sunlight","Cheese","Egg Yolk","Salmon"],
    "Iron":["Soybean","Lentils","Spinach","Tofu","Nuts","Raisins"],
    "Calcium":["Spinach","Soybeans","Curd/Yogurt", "Milk Prods", "Cheese", "Beans", "Lentils", "Almonds", "dark chocolate"],
    "Protein":["Legumes", "Eggs", "Chicken", "Nuts", "Grains", "Milk Prods"],
    "Good Fat":["Avocados", "Cheese", "Dark Chocolate", "Salmon", "Nuts", "Coconuts", "Curd/Yogurt"],
    "Fiber":["Spinach","Broccoli","Carrots", "Green Beans", "Lentils", "Coconut", "Coco water", "Kidney beans", "Oats", "Pear", "Apple", "Banana"]
  };

  static Map<String,List<String>> getFoodOptions(){
    return foodMap;
  }

  static Map<String,List<String>> getEmptyFoodOptions(){
    return {"Vitamin C":[],
      "Folate":[],
      "Vitamin B":[],
      "Vitamin D":[],
      "Iron":[],
      "Calcium":[],
      "Protein":[],
      "Good Fat":[],
      "Fiber":[]};
  }

  List<FoodItem> prepareFoodObjects(List<String> foodList){
    List<FoodItem> foodObjects = [];
    foodList.forEach((element) {
      List<Nutrition> nutrients = [];
      foodMap.forEach((key, value) {
        for(var item in value){
          if(value == element){
            nutrients.add(Nutrition(key,NutrientColor.getNutrientColor(key)));
          }
        }
      });
      foodObjects.add(FoodItem(element,nutrients, "Medium"));
    });
    return foodObjects;
  }
  
}