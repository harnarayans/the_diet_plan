import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/types/FoodItem.dart';

class Chips extends StatelessWidget {
  final title;
  Chips({this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
      child: GestureDetector(
        onTap: (){
          Provider.of<FoodModel>(context, listen: false).revertConsumption(this.title);
        },
        child: Container(
          width: MediaQuery.of(context).size.width/3 -10,
          height: 30,
          padding: EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(title, style: TextStyle(
                  color: GradientDecoration.getButtonTextColor(),
                  fontSize: 14
              ),),
              Icon(Icons.close, size: 20,),
            ],
          ),
          color: Color(0XFF79b0f2),
        ),
      ),
    );
  }
}
