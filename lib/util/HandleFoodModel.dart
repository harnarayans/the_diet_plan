import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/types/FoodItem.dart';

class HandleFoodModel{
    String email;
    HandleFoodModel(this.email);
    Future<int> updateSelectedFoodListToLocalModel(context) async{
      final dbReference = FirebaseFirestore.instance;
      Map<String, List<String>> selectedFoodList = {};
      int docsFound = 0;
      var document = dbReference
          .collection("foods")
          .where("userEmail", isEqualTo: email)
          .where("selection", isEqualTo: true)
          .orderBy("createdAt", descending: true)
          .limit(1);
      QuerySnapshot value = await document.get();
      if (value.docs.length > 0)
      {
        value.docs.forEach((element) {
          Map<String, dynamic> selectedFood =
          element.data().remove("selectedItems");
          selectedFood.forEach((key, value) {
            List<String> selectionList = value.cast<String>();
            selectedFoodList.putIfAbsent(key, () => selectionList);
          });
        });
        Provider.of<FoodModel>(context, listen: false)
            .setSelectedFoods(selectedFoodList);
        docsFound = 1;
      }
      return docsFound;
    }

    void updateConsumedFoodListToLocalModel(context) {
      final dbReference = FirebaseFirestore.instance;
      var document = dbReference
          .collection("foods")
          .where("userEmail", isEqualTo: email)
          .where("selection", isEqualTo: false)
          .orderBy("createdAt", descending: true)
          .limit(1);
      List<FoodItem> consumedFoodList = [];
      document.get().then((QuerySnapshot value) => {
        if (value.docs.length > 0)
          {
            value.docs.forEach((element) {
              List<dynamic> foodItems = element.data().remove("foodItems");
              if (foodItems != null && foodItems.length > 0) {
                consumedFoodList =
                    foodItems.map((e) => FoodItem.fromJson(e)).toList();
                Provider.of<FoodModel>(context, listen: false)
                    .setConsumedFoods(consumedFoodList);
              }
            })
          }
      });
    }

    Future<void> storeLocalModelToDB(context) async{
      final dbReference = FirebaseFirestore.instance;
      List<FoodItem> foodItems =
      Provider.of<FoodModel>(context, listen: false).getConsumedFoodList();
      List<Map> stringifiedItems = foodItems.map((e) => e.toJson()).toList();
      await dbReference
          .collection("foods")
          .add({
        'selection': false,
        'userEmail': email,
        'foodItems': stringifiedItems,
        'createdAt': DateTime.now()
      })
          .then((value) => {
        print("Successfully updated the DB with the consumed food items")
      })
          .catchError(
              (error) => {
            print("Failed to add food: ${error.toString()}"),
          });
    }
}