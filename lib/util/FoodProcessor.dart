import 'package:flutter/material.dart';
import 'package:multiselectable_dropdown/multiselectable_dropdown.dart';
import 'package:thedietplan/types/FoodOtions.dart';

class FoodProcessor{
  List<MultipleSelectItem> getSelectItems(itemList){
    List<MultipleSelectItem> selectItems = new List<MultipleSelectItem>();
    for( var i=0; i<itemList.length; i++){
      selectItems.add(
        MultipleSelectItem.build(
          value: itemList[i],
          display: itemList[i],
          content: itemList[i],
        ),
      );
    }
    return selectItems;
  }
  Map<String,List<String>> getSelectedItems(){
    return this._selectedValues;
  }
  Map<String,List<String>> _selectedValues = {"Vitamin C":[],
    "Folate":[],
    "Vitamin B":[],
    "Vitamin D":[],
    "Iron":[],
    "Calcium":[],
    "Protein":[],
    "Good Fat":[],
    "Fiber":[]};

  List<Widget> getItemList(Map<String,List<String>> selectedValues){
    if(selectedValues.length>0){
      _selectedValues = selectedValues;
    }
    List<Widget> itemList = new List<Widget>();
    FoodOptions.getFoodOptions().forEach((key, value) {
      itemList.add(
        new Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 5.0),
          child: Row(
            children: <Widget>[
              Container(child: Text(key), width: 65,),
              Expanded(
                child: MultipleDropDown(
                  placeholder: 'Select food items',
                  disabled: false,
                  values: _selectedValues[key],
                  elements: getSelectItems(value),
                ),
              ),
            ],
          ),
        )
      );
    });
    return itemList;
  }
}