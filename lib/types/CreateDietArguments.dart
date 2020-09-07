import 'package:thedietplan/types/FoodItem.dart';

class CreateDietArguments {
  final Map foodItems;
  final List<FoodItem> memberFoodItems;
  CreateDietArguments({this.memberFoodItems, this.foodItems});
}