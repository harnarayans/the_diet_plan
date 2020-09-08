import 'dart:collection';

import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:multiselectable_dropdown/multiselectable_dropdown.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/CustomWidgets/multi_select.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/types/CreateDietArguments.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/util/FoodProcessor.dart';


import 'LoginPageContent.dart';

class TrackFoodContent extends StatefulWidget {
  Map<String,List<String>> selectedFoods;
  TrackFoodContent(selectedItems){
    if(selectedItems!=null){
      selectedFoods = selectedItems;
    }else{
      selectedFoods={};
    }
  }
  @override
  _TrackFoodContentState createState() => _TrackFoodContentState();
}

class _TrackFoodContentState extends State<TrackFoodContent> {
  final dbReference = FirebaseFirestore.instance;
  final fp = FoodProcessor();

  List<MultipleSelectItem> elements = List.generate(
    15,
    (index) => MultipleSelectItem.build(
      value: index,
      display: '$index display',
      content: '$index content',
    ),
  );

  void trackDiet(email) async {
    Provider.of<FoodModel>(context,listen: false).setSelectedFoods(fp.getSelectedItems());
    await dbReference
        .collection("foods")
        .add({
          'selection': true,
          'userEmail': email,
          'selectedItems': fp.getSelectedItems(),
          'createdAt': DateTime.now()
        })
        .then((value) => {print('successfully updated the selected food list')})
        .catchError((error) => print("Failed to add food: $error"));
    Navigator.pushNamed(context, "/createDiet",
        arguments: CreateDietArguments(
            foodItems: fp.getSelectedItems(), memberFoodItems: []));
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: GradientDecoration.getDecoration(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 5),
                  child: Icon(
                    Icons.info_outline,
                    color: GradientDecoration.getButtonTextColor(),
                  ),
                ),
                Flexible(
                  child: Text(
                    "Select at least one food item from each nutritional category to prepare your diet chart",
                    style: TextStyle(fontSize: 16, color: GradientDecoration.getButtonTextColor()),
                  ),
                ),
              ],
            ),

            ClayContainer(
              emboss: true,
              color: GradientDecoration.getGraphBackgroundColor(),
              child: Container(
                height: 450,
                child: ListView(
                    scrollDirection: Axis.vertical, children: (fp.getItemList(widget.selectedFoods))),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            FlatButton(
              onPressed: () {
                String email = Provider.of<LoginModel>(context, listen: false).getUserEmail();
                trackDiet(email);
              },
              child: ClayContainer(
                color: GradientDecoration.getBackGroundColor(),
                depth: 30,
                child: Container(
                  child: Center(
                      child: Text(
                    "Prepare Your Diet Chart",
                    style: TextStyle(color: GradientDecoration.getButtonTextColor(), fontSize: 16),
                  )),
                  height: 50,
                  width: 300,
                ),
              ),
            ),
          ],
        ));
  }
}
