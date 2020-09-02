import 'package:flutter/material.dart';

import 'subpages/CreateDietContent.dart';
import 'subpages/TrackFoodContent.dart';

class CreateDietChart extends StatefulWidget {
  static const routeName = '/extractArguments';
  @override
  _CreateDietChartState createState() => _CreateDietChartState();
}

class _CreateDietChartState extends State<CreateDietChart> {
  @override
  Widget build(BuildContext context) {
    final CreateDietArguments args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Prepare your diet chart"),
        backgroundColor: Color(0XFF1E1E1E),
        iconTheme: IconThemeData(
            color:Color(0XFFC4BFBF)
        ),
        leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        }),
        actions: <Widget>[
        ],
      ),
      body: CreateDietContent( foodItems: args.foodItems, memberFoodList: args.memberFoodItems,), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
