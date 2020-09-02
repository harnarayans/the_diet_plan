import 'package:flutter/material.dart';

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
        backgroundColor: Color(0XFF1E1E1E),
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

class TrackFoodArgs{
  final Map<String,List<String>> selectedFoods;
  TrackFoodArgs(this.selectedFoods);
}
