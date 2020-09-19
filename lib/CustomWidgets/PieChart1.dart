import 'dart:convert';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/util/HandleFoodModel.dart';

import 'Indicator.dart';

class PieChart1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart1State();
}

class PieChart1State extends State {
  int touchedIndex;
  double totalSelectedNutrients;
  double totalConsumedNutrients;
  @override
  Widget build(BuildContext context) {
    return  PieChart(
      PieChartData(
          pieTouchData: PieTouchData(touchCallback: (pieTouchResponse) {
            setState(() {
              if (pieTouchResponse.touchInput is FlLongPressEnd ||
                  pieTouchResponse.touchInput is FlPanEnd) {
                touchedIndex = -1;
              } else {
                touchedIndex = pieTouchResponse.touchedSectionIndex;
              }
            });
          }),
          borderData: FlBorderData(
            show: false,
          ),
          sectionsSpace: 0,
          centerSpaceRadius: 40,
          sections: showingSections(context)),
    );
  }

  void updateNutrients() async{
    totalSelectedNutrients = (Provider.of<FoodModel>(context).getSelectedNutrients().length > 0? Provider.of<FoodModel>(context).getSelectedNutrients().length : 10).toDouble();
    totalConsumedNutrients = (Provider.of<FoodModel>(context).getConsumedNutrients().length > 0? Provider.of<FoodModel>(context).getConsumedNutrients().length : 5).toDouble();
  }

  List<PieChartSectionData> showingSections(context) {
    totalSelectedNutrients = 10;
    totalConsumedNutrients = 5;
    updateNutrients();
    print("selected nutri = $totalSelectedNutrients");
    print("consumed = $totalConsumedNutrients");
    return List.generate(2, (i) {
      final isTouched = i == touchedIndex;
      final double fontSize = isTouched ? 20 : 12;
      final double radius = isTouched ? 40 : 30;
      switch (i) {
        case 0:
          return PieChartSectionData(
            color: Colors.yellow,
            value: totalConsumedNutrients,
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        case 1:
          return PieChartSectionData(
            color: const Color(0xff72efdd),
            value: (totalSelectedNutrients - totalConsumedNutrients),
            title: '',
            radius: radius,
            titleStyle: TextStyle(
                fontSize: fontSize, fontWeight: FontWeight.bold, color: const Color(0xffffffff)),
          );
        default:
          return null;
      }
    });
  }
}