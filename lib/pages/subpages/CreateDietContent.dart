import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:thedietplan/CustomWidgets/Chips.dart';
import 'package:thedietplan/CustomWidgets/DietProgressIndicator.dart';
import 'package:thedietplan/CustomWidgets/FoodTile.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/Pages/TrackFood.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/util/NutrientColor.dart';

class CreateDietContent extends StatefulWidget {
  List<FoodItem> memberFoodList;
  final foodItems;
  CreateDietContent({this.memberFoodList, this.foodItems});
  @override
  _CreateDietContentState createState() => _CreateDietContentState();
}

class _CreateDietContentState extends State<CreateDietContent> {
  bool isSuccessful = false;
  final dbReference = FirebaseFirestore.instance;
  List<String> foodList = [];
  int ingredientCount = 0;

  void storeItems(email) async {
    List<FoodItem> foodItems =
        Provider.of<FoodModel>(context, listen: false).getConsumedFoodList();
    List<Map> stringifiedItems = foodItems.map((e) => e.toJson()).toList();
    await dbReference
        .collection("foods")
        .add({
          'selection': false,
          'userEmail': email,
          'foodItems': stringifiedItems,
          'createdAt': DateFormat.yMMMd().format(DateTime.now())
        })
        .then((value) => {
        Scaffold.of(context).showSnackBar(SnackBar(content: Text('Successfully updated the consumed food items'), backgroundColor: Colors.lightBlueAccent,))})
        .catchError(
            (error) => print("Failed to add food: ${error.toString()}"));
  }

  List<Widget> getItemsLayout(context) {
    List<FoodItem> selectedFoods =
        Provider.of<FoodModel>(context, listen: true).getSelectedFoodList();
    List<FoodItem> consumedFoods =
        Provider.of<FoodModel>(context, listen: true).getConsumedFoodList();
    if (consumedFoods.length > 0) {
      isSuccessful = true;
    }
    if (selectedFoods == null) selectedFoods = [];
    int count = 0;
    List<Widget> temp = [];
    selectedFoods = removeDuplicates(selectedFoods);
    for (var item in selectedFoods) {
      if (!consumedFoods.contains(item))
        temp.add(Padding(
            padding: const EdgeInsets.all(12.0),
            child: Draggable(
                axis:Axis.vertical,
                child: FoodTile(item),
                feedback: Chips(title: item.name),
                childWhenDragging: Container(),
                data: item)));
    }
    return temp;
  }

  List<FoodItem> removeDuplicates(List<FoodItem> foodList){
    List<String> uniqueNames =[];
    List<FoodItem> unique=[];
    foodList.forEach((element) {
      if(!uniqueNames.contains(element.name)){
        uniqueNames.add(element.name);
        unique.add(element);
      }
    });
    return unique;
  }

  List<Widget> getSelectedItemsLayout(context) {
    List<FoodItem> consumedFoods =
        Provider.of<FoodModel>(context, listen: false).getConsumedFoodList();
    if (consumedFoods == null) consumedFoods = [];
    if (consumedFoods.length > 0) {
      isSuccessful = true;
    }
    int count = 0;
    List<Widget> temp = [];
    List<Widget> layout = [];
    for (var item in consumedFoods) {
      temp.add(Chips(title: item.name));
    }
    return temp;
  }

  List<Color> getNutrientColors() {
    List<Color> nutrientColors = [];
    Provider.of<FoodModel>(context).getConsumedNutrients().forEach((element) {
      nutrientColors.add(NutrientColor.getNutrientColor(element.name));
    });
    return nutrientColors;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff1e1e1e),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Row(
            children: <Widget>[
              Icon(
                Icons.info_outline,
                color: Colors.white70,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: Text(
                  "Nutrients Progress Indicator",
                  style: TextStyle(color: Colors.white70),
                ),
              ),
            ],
          ),
          DietProgressIndicator(ingredientCount, getNutrientColors()),
          Container(
            decoration: GradientDecoration.getDecoration(),
            child: SizedBox(
              height: 200,
              child: Scrollbar(
                child: ListView(
                  padding: EdgeInsets.all(5.0),
                  scrollDirection: Axis.horizontal,
                  children: getItemsLayout(context),
                ),
              ),
            ),
          ),
          Container(
            height: 300,
            margin: EdgeInsets.symmetric(vertical: 5),
            decoration: GradientDecoration.getDecoration(),
            child: Stack(
              children: [
                DragTarget(
                  builder:
                      (context, List<FoodItem> candidateData, rejectedData) {
                    return isSuccessful
                        ? Container(
                            child: SizedBox(
                              height: 500,
                              width: double.infinity,
                              child: Wrap(
                                children: getSelectedItemsLayout(context),
                              ),
                            ),
                          )
                        : Container(
                            width: double.infinity,
                            height: 500,
                            color: Colors.white70,
                          );
                  },
                  onWillAccept: (data) {
                    return true;
                  },
                  onAccept: (FoodItem item) {
                    FoodModel fm =
                        Provider.of<FoodModel>(context, listen: false);
                    fm.consumeFood(item);
                    isSuccessful = true;
                  },
                ),
                Center(
                    child: Text(
                        "Drag and drop here the food items you consumed today")),
              ],
            ),
          ),
          FlatButton(
            onPressed: () {
              String email = Provider.of<LoginModel>(context, listen: false)
                  .getUserEmail();
              storeItems(email);
            },
            child: Container(
              child: Center(
                  child: Text(
                "Record your diet",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              )),
              height: 40,
              width: 250,
              decoration: GradientDecoration.getButtonDecoration(),
            ),
          ),
          FlatButton(
            onPressed: () {
              Navigator.pushNamed(context, "/food", arguments: TrackFoodArgs(widget.foodItems));
            },
            child: Container(
              child: Center(
                  child: Text(
                    "Change the selection",
                    style: TextStyle(color: Colors.white70, fontSize: 16),
                  )),
              height: 40,
              width: 250,
              decoration: GradientDecoration.getButtonDecoration(),
            ),
          ),
        ],
      ),
    );
  }
}
