import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/CustomWidgets/BarChart1.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/CustomWidgets/PieChart1.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/types/TrackFoodArgs.dart';
import 'package:thedietplan/util/HandleFoodModel.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final dbReference = FirebaseFirestore.instance;

  void navigateToFoodTracking(context) async {
    List<String> memberFoods = [];
    bool navigationCompleted = false;
    String email =
        Provider.of<LoginModel>(context, listen: false).getUserEmail();
    List<FoodItem> selectedItems =
        Provider.of<FoodModel>(context, listen: false).getSelectedFoodList();
    List<FoodItem> consumedItems =
        Provider.of<FoodModel>(context, listen: false).getConsumedFoodList();

    if (selectedItems.length > 0) {
      //navigate to creatediet with selected and consumed
      Navigator.pushNamed(context, "/createDiet");
    } else {
      HandleFoodModel handle = HandleFoodModel(email);
      //fetch the selection list from db
      int selectionExist = await handle.updateSelectedFoodListToLocalModel(context);
      //if selectionlist.length>0 navigate to create diet page
      //else navigate to track food page and create the selection list.
      if (selectionExist > 0) {
        handle.updateConsumedFoodListToLocalModel(context);
        Navigator.pushNamed(context, "/createDiet");
      } else {
        Navigator.pushNamed(context, "/food", arguments: TrackFoodArgs({}));
      }
    }
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: GradientDecoration.getDecoration(),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: double.infinity,
                child: Center(
                  child: BarChart1(),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Stack(children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Expanded(
                    child: Card(
                      margin: EdgeInsets.all(20),
                      child: PieChart1(),
                      elevation: 10,
                      color: Color(0xffff9980),
                    ),
                  ),
                  Expanded(
                      child: Card(
                    margin: EdgeInsets.all(20),
                    child: PieChart1(),
                    elevation: 10,
                    color: Color(0xffff9980),
                  )),
                ],
              ),
            ]),
          ),
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: FlatButton(
                onPressed: () {
                  navigateToFoodTracking(context);
                },
                child: ClayContainer(
                  color: Color(0xffffcdb2),
                  depth: 40,
                  child: Center(
                      child: Text(
                    "Track Your Diet",
                    style: TextStyle(
                        color: Color(0xff6d6875),
                        fontSize: 22,
                        fontWeight: FontWeight.w600),
                  )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
