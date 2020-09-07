import 'package:flutter/material.dart';
import 'package:flutter_multi_chip_select/flutter_multi_chip_select.dart';
import 'package:provider/provider.dart';
import 'package:thedietplan/CustomWidgets/FoodTile.dart';
import 'package:thedietplan/models/FoodModel.dart';
import 'package:thedietplan/types/FoodItem.dart';
import 'package:thedietplan/types/FoodState.dart';
import 'package:thedietplan/types/FoodOtions.dart';

class Multi_Select extends StatefulWidget {
  String nutrient;
  Multi_Select(this.nutrient);
  @override
  _Multi_SelectState createState() => _Multi_SelectState();
}

class _Multi_SelectState extends State<Multi_Select> {
  List<String> menuItems=[];
  populateMenu(context){
    List<FoodItem> selectedFoodItems = Provider.of<FoodModel>(context).getSelectedFoodList();
    List<String> selectedFoodNames = selectedFoodItems.map((e) => e.name).toList();
    Map<String,List<String>> foodOptions = FoodOptions.getFoodOptions();
    menuItems = foodOptions[widget.nutrient];
  }
  @override
  Widget build(BuildContext context) {
    populateMenu(context);
    return Row(
      children: <Widget>[
        Expanded(
          child: FlutterMultiChipSelect(
            key: widget.key,
            elements: List.generate(
              menuItems.length,
                  (index) => MultiSelectItem<String>.simple(
                  title: menuItems[index].toString(),
                  value: menuItems[index].toString()),
            ),
            label: "Dropdown Select",
            values: FoodState.getSelectedItems(widget.nutrient),
          ),
        ),
      ],
    );
  }
}