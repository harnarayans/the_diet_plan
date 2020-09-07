import 'package:flutter/material.dart';
import 'package:animations/animations.dart';
import 'package:thedietplan/types/Nutrition.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:provider/provider.dart';



class Animated_Nutrient extends StatefulWidget {
  final Nutrition nutrient;
  bool consumed;
  Animated_Nutrient(this.nutrient, this.consumed);
  @override
  _Animated_NutrientState createState() => _Animated_NutrientState();
}

class _Animated_NutrientState extends State<Animated_Nutrient> {
  bool selected = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selected = !selected;
        });
      },
      child: AnimatedContainer(
        width: selected ? 200 : 20,
        height: 20,
        color: widget.consumed ? widget.nutrient.color: Colors.white70,
        duration: Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
        child: selected? Center(child: Text(widget.nutrient.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),)) : Text(""),
      ),
    );
  }
}
