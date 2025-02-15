import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thedietplan/CustomWidgets/Chips.dart';
import 'package:thedietplan/CustomWidgets/DietProgressIndicator.dart';
import 'package:thedietplan/CustomWidgets/FoodTile.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/types/FoodOtions.dart';
import 'package:thedietplan/types/TrackFoodArgs.dart';
import 'package:thedietplan/util/HandleFoodModel.dart';
import 'package:thedietplan/util/NutrientColor.dart';

class CreateDietContent extends StatefulWidget {
  @override
  _CreateDietContentState createState() => _CreateDietContentState();
}

class _CreateDietContentState extends State<CreateDietContent> {
  bool isSuccessful = false;
  final dbReference = FirebaseFirestore.instance;
  List<String> foodList = [];
  int ingredientCount = 0;
  List<Color> consumedColors=[];

  void storeItems(context,email) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    HandleFoodModel handle = await HandleFoodModel(email,prefs: prefs);
    handle.saveConsumptionToLocalStorage(context);
    handle.saveSelectionToLocalStorage(context);
    handle.storeLocalModelToDB(context);
    Scaffold.of(context).showSnackBar(SnackBar(content: Text('Successfully updated the consumed food items'), backgroundColor: Colors.lightBlueAccent,));
    Navigator.of(context).popUntil(ModalRoute.withName("/home"));

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
          padding: const EdgeInsets.all(3.0),
          child: Draggable(
            affinity: Axis.vertical,
              axis:Axis.vertical,
              child: FoodTile(item),
              feedback: Chips(title: item.name),
              childWhenDragging: Container(),
              data: item),
        )
        );
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
        Provider.of<FoodModel>(context, listen: true).getConsumedFoodList();
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

  void navigateToTrackFood(context){
    Map<String,List<String>> foodItems = FoodOptions.getEmptyFoodOptions();
    List<FoodItem> selectedFoods = Provider.of<FoodModel>(context, listen: false).getSelectedFoodList();
    selectedFoods.forEach((element) {
      element.nutrients.forEach((element1) {
        foodItems[element1.name].add(element.name);
      });
    });
    Navigator.pushNamed(context, "/food", arguments: TrackFoodArgs(foodItems));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GradientDecoration.getDecoration(),
      padding: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Icon(
                    Icons.info_outline,
                    color: GradientDecoration.getButtonTextColor(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: Text(
                      "Nutrients Progress Indicator",
                      style: TextStyle( fontSize: 15, color: GradientDecoration.getButtonTextColor()),
                    ),
                  ),
                ],
              ),
              DietProgressIndicator(),
            ],
          ),
          SizedBox(height: 20,),
          ClayContainer(
            color: GradientDecoration.getGraphBackgroundColor(),
            depth: 30,
            emboss: true,
            child: SizedBox(
              height: 130,
              child: Scrollbar(
                child: ListView(
                  padding: EdgeInsets.all(5.0),
                  scrollDirection: Axis.horizontal,
                  children: getItemsLayout(context),
                ),
              ),
            ),
          ),
          SizedBox(height: 20,),
          ClayContainer(
            depth: 10,
            color: Color(0xfffad47d),
            child: Container(
              height: 280,
              margin: EdgeInsets.symmetric(vertical: 5),
              child: Stack(
                children: [
                  DragTarget(
                    builder:
                        (context, List<FoodItem> candidateData, rejectedData) {
                      return isSuccessful
                          ? Container(
                              child: SizedBox(
                                height: 400,
                                width: double.infinity,
                                child: Wrap(
                                  children: getSelectedItemsLayout(context),
                                ),
                              ),
                            )
                          : Container(
                              width: double.infinity,
                              height: 400,
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
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                            "Drag and drop here the food items you consumed today", style: TextStyle(color: GradientDecoration.getButtonTextColor()),),
                      ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 10,),
          FlatButton(
            onPressed: () {
              String email = Provider.of<LoginModel>(context, listen: false)
                  .getUserEmail();
              storeItems(context, email);
            },
            child: ClayContainer(
              color: GradientDecoration.getBackGroundColor(),
              depth: 40,
              height: 40,
              child: Center(
                  child: Text(
                "Record The Consumed Food Items",
                style: TextStyle(color: GradientDecoration.getButtonTextColor(), fontSize: 16),
              )),
            ),
          ),
          SizedBox(height: 10,),
          FlatButton(
            onPressed: () {
              navigateToTrackFood(context);
            },
            child: ClayContainer(
              color: GradientDecoration.getBackGroundColor(),
              depth: 40,
              height: 40,
              child: Center(
                  child: Text(
                    "Change The Selected Food Items",
                    style: TextStyle(color: GradientDecoration.getButtonTextColor(), fontSize: 16),
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
