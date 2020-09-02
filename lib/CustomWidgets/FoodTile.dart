import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/util/FoodPics.dart';
import 'package:thedietplan/util/NutrientColor.dart';

class FoodTile extends StatelessWidget {
  FoodItem item;
  FoodTile(this.item);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/foods/'+FoodPics().getAssetName(item.name)), fit: BoxFit.fill),
          // boxShadow: [BoxShadow(color: Colors.grey, spreadRadius:2.0, blurRadius: 2.0,)],
          borderRadius: BorderRadius.all(Radius.circular(5)),
          border: Border.all(
              color: NutrientColor.getRatingColor(item.caloryRating),
              width: 10,
              style: BorderStyle.solid)),
      child: Center(
        child: Text(item.name),
      ),
    );
  }
}
