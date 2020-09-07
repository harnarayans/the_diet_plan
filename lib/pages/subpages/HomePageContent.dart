import 'package:clay_containers/clay_containers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/CustomWidgets/BarChart1.dart';
import 'package:thedietplan/CustomWidgets/Dialogs.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/CustomWidgets/PieChart1.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/types/CreateDietArguments.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/types/TrackFoodArgs.dart';

class HomePageContent extends StatefulWidget {
  @override
  _HomePageContentState createState() => _HomePageContentState();
}

class _HomePageContentState extends State<HomePageContent> {
  final GlobalKey<State> _keyLoader = new GlobalKey<State>();
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
      //fetch the selection list from db

      var document = dbReference
          .collection("foods")
          .where("userEmail", isEqualTo: email)
          .where("selection", isEqualTo: true)
          .orderBy("createdAt", descending: true)
          .limit(1);

      document.get().then((QuerySnapshot value) => {
            //if selectionlist.length>0 navigate to create diet page
            //else navigate to track food page and create the selection list.
            if (value.docs.length > 0)
              {
                updateSelectedFoodListToLocalModel(value),
                updateConsumedFoodListToLocalModel(email),
                Navigator.pushNamed(context, "/createDiet"),
              }
            else
              {
                Navigator.pushNamed(context, "/food",
                    arguments: TrackFoodArgs({}))
              }
          });
    }
  }

  void updateSelectedFoodListToLocalModel(value) {
    Map<String, List<String>> selectedFoodList = {};
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
  }

  void updateConsumedFoodListToLocalModel(email) {
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
                  Provider.of<FoodModel>(context,listen: false).setConsumedFoods(consumedFoodList);
                }
              })
            }
        });
  }

//  void navigateToFoodTracking(context) async{
//  if (email != null && email.length > 0) {
//      Map<String, List<String>> selectedFoodList = {};
//      var document = dbReference
//          .collection("foods")
//          .where("userEmail", isEqualTo: email)
//          .where("selection", isEqualTo: true).orderBy("createdAt", descending: true).limit(1);
//      document
//          .get()
//          .then((QuerySnapshot value) => {
//        if (value.docs.length > 0)
//          {
//            value.docs.forEach((element) {
//              Map<String, dynamic> selectedFood =
//              element.data().remove("selectedItems");
//              selectedFood.forEach((key, value) {
//                List<String> selectionList = value.cast<String>();
//                selectedFoodList.putIfAbsent(key, () => selectionList);
//              });
//              if(!navigationCompleted){
//                navigationCompleted = true;
//                getConsumedItemsAndNavigate(
//                    context, selectedFoodList, email);
//              }
//            })
//          }
//        else if(!navigationCompleted){
//          navigationCompleted = true,
//          Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop(),
//          Navigator.pushNamed(context, '/food', arguments: TrackFoodArgs({}))
//        }
//      })
//          .catchError((error) {
//        print("Error while fetching selected foods- $error");
//      });
//    } else {
//      if(!navigationCompleted){
//        navigationCompleted = true;
//        Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
//        Navigator.pushNamed(context, '/food', arguments: TrackFoodArgs({}));
//      }
//    }
//  }
//
//  void getConsumedItemsAndNavigate(context, selectedFoodList, email) async {
//    List<FoodItem> memberFoods = [];
//    bool navigationCompleted = false;
//    var document = dbReference
//        .collection("foods")
//        .where("userEmail", isEqualTo: email)
//        .where("selection", isEqualTo: false).orderBy("createdAt", descending: true).limit(1);
//    await document.get().then((QuerySnapshot value) => {
//      if (value.docs.length == 0 && !navigationCompleted)
//        {
//          navigationCompleted = true,
//          navigateToCreateDietWithConsumedFood(
//              context, selectedFoodList, List<FoodItem>())
//        }
//      else
//        {
//          value.docs.forEach((element) {
//            List<dynamic> foodItems = element.data().remove("foodItems");
//            if (foodItems != null && foodItems.length > 0) {
//              memberFoods = foodItems.map((e) => FoodItem.fromJson(e)).toList();
//              if(!navigationCompleted){
//                navigationCompleted = true;
//                Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
//                navigateToCreateDietWithConsumedFood(
//                    context, selectedFoodList, memberFoods);
//              }
//            } else {
//              if (selectedFoodList.length == 0 && !navigationCompleted) {
//                navigationCompleted = true;
//                Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
//                Navigator.pushNamed(context, '/food', arguments: TrackFoodArgs({}));
//              } else {
//                navigationCompleted = true;
//                Navigator.of(_keyLoader.currentContext,rootNavigator: true).pop();
//                navigateToCreateDietWithConsumedFood(
//                    context, selectedFoodList, List<FoodItem>());
//              }
//            }
//          })
//        }
//    });
//  }
//
//  void navigateToCreateDietWithConsumedFood(
//      context, selectedFoodList, memberFoods) {
//    Provider.of<FoodModel>(context, listen: false)
//        .setSelectedFoods(selectedFoodList);
//    Provider.of<FoodModel>(context, listen: false)
//        .setConsumedFoods(memberFoods);
//    Navigator.pushNamed(context, "/createDiet",
//        arguments: CreateDietArguments(
//            memberFoodItems: memberFoods, foodItems: selectedFoodList));
//  }

  final Color backGroundColor = const Color(0xff72d8bf);

  final Duration animDuration = const Duration(microseconds: 250);

  int touchIndex;

  bool isPlaying = false;

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
                  Dialogs.showLoadingDialog(context, _keyLoader);
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
//          Expanded( flex:1,
//            child: Padding(
//              padding: const EdgeInsets.all(8.0),
//              child: Container(
//                width: double.infinity,
//                child: MaterialButton(
//                  color: Color(0xff6d00fc),
//                  splashColor: Colors.indigoAccent,
//                  onPressed: () {
//                    navigateToFoodTracking(context);
//                  },
//                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
//                  highlightElevation: 10,
//                  child: Text("Record Your Diet", style: TextStyle(
//                    color: Colors.white70,
//                    fontSize: 20,
//                  ),),
//                ),
//              ),
//            ),
//          ),
        ],
      ),
    );
  }
}
