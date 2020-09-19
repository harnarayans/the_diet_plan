import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:thedietplan/CustomWidgets/animated_nutrient.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/types/Nutrition.dart';

class DietProgressIndicator extends StatefulWidget {
  @override
  _DietProgressIndicatorState createState() => _DietProgressIndicatorState();
}

class _DietProgressIndicatorState extends State<DietProgressIndicator> {
  List<Widget> getBoxes(context) {
    List<Nutrition> selectedNutrients =
        Provider.of<FoodModel>(context).getSelectedNutrients();
    List<Nutrition> consumedNutrients =
        Provider.of<FoodModel>(context).getConsumedNutrients();
    List<Widget> boxes = [];
    Set<String> nutrients = {};
    consumedNutrients.forEach((element) {
      nutrients.add(element.name);
      boxes.add(Padding(
        padding: const EdgeInsets.all(8.0),
        child: Animated_Nutrient(element, true),
      ));
    });
    selectedNutrients.forEach((element) {
      if (!nutrients.contains(element.name)) {
        boxes.add(Padding(
          padding: const EdgeInsets.all(8.0),
          child: Animated_Nutrient(element, false),
        ));
      }
    });
    return boxes;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: ListView(
        children: getBoxes(context),
        scrollDirection: Axis.horizontal,
//        runAlignment: WrapAlignment.start,
//        crossAxisAlignment: WrapCrossAlignment.start,
      ),
    );
  }
}
