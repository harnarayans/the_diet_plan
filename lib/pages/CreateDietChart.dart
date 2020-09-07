import 'package:flutter/material.dart';
import 'package:thedietplan/types/CreateDietArguments.dart';

import 'subpages/CreateDietContent.dart';

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
        centerTitle: true,
        backgroundColor: Color(0XFF6d6875),
        iconTheme: IconThemeData(
            color:Color(0XFFC4BFBF)
        ),
        leading: new IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
          Navigator.pop(context);
        }),
        actions: <Widget>[
        ],
      ),
      body: CreateDietContent( ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
