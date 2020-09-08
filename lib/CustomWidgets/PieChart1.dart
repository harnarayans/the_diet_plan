import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/models/LoginModel.dart';
import 'package:thedietplan/util/HandleFoodModel.dart';

import 'Indicator.dart';

class PieChart1 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PieChart1State();
}

class PieChart1State extends State {
  int touchedIndex;

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

  List<PieChartSectionData> showingSections(context) {
    String email = Provider.of<LoginModel>(context).email;
    double totalSelectedNutrients = 10;
    double totalConsumedNutrients = 5;
    if(Provider.of<FoodModel>(context, listen: true).getSelectedNutrients().length > 0){
      totalSelectedNutrients = Provider.of<FoodModel>(context, listen: true).getSelectedNutrients().length.toDouble();
    }
    if(Provider.of<FoodModel>(context, listen: true).getSelectedNutrients().length > 0){
      totalConsumedNutrients = Provider.of<FoodModel>(context, listen: true).getConsumedNutrients().length.toDouble();
    }

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