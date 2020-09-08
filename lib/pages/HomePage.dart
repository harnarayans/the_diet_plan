import 'package:flutter/material.dart';
import 'package:thedietplan/CustomWidgets/GradientDecoration.dart';
import 'package:thedietplan/util/sign_in.dart';

import 'subpages/HomePageContent.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text("Your Dashboard", style: TextStyle(color: GradientDecoration.getFontColor()), ),
        centerTitle: true,
        backgroundColor: GradientDecoration.getAppBarColor(),
        iconTheme: IconThemeData(
            color:GradientDecoration.getFontColor()
        ),

        actions: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Icon(Icons.notifications_none),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: GestureDetector(child: Icon(Icons.exit_to_app), onTap: (){
              sign_in().signOutGoogle();
              Navigator.of(context)
                  .pushNamedAndRemoveUntil('/', (Route<dynamic> route) => false);
            },),
          )
        ],
      ),
      body: HomePageContent( ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
