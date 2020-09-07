import 'package:flutter/material.dart';
import 'package:thedietplan/types/TrackFoodArgs.dart';

import 'subpages/TrackFoodContent.dart';

class TrackFood extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TrackFoodArgs args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Your Diet"),
        centerTitle: true,
        backgroundColor: Color(0XFF6d6875),
        iconTheme: IconThemeData(
            color:Color(0XFFC4BFBF)
        ),
        actions: <Widget>[
        ],
      ),
      body: TrackFoodContent(args.selectedFoods), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
