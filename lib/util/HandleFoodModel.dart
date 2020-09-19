import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/types/FoodItem.dart';

class HandleFoodModel {
  String email;
  SharedPreferences prefs;
  HandleFoodModel(this.email, {this.prefs});
  final dbReference = FirebaseFirestore.instance;

  void updateLocalModel(context) async {
    var selectionReference = FirebaseDatabase.instance
        .reference()
        .child('selection_indicator')
        .child("user");
    bool selected = false;
    Map<dynamic, dynamic> jsonTree = {};
    await selectionReference.once().then((DataSnapshot snap) => {
          if (snap.value != null)
            {
              jsonTree = snap.value as Map<dynamic,dynamic>,
              jsonTree.forEach((key, value) {
                if (value["email"] == email && value["selected"] == true) {
                  selected = true;
                }
              }),
            }
        });
    print(selected);
    if (selected == true) {
      if (prefs.getString("selectedItems") != null &&
          prefs.getString("selectedItems").length > 0) {
        updateModelFromLocalStorage(context);
      } else {
        updateSelectionFromDBStorage(context);
        updateConsumptionFromDBStorage(context);
      }
    }
  }

  void updateModelFromLocalStorage(context) {
    String selectedStr = prefs.getString("selectedItems");
    String consumedItemsStr = prefs.getString("consumedItems");

    List<Map> selectedList = List<Map>.from(jsonDecode(selectedStr));
    List<FoodItem> selectedItemsList =
        selectedList.map((e) => FoodItem.fromJson(e)).toList();

    Provider.of<FoodModel>(context, listen: false)
        .setSelectedFoodList(selectedItemsList);

    List<Map> consumedList = List<Map>.from(jsonDecode(consumedItemsStr));
    List<FoodItem> consumedItemsList =
        consumedList.map((e) => FoodItem.fromJson(e)).toList();
    Provider.of<FoodModel>(context, listen: false)
        .setConsumedFoods(consumedItemsList);
  }

  void updateSelectionFromDBStorage(context) async {
    List<FoodItem> selectedFoods =
        Provider.of<FoodModel>(context, listen: false).getSelectedFoodList();

    Map<String, List<String>> selectedFoodList = {};
    int docsFound = 0;
    var document = dbReference
        .collection("foods")
        .where("userEmail", isEqualTo: email)
        .where("selection", isEqualTo: true)
        .orderBy("createdAt", descending: true)
        .limit(1);
    QuerySnapshot value = await document.get();
    if (value.docs.length > 0) {
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
      saveSelectionToLocalStorage(context);
    }
  }

  void saveSelectionToLocalStorage(context) {
    List<FoodItem> selectedFoods =
        Provider.of<FoodModel>(context, listen: false).getSelectedFoodList();
    List<Map> items = selectedFoods.map((e) => e.toJson()).toList();
    prefs.setString("selectedItems", jsonEncode(items));
  }

  void updateConsumptionFromDBStorage(context) async {
    if (prefs == null) {
      prefs = await SharedPreferences.getInstance();
    }
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
                  saveConsumptionToLocalStorage(context);
                }
              })
            }
        });
  }

  void saveConsumptionToLocalStorage(context) {
    List<FoodItem> consumedFoods =
        Provider.of<FoodModel>(context, listen: false).getConsumedFoodList();
    List<Map> items = consumedFoods.map((e) => e.toJson()).toList();
    prefs.setString("consumedItems", jsonEncode(items));
  }

  Future<void> storeLocalModelToDB(context) async {
    final dbReference = FirebaseFirestore.instance;

    List<FoodItem> selectedItems =
        Provider.of<FoodModel>(context, listen: false).getConsumedFoodList();
    List<Map> selectedItemsStr = selectedItems.map((e) => e.toJson()).toList();
    await dbReference
        .collection("foods")
        .add({
          'selection': false,
          'userEmail': email,
          'foodItems': selectedItemsStr,
          'createdAt': DateTime.now()
        })
        .then((value) =>
            {print("Successfully updated the DB with the consumed food items")})
        .catchError((error) => {
              print("Failed to add food: ${error.toString()}"),
            });

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
        .then((value) =>
            {print("Successfully updated the DB with the consumed food items")})
        .catchError((error) => {
              print("Failed to add food: ${error.toString()}"),
            });
  }
}
